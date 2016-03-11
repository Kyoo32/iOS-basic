//
//  NXPersonGroupManager.m
//  week2_collection
//
//  Created by Lee Kyu-Won on 3/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXPersonModelManager.h"

@implementation NXPersonModelManager{
    int studentCount;
}

-(void)initNXPersonModelWithStringComponent:(NSArray*)component{
    
    self.next = [[NXPersonModel alloc] init];
    
    
    studentCount = [component count] / 4;
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
    
    NSString* searchingindex = [NSString stringWithFormat:@"%d", index];
    return [self.next.personDictionary objectForKey:searchingindex];

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
        else if ([obj1 integerValue] < [obj2 integerValue]) {
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


- (NSArray*) sortedByTeam{
    //방법1
    //사전에서 objects만 가져오기. 가져온 오브젝트사전의 'teamnumber'키 값으로 정렬하기.
    //NSArray *sortedArray = [[self.next.personDictionary allValues] sortedArrayUsingComparator
    
    
    
    //방법2 - 그냥 팀번호만 나열
    NSMutableArray *inProcess = [[NSMutableArray alloc]init];
    
    
    return [self.next.personTeamNumberArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    
    //return nil;
}


- (NSUInteger*)personCount{
    return studentCount;
}

-(NSDictionary*)makeOnePersonAtIndex:(int)index{
    return [[NSDictionary alloc] initWithObjectsAndKeys:[self.next.personNameArray objectAtIndex:index], @"name", [self.next.personNumberArray objectAtIndex:index], @"number", [self.next.personSexArray objectAtIndex:index], @"sex", [self.next.personTeamNumberArray objectAtIndex:index], @"teamNumber", nil];
}

- (void)makePersonModelDictionary{
    
    NSString *numberToStringTemp;
    for(int i = 0 ; i < studentCount ; i++){
        numberToStringTemp = [NSString stringWithFormat:@"%d", i];
        [self.next.personDictionary  setObject: [self makeOnePersonAtIndex:i] forKey:numberToStringTemp];
    }
    
    
}

- (NSArray*) filterByTeam:(NSNumber*)team{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    int i = 0;
    
    for(NSNumber* num in self.next.personTeamNumberArray){
        if([num compare:team] == NSOrderedSame){
            [result addObject:[self.next.personDictionary objectForKey: [NSString stringWithFormat:@"%d",i]]];
        }
        i++;
    }
    return result;
}
- (NSArray*) filterByGender:(BOOL)isMale{
    NSMutableArray* result = [[NSMutableArray alloc] init];
    int i = 0;
    NSString* fig;
    if(isMale == YES){
        fig = @"M";
    } else {
        fig = @"F";
    }
    
    for(NSString* sex in self.next.personSexArray){
        if([sex isEqualToString: fig] == YES){
            [result addObject:[self.next.personDictionary objectForKey: [NSString stringWithFormat:@"%d",i]]];
        }
        i++;
    }
    return result;
}
- (NSSet*) filterDistinctByLastName{
    
    NSMutableSet* result = [[NSMutableSet alloc] init];
    
    for(NSString* name in self.next.personNameArray){
        
        NSString* lastName = [name substringToIndex:1];
        
        [result addObject:[NSString stringWithUTF8String: [lastName UTF8String]]];
        
    }
    return result;
    
}




@end
