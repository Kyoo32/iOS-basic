//
//  FirstViewController.h
//  week3_viewWithJson
//
//  Created by Lee Kyu-Won on 3/16/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIImagePickerControllerDelegate>


@property UIImagePickerController *ipc;
//@property UIPopoverController *popover;


@property (weak, nonatomic)  IBOutlet UIButton *btnCameraroll;

@property (weak, nonatomic) IBOutlet UIImageView *chosenImg;


@end

