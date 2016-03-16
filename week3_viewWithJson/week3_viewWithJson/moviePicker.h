//
//  moviePicker.h
//  week3_viewWithJson
//
//  Created by Lee Kyu-Won on 3/16/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface moviePicker : NSObject{
    NSData* movieRaw;
    
}

@property NSArray* movieBase;


//- (void)arrayToDictinary;
- (NSDictionary*)itemAtIndex:(int)index;



@end
