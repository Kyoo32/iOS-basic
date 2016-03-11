//
//  NXPersonGroupManager.h
//  week2_collection
//
//  Created by Lee Kyu-Won on 3/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPersonModel.h"

@interface NXPersonModelManager : NSObject

@property NXPersonModel* next;


-(void)initNXPersonModelWithStringComponent:(NSArray*)component;



- (int)personCount; //added after class finished
- (NSDictionary*)makeOnePersonAtIndex:(int)index; //added after class finished
- (void)makePersonModelDictionary; //added after class finished

- (NSString*)personNameAtIndex:(int)index;
- (NSNumber*)personNumberAtIndex:(int)index;
- (BOOL)isMaleAtIndex:(int)index;
- (NSNumber*)personTeamAtIndex:(int)index;
- (NSDictionary*)getPersonObjectAtIndex:(int)index;
- (NSString*) findPersonNameByNumber:(NSNumber*)number;
- (NSNumber*) findPersonNumberByName:(NSString*)name;

- (NSArray*) sortedByName;
- (NSArray*) sortedByNumber;
- (NSArray*) sortedByTeam;


- (NSArray*) filterByTeam:(NSNumber*)team;
- (NSArray*) filterByGender:(BOOL)isMale;
- (NSSet*) filterDistinctByLastName;

@end
