//
//  DetailViewController.h
//  week8_CFStreamCam
//
//  Created by Lee Kyu-Won on 4/20/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UIImageView *camView;
@property UIImage *camViewImage;


- (void)createOutputStream:(NSString*)hostAddress;

@end

