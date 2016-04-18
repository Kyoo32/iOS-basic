//
//  KWViewController.m
//  week7_midTerm
//
//  Created by Lee Kyu-Won on 4/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "KWAlbumViewController.h"


@interface KWAlbumViewController ()<NSURLConnectionDataDelegate>{
    int sortBy; //0 is basic, 1 is by date.
    NSMutableData *imageData;
    UIImage *finishedImage;
}
@end

@implementation KWAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableReload) name:@"dataSet" object:_dataModel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableReloadWithResetData) name:@"dataReset" object:_dataModel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableReload) name:@"sortByDate" object:_dataModel];
    
    imageData = [[NSMutableData alloc] init];
    
    
    _dataModel = [[KWAlbumModel alloc] init];
    sortBy = 0;
   
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    //[_tableView registerClass:[KWTableViewCell class] forCellReuseIdentifier:@"Cell"];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"finish");
    finishedImage = [UIImage imageWithData:imageData];
    
};
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [imageData appendData:data];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSLog(@"CAAALLLLL MEEEE");
    if(!sortBy){
        return 1;
    } else {
        return _dataModel.countYear;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if(!sortBy) {
        return [_dataModel.albumArray count];
    } else {
        //NSLog(@"\n\nhow many:  %ld\n\n", [[_dataModel.yearCountBucket[section] valueForKey:@"count"]integerValue]);
        return [[_dataModel.yearCountBucket[section] valueForKey:@"count"]integerValue];
    }
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(!sortBy) return (UIView*)NULL;
    
    //NSLog(@"\n\n\nzzzzzzzzzzzzzzzzzz\n\n\n\n");
    // 1. The view for the header
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    
    // 2. Set a custom background color and a border
    headerView.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    headerView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    headerView.layer.borderWidth = 1.0;
    
    // 3. Add a label
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(5, 2, tableView.frame.size.width - 5, 18);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
    headerLabel.text = [_dataModel.yearCountBucket[section] valueForKey:@"year"];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    
    // 4. Add the label to the header view
    [headerView addSubview:headerLabel];
    
    // 5. Finally return
    return headerView;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   
    NSLog(@"INDEXPATH : %@ \n\n", indexPath);
    //NSLog(@"CELL :: %@",cell);
    //NSLog(@"CELL  title :: %@",cell.titleLabel);
    
    if(!sortBy){
        
        //1.
        //cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:[_dataModel.albumArray[indexPath.row] valueForKey:@"image" ]]];
        
        NSString *baseString = @"http://125.209.194.123/demo/";
        NSURL *url = [NSURL URLWithString:[baseString stringByAppendingString:[_dataModel.albumArray[indexPath.row] valueForKey:@"image"]]];
        /*
        //2.
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        cell.backgroundView = [[UIImageView alloc] initWithImage:finishedImage];
       */
        //3.
        cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
        
        
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@" , [_dataModel.albumArray[indexPath.row] valueForKey:@"title"]];
        cell.detailLabel.text = [NSString stringWithFormat:@"%@" , [_dataModel.albumArray[indexPath.row] valueForKey:@"date"]];
    } else {
        NSString *kRow = [NSString stringWithFormat:@"%ld" ,(long)indexPath.row ];
        
        
        /*
        //1.
        cell.backgroundView =[[UIImageView alloc] initWithImage: [UIImage imageNamed:[[_dataModel.yearCountBucket[indexPath.section] valueForKey: kRow] valueForKey: @"image"]]];
        */
        //2.
        NSString *baseString = @"http://125.209.194.123/demo/";
        NSURL *url = [NSURL URLWithString:[baseString stringByAppendingString:[[_dataModel.yearCountBucket[indexPath.section] valueForKey: kRow] valueForKey: @"image"]]];
        cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:url]]];
        
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@" , [[_dataModel.yearCountBucket[indexPath.section] valueForKey:kRow] valueForKey:@"title"]];
        cell.detailLabel.text = [NSString stringWithFormat:@"%@" , [[_dataModel.yearCountBucket[indexPath.section] valueForKey:kRow]  valueForKey:@"date"]];
        
    }
     cell.backgroundView.contentMode =  UIViewContentModeCenter;
    return cell;
}



- (IBAction)sortByDate:(id)sender {
    
    sortBy = 1;
    
    NSSortDescriptor *dateSorter = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSLog(@"ds : %@",dateSorter);
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateSorter];
    NSLog(@"sd : %@", sortDescriptors);
    NSMutableArray *sortedArray = [_dataModel.albumArray mutableCopy];
    [sortedArray sortUsingDescriptors:sortDescriptors];
    
    NSLog(@"Sorted!! : %@", sortedArray);
    _dataModel.albumArray = sortedArray;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortByDate" object:nil];
}

-(void)tableReloadWithResetData{
    sortBy = 0;
    [self.tableView reloadData];
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
        if(!sortBy){
            [controller setDetailItem: _dataModel.albumArray[indexPath.row]];
        } else {
            NSString *kRow = [NSString stringWithFormat:@"%ld" ,(long)indexPath.row ];
            [controller setDetailItem: [ _dataModel.yearCountBucket[indexPath.section] valueForKey:kRow]];
        }
        
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
