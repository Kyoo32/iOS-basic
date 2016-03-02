//
//  NXFileList.h
//  week1_object
//
//  Created by Lee Kyu-Won on 3/2/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXFileList : NSObject

@property (strong, nonatomic) NSFileManager* Q1;

-(void)showListUnderDirectory:(NSString*)DirectoryPath;

@end
