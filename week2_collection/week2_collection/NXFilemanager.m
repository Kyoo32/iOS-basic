//
//  NXFilemanager.m
//  week2_collection
//
//  Created by Lee Kyu-Won on 3/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXFilemanager.h"

@implementation NXFilemanager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Q1 = [NSFileManager defaultManager];     }
    return self;
}

- (NSData*)makeDataFromPath:(NSString*)path{
    
    return [self.Q1 contentsAtPath:path];
    
}

- (NSArray*)getStringComponentFromData:(NSData*)data{
    
    NSString *rawString = [[NSString alloc] initWithData:data encoding:4];
    NSLog(@"%@", rawString);
    
    NSArray* rawComponent = [rawString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",\n"]];
    NSLog(@"\n\n\nHERE!\n%@",rawComponent);
    
    return rawComponent;
}




@end
