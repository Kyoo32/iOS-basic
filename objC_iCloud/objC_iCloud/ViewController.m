//
//  ViewController.m
//  objC_iCloud
//
//  Created by Lee Kyu-Won on 4/8/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *dirPaths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docsDir = dirPaths[0];
    NSString *dataFile = [docsDir stringByAppendingPathComponent:@"document.doc"];
   
    
    
    _documentURL = [NSURL fileURLWithPath:dataFile];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    /* //for local data
    _document = [[MyDocument alloc] initWithFileURL:_documentURL];
    _document.userText = @"";
  
    
    if([filemgr fileExistsAtPath:dataFile]){
            [_document openWithCompletionHandler:^(BOOL success) {
                if(success){
                    NSLog(@"Opened");
                    _textView.text = _document.userText;
                } else {
                    NSLog(@"Not Opened");
                }
            }];
    } else {
        [_document saveToURL:_documentURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if(success){
                NSLog(@"Created");
            } else {
                NSLog(@"Not Created");
            }
        }];
    }
    
    */
    
    /////////////for iCloud
    [filemgr removeItemAtPath:(NSString*)_documentURL error:NULL];
    
    _ubiquityURL = [[filemgr URLForUbiquityContainerIdentifier:nil] URLByAppendingPathComponent:@"Documents"];
    
    if([filemgr fileExistsAtPath:[_ubiquityURL path]] == NO ){
        [filemgr createDirectoryAtPath:(NSString*) _ubiquityURL withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    _ubiquityURL = [_ubiquityURL URLByAppendingPathComponent:@"document.doc"];
    
    // iCloud에서 문서 검색
    
    _metadataQuery = [[NSMetadataQuery alloc] init];
    [_metadataQuery setPredicate:[NSPredicate predicateWithFormat:@"%K like 'document.doc'", NSMetadataItemFSNameKey]];
    [_metadataQuery setSearchScopes:[NSArray arrayWithObjects:NSMetadataQueryUbiquitousDocumentsScope,nil]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(metadataQueryDidFinishGathering:) name:NSMetadataQueryDidFinishGatheringNotification object:_metadataQuery];
    
    [_metadataQuery startQuery];

}

- (void)metadataQueryDidFinishGathering:(NSNotification*)notification{
    NSMetadataQuery *query = [notification object];
    [query disableUpdates];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSMetadataQueryDidFinishGatheringNotification object:query];
    
    [query stopQuery];
    NSArray *result = [[NSArray alloc] initWithArray:[query results]];
    
    if([result count] == 1){
        _ubiquityURL = [result[0] valueForAttribute:NSMetadataItemURLKey];
        
        
        _document = [[MyDocument alloc] initWithFileURL: _ubiquityURL];
        
        [_document openWithCompletionHandler:^(BOOL success) {
            if(success){
                NSLog(@"Opened iCloud doc");
                _textView.text = _document.userText;
            } else {
                NSLog(@"Failed to open iCloud doc");
            }
        }];
    } else {
        _document = [[MyDocument alloc] initWithFileURL:_ubiquityURL];
        
        [_document saveToURL:_ubiquityURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if(success){
                NSLog(@"Saved to iCloud");
            } else {
                NSLog(@"Failed to save cloud");
            }
        }];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveDocument:(id)sender {
    
    _document.userText = _textView.text;
    /* //for local data
    [_document saveToURL:_documentURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        if(success){
            NSLog(@"Saved for overwriting");
        } else {
            NSLog(@"Not saved for overwriting");
        }
    }]
     
     */
    
    [_document saveToURL:_ubiquityURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        if(success){
            NSLog(@"Saved to iCloud for overwriting");
        } else {
            NSLog(@"Not saved to Cloud for overwriting");
        }
    }];

    
    
}
@end
