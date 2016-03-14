//
//  NXDetailViewController.m
//  week3_tapVC
//
//  Created by Lee Kyu-Won on 3/14/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXDetailViewController.h"

@interface NXDetailViewController ()

@end

@implementation NXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"2-1. view did load");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"2-2.first view will appear");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"2-3.first view did appear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"2-5.first view did disappear");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"2-4. first view will disappear");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
