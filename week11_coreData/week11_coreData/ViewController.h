//
//  ViewController.h
//  week11_coreData
//
//  Created by Lee Kyu-Won on 5/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXDataManager.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDelegate>

@property (nonatomic, strong) NXDataManager *dm;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

