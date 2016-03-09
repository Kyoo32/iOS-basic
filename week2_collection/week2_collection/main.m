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

        //NXPersonGroup *iOSstudentGroup = [[NXPersonGroup alloc] init];
        NXFilemanager *hello = [[NXFilemanager alloc] init];
        NSData*  raw = [hello makeDataFromPath:@"/Users/KateKyuWon/Desktop/persons.txt"];
        NSLog(@"%@", raw);
        
        NXPersonModelManager *world = [[NXPersonModelManager alloc] init];
        [world initNXPersonModelWithStringComponent: [hello getStringComponentFromData:raw]];
        
    
        NSLog(@"person name at 3 : %@ ", [world personNameAtIndex:2]);
        if([world isMaleAtIndex:0]){
            NSLog(@"is Male at 3? yes" );
        }
        //NSLog((@"person number at 1: %@", [world personNumberAtIndex: 3]));
        
        
        NSLog(@"Dic : %@", [world getPersonObjectAtIndex:0]);
        
        
        
        
        
        NSLog(@"person name of 141059 : %@", [world findPersonNameByNumber:@141059]);
        //NSLog(@"person number of 임은주 : %@", [world findPersonNameByNumber:@"임은주"]);
        
        NSLog(@"%@", [world sortedByName]);
        NSLog(@"%@",[world sortedByNumber]);

    }
    return 0;
}
