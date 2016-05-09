//
//  NXSong.h
//  week11_database
//
//  Created by Lee Kyu-Won on 5/9/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kTitle;
extern NSString* const kImage;
extern NSString* const kCategory;


@interface NXSong : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *category;

@end
