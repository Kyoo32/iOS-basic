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
        self.Q1 = [[NSFileManager alloc] init]; //multi-thread 환경
        //self.Q1 = [NSFileManager defaultManager]; 클래스 매니저, 간단한 상황
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

-(void)DisplayAllFilesAtPath:(NSString*)path
           filterByExtension:(NSString*)extension{
    
    NSArray* result = [self.Q1 contentsOfDirectoryAtPath:path error:NULL];
    int count = [result count];
    int extensionLength = [extension length];
    int resultStringLength = NULL;
    
    for(int i = 0; i < count; i++){
        resultStringLength = [result[i] length];
        //NSLog(@"!!!!%@", [result[i] substringFromIndex:(resultStringLength-extensionLength )]);
                      
        if([[result[i] substringFromIndex:(resultStringLength-extensionLength )] isEqualToString : extension]){
            NSLog(@"%@", result[i]);
            };
    }


    return;
}

@end

/* search 
 contents search => array returns => if big, memory and time hurt // almost simple case better
 enumerator search => just enumerates and works // supplys deep-search
*/
 
