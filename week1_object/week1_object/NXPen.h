//
//  NXPen.h
//  week1_object
//
//  Created by Lee Kyu-Won on 3/2/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPen : NSObject

@property (strong, nonatomic)NSString* _ownerName;

@property (strong, nonatomic)NSString* _brand;
@property (strong, nonatomic)NSString* _color;
@property NSUInteger _usage;

-(id)initRedWithOwnerName:(NSString*)OwnerName;
-(void)printDescriptionOfRed;

@end


/*
@interface NSPen : NSObject {
    NSString* _brand; //변수명은 일반적으로 _를 붙인다.
}
-(NSString*)brand;
-(void)setBrand:(NSString*)brand;
 
 
*/
