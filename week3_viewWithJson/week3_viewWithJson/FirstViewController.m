//
//  FirstViewController.m
//  week3_viewWithJson
//
//  Created by Lee Kyu-Won on 3/16/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "FirstViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface FirstViewController (){
   
}
@end

@implementation FirstViewController
- (IBAction)selectPhoto:(id)sender {
    
    NSLog(@"11111111111111111");
    
    self.ipc= [[UIImagePickerController alloc] init];
    self.ipc.delegate = self;
    
    if( [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] ){
        self.ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:self.ipc animated:YES completion:nil];
}
- (IBAction)takePhoto:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
        
        ipc.delegate = self;
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.mediaTypes = [NSArray arrayWithObject:(NSString*) kUTTypeImage];
        
        [self presentViewController:ipc animated:YES completion:nil];
    }
    
}

-(void)image:(UIImage*)image finishedSavingWithError:(NSError*) error contextInfo:(void*)contextInfo{
    if(error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle : @"Save failed" message : @"Failed to save image/video" delegate : nil cancelButtonTitle : @"Ok" otherButtonTitles: nil];
        [alert show];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    
    if([mediaType isEqualToString:(NSString*) kUTTypeImage] ){
        UIImage *chosenImage = [info objectForKey: UIImagePickerControllerOriginalImage] ;
        
        NSLog(@"333333333333333 %@", chosenImage);

        self.chosenImg.image = chosenImage;
    } else if ([mediaType isEqualToString:(NSString*) kUTTypeMovie]){
        //in the case of video.
    }
    
    [self.ipc dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    NSLog(@"44444444");

    
    [self.ipc dismissViewControllerAnimated:YES completion:NULL];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
