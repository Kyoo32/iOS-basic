//
//  ViewController.m
//  week7_midTerm
//
//  Created by Lee Kyu-Won on 4/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "KWDetailViewController.h"

@interface KWDetailViewController ()

@end

@implementation KWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleLabel.text =[_clickedItem valueForKey:@"title"];
    _imageDetail.image = [UIImage imageNamed:[_clickedItem valueForKey:@"image"]];
    _detailLabel.text = [_clickedItem valueForKey:@"date"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setDetailItem:(NSDictionary*)item{
    NSLog(@"SETting");
    
    _clickedItem = item;
}

@end
