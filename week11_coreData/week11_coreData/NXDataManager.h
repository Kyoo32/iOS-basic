//
//  NXDataManager.h
//  week11_coreData
//
//  Created by Lee Kyu-Won on 5/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface NXDataManager : NSObject <NSFetchedResultsControllerDelegate>

@property(nonatomic, strong) NSFetchedResultsController *frc;

+(NXDataManager*)sharedDataManager; //DataManager is a singleton.
-(instancetype)initWithManagedObjectContext:(NSManagedObjectContext*)context andSortKey:(NSString*)key;

- (NSFetchedResultsController *)fetchedResultsController;
- (void)insertNewObjectName:(NSString*)name andId:(int)idInteger andGender:(bool)gender andGrade:(NSUInteger)grade;
@end
