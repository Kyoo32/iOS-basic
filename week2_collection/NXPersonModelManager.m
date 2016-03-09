//
//  NXPersonGroupManager.m
//  week2_collection
//
//  Created by Lee Kyu-Won on 3/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXPersonModelManager.h"

@implementation NXPersonModelManager

-(void)initNXPersonModelWithStringComponent:(NSArray*)component{
    
    self.next = [[NXPersonModel alloc] init];
    
    
    int studentCount = [component count] / 4;
    int j = 0;
    
    for(int i = 0; i<studentCount; i++)
    {
        [self.next.personNameArray addObject:component[j++]];
        [self.next.personNumberArray addObject: [NSNumber numberWithInteger: [component[j++] integerValue]]];
        [self.next.personSexArray addObject:component[j++]];
        [self.next.personTeamNumberArray addObject:[NSNumber numberWithInteger: [component[j++] integerValue]]];
        
        
    }
    
    //NSLog(@"%@", self.next.personNameArray);
    //NSLog(@"%@", self.next.personNumberArray);
    

}



- (NSString*)personNameAtIndex:(int)index{
    return [self.next.personNameArray objectAtIndex:index];
    
}
- (NSNumber*)personNumberAtIndex:(int)index{
    return [self.next.personNumberArray objectAtIndex:index];
}
- (BOOL)isMaleAtIndex:(int)index{
    if( [[self.next.personSexArray objectAtIndex:index] isEqualToString:@"M"]){
        return true;
    }else{
        return false;
    }
}

- (NSNumber*)personTeamAtIndex:(int)index{
    return [self.next.personTeamNumberArray objectAtIndex:index];
}




- (NSDictionary*)getPersonObjectAtIndex:(int)index{
    return [[NSDictionary alloc] initWithObjectsAndKeys:[self.next.personNameArray objectAtIndex:index], @"name", [self.next.personNumberArray objectAtIndex:index], @"number", [self.next.personSexArray objectAtIndex:index], @"sex", [self.next.personTeamNumberArray objectAtIndex:index], @"teamNumber", nil];
}
/*
objectforkey : dictionary
valueforkey: deep-search supplies
*/

///find

- (NSString*) findPersonNameByNumber:(NSNumber*)number{
    return [self.next.personNameArray objectAtIndex:[self.next.personNumberArray indexOfObject:number]];
    
}
- (NSNumber*) findPersonNumberByName:(NSString*)name{
    return [self.next.personNumberArray objectAtIndex:[self.next.personNameArray indexOfObject:name]];
}


///sort
- (NSArray*) sortedByName{
    return [self.next.personNameArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
}
- (NSArray*) sortedByNumber{
    return [self.next.personNumberArray sortedArrayUsingSelector: @selector(compare:)];
}

/*
 mutable-collection fits collection, not vise versa.
 1. [collection mutable copy];
 2. [mutable-collection alloc and initwith-collection];
 */


//yet
- (NSArray*) sortedByTeam{
    return nil;
}


@end
