//
//  EditViewController.m
//  week11_coreData
//
//  Created by Lee Kyu-Won on 5/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "EditViewController.h"
#import "NXDataManager.h"

@implementation EditViewController


-(void)viewDidLoad{
    _dm = [NXDataManager sharedDataManager];
    
    
}

- (IBAction)saveNewStudent:(id)sender {
    NSLog(@"save clicked");
    
    [_dm insertNewObjectName: _nameFied.text andId:[_idField.text integerValue] andGender:_genderSwitch.on andGrade:[_gradeField.text integerValue]];
    
}
@end
