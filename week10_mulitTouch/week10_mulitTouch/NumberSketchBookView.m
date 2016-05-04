//
//  NumberScatchBookView.m
//  week10_mulitTouch
//
//  Created by Lee Kyu-Won on 5/4/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NumberSketchBookView.h"

@implementation NumberSketchBookView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
   self =  [super initWithCoder:aDecoder];
    if(self){
        _touchPoints = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //required!!!!
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, self.bounds);
   // [self resetArray];
    [super touchesBegan:touches withEvent:event];
     NSLog(@"view drawing start");
    if ([touches count] != 1) {
        _isSuccess = NO;
        return;
    }
    UITouch *touch = [[event allTouches] anyObject];
    [_touchPoints addObject:touch];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    //if(_isSuccess == NO) return;
    UITouch *touch = [[event allTouches] anyObject];
    [_touchPoints addObject:touch];
    [self setNeedsDisplay];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    
   // if(_isSuccess == NO) return;
    UITouch *touch = [[event allTouches] anyObject];
    [_touchPoints addObject:touch];
    
    NSLog(@"view drawing end");
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches
               withEvent:(UIEvent *)event{
    
    [super touchesCancelled: touches withEvent:event];
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    
    if([_touchPoints count] > 0){
        CGContextMoveToPoint(context, [_touchPoints[0] locationInView:self].x, [_touchPoints[0] locationInView:self].y);
        
        for(int i = 1; i < [_touchPoints count] ; i++){
            CGContextAddLineToPoint(context, [_touchPoints[i] locationInView:self].x, [_touchPoints[i] locationInView:self].y);
        }
    }
    
    CGContextStrokePath(context);

}

-(void)resetArray{
    [_touchPoints removeAllObjects];
}

@end
