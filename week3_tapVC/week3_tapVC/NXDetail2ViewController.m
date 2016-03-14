//
//  NXDetail2ViewController.m
//  week3_tapVC
//
//  Created by Lee Kyu-Won on 3/14/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXDetail2ViewController.h"

@interface NXDetail2ViewController ()

@end

@implementation NXDetail2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"3-1.third did load");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"3-2. view will appear");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"3-3. view did appear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"3-5. view did disappear");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"3-4. view will disappear");
}



- (IBAction)goToRoot:(id)sender{
    [[self navigationController] popToRootViewControllerAnimated:NO];
    
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
