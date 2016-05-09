//
//  MasterViewController.m
//  week11_database
//
//  Created by Lee Kyu-Won on 5/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "NXSong.h"

@interface MasterViewController (){
    sqlite3 *db;
    char *zErrMsg;
}
    


@property NSMutableArray<NXSong*> *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    _objects = [[NSMutableArray alloc]init];
    NSBundle *topTable = [[NSBundle mainBundle] pathForResource: @"top25" ofType: @"db"];
    NSString *databasePath = [[NSBundle mainBundle] pathForResource:@"top25" ofType:@"db"];
    char *path = [databasePath cStringUsingEncoding:1];
   // NSLog(@"%@", topTable);
    
    if(topTable){
        
        
        if( sqlite3_open(path, &db) == SQLITE_OK){
            
            sqlite3_stmt *statement;
            NSString *querySQL = @"SELECT * FROM tbl_songs";
            
            const char *query_stmt = [querySQL UTF8String];
            
            if(sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL) == SQLITE_OK){
                
                NSLog(@"yes3 : sql function in progress");
                /* COLUME_NUM & property
                 0 - id / int
                 1 - title / text
                 2 - category / text
                 3 - image / text
                 */
                
                while(sqlite3_step(statement) <= SQLITE_ROW){
                     NSLog(@"yes3 : sql function in reading");
                    NXSong *newSong = [NXSong alloc];
                    NSString *text = [[NSString alloc]initWithUTF8String:(const char*) sqlite3_column_text(statement, 1)];
                    [newSong setValue:text forKey:kTitle];
                    text = [[NSString alloc]initWithUTF8String:(const char*) sqlite3_column_text(statement, 2)];
                    [newSong setValue:text forKey:kCategory];
                    text = [[NSString alloc]initWithUTF8String:(const char*) sqlite3_column_text(statement, 3)];
                    [newSong setValue:text forKey:kImage];
                    
                    
                    [_objects addObject:newSong];

                }
                
                sqlite3_finalize(statement);
            }
            
            //_status.text = @"SQL doesn't work";
            
            sqlite3_close(db);
        }

    }
    
    NSLog(@"%@", _objects);
    
}
    


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NXSong *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   // if(indexPath.row == 0) return NULL;
   
    cell.textLabel.text = [self.objects[indexPath.row] valueForKey:kTitle];
    cell.detailTextLabel.text =  [self.objects[indexPath.row] valueForKey:kCategory];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43;
}

@end
