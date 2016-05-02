//
//  MYView.m
//  week10_mulitTouch
//
//  Created by Lee Kyu-Won on 5/2/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "MYView.h"

@implementation MYView{
    CGPoint start;
    CGPoint end;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //required!!!!
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [[event allTouches] anyObject];
    start = [touch locationInView:self];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];

    
    UITouch *touch = [[event allTouches] anyObject];
    end = [touch locationInView:self];

    self.alpha = [self alphaByDistance];
    
    //[self setNeedsDisplay];
}

-(CGFloat)alphaByDistance{
    
    int powDistance =  (end.y - start.y)*(end.y - start.y) + (end.x - start.x)*(end.x - start.x);
    int squrtDistance = sqrt(powDistance);
    
    return  ((200 - squrtDistance) / 200.0) ;
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];

    
    self.alpha = 1;
    if([[event allTouches]count] == 2){
        self.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:(arc4random()%256)/255.0];
    }
    
    UITouch *touch = [[event allTouches] anyObject];
    if(  [touch tapCount] == 2){
        self.backgroundColor = [UIColor whiteColor];
    } else if([ touch tapCount] == 3){
        self.backgroundColor = [UIColor blackColor];
    }
    
    NSLog(@"view touch");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches
               withEvent:(UIEvent *)event{
    
    [super touchesCancelled: touches withEvent:event];
    self.alpha = 1;
}

@end
