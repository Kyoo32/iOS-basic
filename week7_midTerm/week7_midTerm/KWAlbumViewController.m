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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableReload) name:@"sortByDate" object:_dataModel];
    _dataModel = [[KWAlbumModel alloc] init];
    
   
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
    cell.backgroundView.contentMode =  UIViewContentModeCenter;
    
    
    //cell.backgroundColor = [UIImage imageNamed:@"01"];
   
   cell.titleLabel.text = [NSString stringWithFormat:@"%@" , [_dataModel.albumArray[indexPath.row] valueForKey:@"title"]];
    cell.detailLabel.text = [NSString stringWithFormat:@"%@" , [_dataModel.albumArray[indexPath.row] valueForKey:@"date"]];
    return cell;
}



- (IBAction)sortByDate:(id)sender {
    
    NSSortDescriptor *dateSorter = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateSorter];
    NSMutableArray *sortedArray = [_dataModel.albumArray mutableCopy];
    [sortedArray sortUsingDescriptors:sortDescriptors];
    
    NSLog(@"Sorted!! : %@", sortedArray);
    _dataModel.albumArray = sortedArray;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortByDate" object:nil];
}

-(void)tableReload{
    NSLog(@"reload!!!!");
    [self.tableView reloadData];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     NSLog(@"\n\nhello1");
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSLog(@"\n\nhello2");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        KWDetailViewController *controller = (KWDetailViewController *)[segue destinationViewController] ;
        
        NSLog(@"passing %@",  _dataModel.albumArray[indexPath.row]);
        [controller setDetailItem: _dataModel.albumArray[indexPath.row]];
        
        
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
