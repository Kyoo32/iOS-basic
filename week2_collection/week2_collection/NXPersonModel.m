//
//  NXPersonModel.m
//  week2_collection
//
//  Created by Lee Kyu-Won on 3/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXPersonModel.h"

@implementation NXPersonModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.personNameArray = [[NSMutableArray alloc] init];
        self.personNumberArray = [[NSMutableArray alloc] init];
        self.personTeamNumberArray = [[NSMutableArray alloc] init];
        self.personSexArray = [[NSMutableArray alloc] init];
        self.personDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}


@end
