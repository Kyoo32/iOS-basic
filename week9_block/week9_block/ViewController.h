//
//  ViewController.h
//  week9_block
//
//  Created by Lee Kyu-Won on 4/25/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightC;
@property IBOutlet UIProgressView* progressBar;

- (IBAction)firstBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

- (IBAction)bookButtonClicked:(id)sender;





@end

