//
//  MasterViewController.h
//  week8_CFStreamCam
//
//  Created by Lee Kyu-Won on 4/20/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSStreamDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;


-(void) readRequestToServer:(NSString*)hostAddress;
@end

