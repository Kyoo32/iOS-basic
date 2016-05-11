//
//  NXDataManager.m
//  week11_coreData
//
//  Created by Lee Kyu-Won on 5/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXDataManager.h"

@implementation NXDataManager{
    NSManagedObjectContext *myContext;
    
}

+(NXDataManager*)sharedDataManager{
    static NXDataManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(instancetype)initWithManagedObjectContext:(NSManagedObjectContext*)context andSortKey:(NSString*)key{
    self = [super init];
    if(self){
        
        myContext = context;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        // Configure the request's entity, and optionally its predicate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        //[sortDescriptors release];
        //[sortDescriptor release];
        
       _frc = [[NSFetchedResultsController alloc]
                                                  initWithFetchRequest:fetchRequest
                                                  managedObjectContext:context
                                                  sectionNameKeyPath:nil
                                                  cacheName:@"Qcache"];
        
        // [fetchRequest release];
        _frc.delegate = self;
        
        NSError *error = nil;
        if (![_frc performFetch:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return self;
}


- (NSFetchedResultsController *)fetchedResultsController
{
    if (_frc != nil) {
        return _frc;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:myContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:myContext sectionNameKeyPath:nil cacheName:@"Qcache"];
    aFetchedResultsController.delegate = self;
    _frc = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _frc;
}    



- (void)insertNewObjectName:(NSString*)name andId:(int)idInteger andGender:(bool)gender andGrade:(NSUInteger)grade{
    
    
    NSManagedObjectContext *context = [_frc managedObjectContext];
    NSEntityDescription *entity = [[_frc fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:name forKey:@"name"];
    [newManagedObject setValue:[NSNumber numberWithInteger:idInteger] forKey:@"id"];
    [newManagedObject setValue:[NSNumber numberWithBool:gender] forKey:@"gender"];
    [newManagedObject setValue:[NSNumber numberWithInteger:grade] forKey:@"grade"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:{
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndexwithRowAnimation:UITableViewRowAnimationFade];
            NSString *sectionString = [NSString stringWithFormat:@"%lu", (unsigned long)sectionIndex];
            NSDictionary *info = @{ @"sectionIndex" : sectionString};
          //  [[NSNotificationCenter defaultCenter] postNotificationName:@"insert" object:self userInfo:info ];
            break;
        }
        case NSFetchedResultsChangeDelete:{
            //[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            NSString *sectionString = [NSString stringWithFormat:@"%lu", (unsigned long)sectionIndex];
            NSDictionary *info = @{ @"sectionIndex" : sectionString};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"delete" object:self userInfo:info ];
            break;
        }
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    //UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:{
            
            NSDictionary *info = @{ @"indexPath" : newIndexPath};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"insert" object:self userInfo:info ];
           // [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete:
            //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            //[self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            //[tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

@end
