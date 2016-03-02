//
//  main.m
//  week1_object
//
//  Created by Lee Kyu-Won on 3/2/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPen.h"
#import "NXFileList.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NXPen *kyooPen = [[NXPen alloc] initRedWithOwnerName: @"Kyoo"];
        [kyooPen printDescriptionOfRed];
     
        
        
        NXFileList *ls = [[NXFileList alloc] init];
        
        //[ls showListUnderDirectory:@"/Users/KateKyuWon/Desktop"];
        //[ls DisplayAllFilesAtPath:@"/Users/KateKyuWon/Desktop" filterByExtension:@"png"];
        [ls DisplayAllFilesAtPath:@"/Users/KateKyuWon/Desktop/nearHoneyTip/NearHoneyTip/NearHoneyTip" filterByExtension:@"m"]; //deep안됨;;
    }
    return 0;
}
