//
//  DetailViewController.m
//  week11_database
//
//  Created by Lee Kyu-Won on 5/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        //self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self configureView];
   
    NSURL *photoUrl = [NSURL URLWithString:[_detailItem valueForKey:kImage]];
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:photoUrl];
    NSLog(@"loading start");
    [_myWebView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
