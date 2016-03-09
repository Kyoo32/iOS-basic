
//
//  NXPen.m
//  week1_object
//
//  Created by Lee Kyu-Won on 3/2/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXPen.h"

@implementation NXPen

/*
 -(id)initWithBrand:(NSString*)brand{
    self = [super init];
    if(self){
    ~
    }
    return self;
 }
 */



-(id)initRedWithOwnerName:(NSString*)OwnerName{
    self = [super init];
    if (self) {
        [self._brand init];
        [self._color init];
        [self._ownerName init];
        [self setUsage: 100];
        [self setColor: @"red"];
        [self setBrandname: @"sarasa"];
        
        //주인이름빼고 모두 답정너 초기화 메소드
        //다양한 초기화 메소드 추가 예정.......
        
        [self setOwnerName:OwnerName];
    }
    return self;

};

-(void)printDescriptionOfRed{
    
    NSLog(@"The pen is a red product of %@, and belongs to %@", [self brandname], [self ownerName]);
    
}


//brandName
- (NSString *)brandname
{
    
    return self._brand;
}

- (void)setBrandname:(NSString *)value
{
    self._brand = value;
} //brandname




//color
- (NSString *)color
{
    return self._color;
}

- (void)setColor:(NSString *)value
{
    self._color = value;
} //color



//usage
- (NSUInteger )usage
{
    return self._usage;
}

- (void)setUsage:(NSUInteger)value
{
    if(value < 0 || value > 100){
        NSLog(@"Wrong value for Usage");
        return;
    }
    self._usage = value;
    
} //usage



//ownerName
- (NSString *)ownerName
{
    return self._ownerName;
}

- (void)setOwnerName:(NSString *)value
{
    self._ownerName = value;
} //ownerName


@end
