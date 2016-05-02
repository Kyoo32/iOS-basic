//
//  checkGestureRecognizer.m
//  week10_mulitTouch
//
//  Created by Lee Kyu-Won on 5/2/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "checkGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>


@implementation checkGestureRecognizer{
    CGPoint start;
    CGPoint ground;
    CGPoint end;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    if ([touches count] != 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
    
    UITouch* touch = [[event allTouches] anyObject];
    start = [touch locationInView:self.view];
    
}



- (void)touchesMoved:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
    
    [super touchesMoved:touches withEvent:event];
    if (self.state == UIGestureRecognizerStateFailed) return;
    
    UITouch *touch =  [[event allTouches] anyObject];
    CGPoint previous = [touch previousLocationInView: self.view];
    CGPoint current = [touch locationInView:self.view];
    
    if( (current.y - previous.y) > 0 && (current.x - previous.x) > 0 ){
        _goWell = false;
    } else if(((current.y - previous.y) < 0 && (current.x - previous.x) > 0) &&(previous.y - start.y) > 0 && (previous.x - start.x) > 0 ){
        ground = previous;
        _goWell = true;
    }
    
 //  NSLog(@"gesture touch ground :  %f, %f", ground.x, ground.y);

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if(_goWell == false) return;
    
    UITouch *touch = [[event allTouches] anyObject];
    end = [touch locationInView:self.view];
    
    if ((self.state == UIGestureRecognizerStatePossible) && ((end.y - ground.y) < 0 && (end.x - ground.x) > 0 )) {
        self.state = UIGestureRecognizerStateRecognized;
    }
   
    
  // NSLog(@"gesture touch end: %f %f", end.x, end.y);
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches
               withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateFailed;
    [self reset];
}


-(void)reset{
    
    start = CGPointMake(0, 0);
    ground = CGPointMake(0, 0);
    end = CGPointMake(0, 0);
    _goWell = false;
   
}

@end
