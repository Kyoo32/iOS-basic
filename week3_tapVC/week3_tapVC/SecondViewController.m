//
//  SecondViewController.m
//  week3_tapVC
//
//  Created by Lee Kyu-Won on 3/14/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NXFilemanager* newed = [[NXFilemanager alloc] init];
    NSData* raw = [newed makeDataFromPath:@"/Users/KateKyuWon/Desktop/persons.txt"];
    self.iOSLecture = [NXPersonModelManager alloc];
    [self.iOSLecture initNXPersonModelWithStringComponent: [newed getStringComponentFromData:raw]];
    NSLog(@"%@",raw);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)searchedName:(id)sender {
    NSLog(@"RESULT: %@", [self.iOSLecture findPersonNumberByName:self.searchingName.text]);
    if([self.iOSLecture findPersonNumberByName:self.searchingName.text]){
    self.resultOfNumber.text = [NSString stringWithFormat:@"%@", [self.iOSLecture findPersonNumberByName:self.searchingName.text] ];
    }else {
        self.resultOfNumber.text = @"결과 없음";
    }
}
- (IBAction)showAllName:(id)sender {

    NSString *result = [[self.iOSLecture sortedByName] componentsJoinedByString:@", "];
    UIAlertController* alertC = [UIAlertController alertControllerWithTitle:@"All name" message:result preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alertC addAction:defaultAction];
    [self presentViewController:alertC animated:YES completion:nil];
    
}
@end
