//
//  main.m
//  week1_object
//
//  Created by Lee Kyu-Won on 3/2/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPen.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NXPen *kyooPen = [[NXPen alloc] initRedWithOwnerName: @"Kyoo"];
        [kyooPen printDescriptionOfRed];
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
