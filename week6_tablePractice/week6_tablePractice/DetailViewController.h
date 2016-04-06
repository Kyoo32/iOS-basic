//
//  DetailViewController.h
//  week6_tablePractice
//
//  Created by Lee Kyu-Won on 4/4/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

