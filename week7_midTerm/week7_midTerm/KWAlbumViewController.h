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


@interface KWAlbumViewController : UIViewController

@property KWAlbumModel *dataModel;
@property KWTableView *tableView;

-(void)tableReload;

@end
