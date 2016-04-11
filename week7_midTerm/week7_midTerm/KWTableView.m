//
//  KWTableView.m
//  week7_midTerm
//
//  Created by Lee Kyu-Won on 4/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "KWTableView.h"

@implementation KWTableView


-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if(event.type == UIEventTypeMotion){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"resetArray" object:nil];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
