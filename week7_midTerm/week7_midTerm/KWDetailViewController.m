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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setDetailItem:(NSArray*)item{
    _titleLabel.text = [item valueForKey:@"title"];
    _imageDetail.image = [UIImage imageNamed:[item valueForKey:@"image"]];
    _detailLabel.text = [item valueForKey:@"date"];
}

@end
