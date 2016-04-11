//
//  KWViewController.h
//  week7_midTerm
//
//  Created by Lee Kyu-Won on 4/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KWAlbumModel.h"
#import "KWTableView.h"
#import "KWTableViewCell.h"
#import "KWDetailViewController.h"

@interface KWAlbumViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet KWTableView *tableView;

@property KWAlbumModel *dataModel;

- (IBAction)sortByDate:(id)sender;

-(void)tableReload;

@end
