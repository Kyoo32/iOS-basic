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


@end
