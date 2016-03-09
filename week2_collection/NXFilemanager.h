//
//  NXFilemanager.h
//  week2_collection
//
//  Created by Lee Kyu-Won on 3/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXFilemanager : NSObject

@property NSFileManager *Q1;

- (instancetype)init;
- (NSData*)makeDataFromPath:(NSString*)path;
- (NSArray*)getStringComponentFromData:(NSData*)data;


@end
