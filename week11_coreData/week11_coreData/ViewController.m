//
//  ViewController.m
//  week11_coreData
//
//  Created by Lee Kyu-Won on 5/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _dm = [NXDataManager sharedDataManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insert:) name:@"insert" object:_dm];
    //            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndexwithRowAnimation:UITableViewRowAnimationFade];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}

-(void)insert:(NSNotification*)notification{
    NSLog(@"reload %@",notification.userInfo);
    //[self.tableview insertRowsAtIndexPaths:@[[notification.userInfo valueForKey:@"indexPath"]]  withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_dm.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [_dm.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSManagedObject *object = [_dm.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:object];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [_dm.fetchedResultsController managedObjectContext];
        [context deleteObject:[_dm.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object {
    NSLog(@"%@",object);
    cell.textLabel.text = [object valueForKey:@"name" ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
