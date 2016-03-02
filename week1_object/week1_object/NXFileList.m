//
//  NXFileList.m
//  week1_object
//
//  Created by Lee Kyu-Won on 3/2/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXFileList.h"

@implementation NXFileList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Q1 = [[NSFileManager alloc] init];
    }
    return self;
}

-(void)showListUnderDirectory:(NSString*)DirectoryPath{

    NSArray* result = [self.Q1 contentsOfDirectoryAtPath:DirectoryPath error:NULL];
    int count = [result count];
    
    for(int i = 0; i < count; i++){
        NSLog(@"%@", result[i]);
    }
    
    
    return;
}


@end
