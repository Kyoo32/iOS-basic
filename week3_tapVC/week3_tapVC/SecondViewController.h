//
//  SecondViewController.h
//  week3_tapVC
//
//  Created by Lee Kyu-Won on 3/14/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXPersonModelManager.h"
#import "NXFilemanager.h"

@interface SecondViewController : UIViewController


@property NXPersonModelManager* iOSLecture;

@property (weak, nonatomic) IBOutlet UITextField *searchingName;
- (IBAction)searchedName:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *resultOfNumber;
- (IBAction)showAllName:(id)sender;

@end

