//
//  ViewController.m
//  week10_mulitTouch
//
//  Created by Lee Kyu-Won on 5/2/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ViewController.h"
#import "checkGestureRecognizer.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    checkGestureRecognizer *myCheck = [[checkGestureRecognizer alloc]initWithTarget:self action: @selector(didChecked:)];
    
    myCheck.delaysTouchesBegan = NO;
    myCheck.delaysTouchesEnded = NO;
    
    [self.view addGestureRecognizer:myCheck];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)showAlertWithMessage:(NSString*)message{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:@"체크 확인"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        
    });
}


-(void)didChecked:(checkGestureRecognizer*)recognizer{
    NSLog(@"success?");
    
    if(recognizer.goWell == true){
        NSLog(@"success");
        [self showAlertWithMessage:@"체크 하셨습니다."];
    }
    //[recognizer reset];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
