//
//  NumberScatchBookView.m
//  week10_mulitTouch
//
//  Created by Lee Kyu-Won on 5/4/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NumberSketchBookView.h"

@implementation NumberSketchBookView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        NSLog(@"what");
        _touchPoints = [[NSMutableArray alloc]init];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
   self =  [super initWithCoder:aDecoder];
    if(self){
        _touchPoints = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resetArray];
    [super touchesBegan:touches withEvent:event];
     NSLog(@"1. view drawing start %@", _touchPoints);
   
    UITouch *touch = [[event allTouches] anyObject];
    [_touchPoints addObject:[NSValue valueWithCGPoint:[touch locationInView:self]]];
    NSLog(@"view drawing start %@", _touchPoints);

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    [_touchPoints addObject:[NSValue valueWithCGPoint:[touch locationInView:self]]];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    [_touchPoints addObject:[NSValue valueWithCGPoint:[touch locationInView:self]]];
    NSLog(@"view drawing end");
    [self setNeedsDisplay];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"judgeNumberOne" object:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"judgeNumberTwo" object:self];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"judgeNumberThree" object:self];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches
               withEvent:(UIEvent *)event{
    [super touchesCancelled: touches withEvent:event];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextClearRect(context, [self bounds]);
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    
    if([_touchPoints count] > 0){
        CGPoint location;
        [_touchPoints[0] getValue:&location];
        CGContextMoveToPoint(context,location.x, location.y);
        
        for(int i = 1; i < [_touchPoints count] ; i++){
            [_touchPoints[i] getValue:&location];
            CGContextAddLineToPoint(context,location.x, location.y);
            
        }
    }
    CGContextStrokePath(context);
}

-(void)resetArray{
    NSLog(@"reset");
    [_touchPoints removeAllObjects];
}

@end
