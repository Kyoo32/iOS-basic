//
//  KWViewController.m
//  week7_midTerm
//
//  Created by Lee Kyu-Won on 4/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "KWAlbumViewController.h"

@interface KWAlbumViewController ()

@end

@implementation KWAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableReload) name:@"dataSet" object:_dataModel];
    _dataModel = [[KWAlbumModel alloc] init];
    
    //_tableView = [[KWTableView alloc]init];
    //[_tableView setDelegate:self];
    [_tableView setDataSource:self];
    //[_tableView registerClass:[KWTableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    NSLog(@"TABLE VIEW : %@", _tableView);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"CAAALLLLL MEEEE");
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"how many:  %lu",(unsigned long)[_dataModel.albumArray count]);
    return [_dataModel.albumArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSLog(@"CELL :: %@",cell);
    NSLog(@"CELL  title :: %@",cell.titleLabel);
    
    cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:[_dataModel.albumArray[indexPath.row] valueForKey:@"image" ]]];
    
    
    //cell.backgroundColor = [UIImage imageNamed:@"01"];
   
   cell.titleLabel.text = [NSString stringWithFormat:@"%@" , [_dataModel.albumArray[indexPath.row] valueForKey:@"title"]];
    cell.detailLabel.text = [NSString stringWithFormat:@"%@" , [_dataModel.albumArray[indexPath.row] valueForKey:@"date"]];
    return cell;
}



-(void)tableReload{
    NSLog(@"reload!!!!");
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSLog(@"\n\nhello");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        KWDetailViewController *controller = (KWDetailViewController *)[[segue destinationViewController] topViewController];
        
        NSLog(@"passing %@",  _dataModel.albumArray[indexPath.row]);
        [controller setDetailItem: _dataModel.albumArray[indexPath.row]];
                                                                             
        //controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
