//
//  main.m
//  week2_collection
//
//  Created by Lee Kyu-Won on 3/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXFilemanager.h"
#import "NXPersonModelManager.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NXFilemanager *hello = [[NXFilemanager alloc] init];
        NSData*  raw = [hello makeDataFromPath:@"/Users/KateKyuWon/Desktop/persons.txt"];
        //NSLog(@"%@", raw);
        NXPersonModelManager *world = [[NXPersonModelManager alloc] init];
        [world initNXPersonModelWithStringComponent: [hello getStringComponentFromData:raw]];
        //NSLog(@"how many people? %d", [world personCount]); //added after class finished
        [world makePersonModelDictionary]; //added after class finished
        NSLog(@"person dic %@", world.next.personDictionary );
        
        
    
        
        NSLog(@"person name at 2 : %@ ", [world personNameAtIndex:2]);
        if([world isMaleAtIndex:0]){
            NSLog(@"is Male at 2? yes" );
        }
        //NSLog((@"person number at 1: %@", [world personNumberAtIndex: 3]));  //??????
        
        NSLog(@"tean number of the person at index 2 : %@", [world.next.personTeamNumberArray objectAtIndex:2]);
        NSLog(@"Dic : %@", [world getPersonObjectAtIndex:0]);
        
        
        
        
        /* <find> */
        NSLog(@"person name of 141059 : %@", [world findPersonNameByNumber:@141059]);
        //NSLog(@"person number of 임은주 : %@", [world findPersonNameByNumber:@"임은주"]);  ///?????
        
    
        /* <sort> */
        NSLog(@"%@", [world sortedByName]);
        NSLog(@"%@",[world sortedByNumber]);
        NSLog(@"%@", [world sortedByTeam]);

    }
    return 0;
}
