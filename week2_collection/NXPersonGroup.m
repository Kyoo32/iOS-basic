//
//  NXPersonGroup.m
//  week2_collection
//
//  Created by Lee Kyu-Won on 3/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXPersonGroup.h"

@implementation NXPersonGroup


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.personArray = [[NSMutableArray alloc] init];
        self.personDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}


@end
