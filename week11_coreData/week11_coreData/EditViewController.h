//
//  EditViewController.h
//  week11_coreData
//
//  Created by Lee Kyu-Won on 5/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NXDataManager.h"

@interface EditViewController : UIViewController

@property (nonatomic, strong) NXDataManager *dm;


@property (weak, nonatomic) IBOutlet UITextField *nameFied;
@property (weak, nonatomic) IBOutlet UITextField *idField;
@property (weak, nonatomic) IBOutlet UISwitch *genderSwitch;
@property (weak, nonatomic) IBOutlet UITextField *gradeField;
- (IBAction)saveNewStudent:(id)sender;

@end
