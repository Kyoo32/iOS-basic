//
//  ViewController.h
//  objC_iCloud
//
//  Created by Lee Kyu-Won on 4/8/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDocument.h"
@interface ViewController : UIViewController

@property NSURL *documentURL;
@property MyDocument *document;


@property NSURL *ubiquityURL; //for iCloud
@property NSMetadataQuery *metadataQuery; //for iCloud


@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)saveDocument:(id)sender;

- (void)metadataQueryDidFinishGathering:(NSNotification*)notification;
@end

