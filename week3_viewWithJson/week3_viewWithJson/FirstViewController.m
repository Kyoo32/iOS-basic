//
//  FirstViewController.m
//  week3_viewWithJson
//
//  Created by Lee Kyu-Won on 3/16/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController (){
   
}
@end

@implementation FirstViewController
- (IBAction)selectPhoto:(id)sender {
    
    NSLog(@"11111111111111111");
    
    self.ipc= [[UIImagePickerController alloc] init];
    self.ipc.delegate = self;
    self.ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:self.ipc animated:YES completion:nil];
//    else
//    {
//        popover=[[UIPopoverController alloc]initWithContentViewController:self.ipc];
//        [popover presentPopoverFromRect:self.btnCameraroll.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    }

    // - See more at: http://www.theappguruz.com/blog/ios-image-picker-controller#sthash.PNJnO2FN.dpuf
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    
    UIImage *chosenImage1 = [info objectForKey: UIImagePickerControllerOriginalImage] ;
    
    NSLog(@"333333333333333 %@", chosenImage1);

    self.chosenImg.image = chosenImage1;
    
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
