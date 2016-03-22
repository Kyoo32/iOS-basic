//
//  BasicDraw.m
//  week4_forView
//
//  Created by Lee Kyu-Won on 3/22/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "BasicDraw.h"

@implementation BasicDraw

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    return self;
}

 - (void)drawRect:(CGRect)rect {
   
     //context
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSetLineWidth(context, 2.0);
     
     //color 1: space, component
//     CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
//     CGFloat components[] = {0.0, 1.0, 0.0, 1.0};
//     CGColorRef color = CGColorCreate(colorspace, components);
// 
//     CGContextSetStrokeColorWithColor(context, color);
     
     
    //color 2: UIColor
     CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
     
     //draw a line
     CGContextMoveToPoint(context, 30, 30);
     CGContextAddLineToPoint(context, 300, 400);
     CGContextStrokePath(context);
     
     
     
     //draw a diamond
     CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
     CGContextMoveToPoint(context, 100, 100);
     CGContextAddLineToPoint(context, 150, 150);
     CGContextAddLineToPoint(context, 100, 200);
     CGContextAddLineToPoint(context, 50, 150);
     CGContextAddLineToPoint(context, 100, 100);
     CGContextStrokePath(context);
     
     //draw a rect
     CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
     CGRect rectangle = CGRectMake(150, 60, 20, 80);
     CGContextAddRect(context, rectangle);
     CGContextStrokePath(context);
     
     //draw an ellipse
     CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
     CGRect ellipse = CGRectMake(200, 400, 60, 30);
     CGContextAddEllipseInRect(context, ellipse);
     CGContextStrokePath(context);

     
     
     //draw a filled diamond
     CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
     CGContextMoveToPoint(context, 300, 300);
     CGContextAddLineToPoint(context, 280, 280);
     CGContextAddLineToPoint(context, 260, 300);
     CGContextAddLineToPoint(context, 280, 320);
     CGContextAddLineToPoint(context, 300, 300);
     CGContextFillPath(context);

     //draw a filed ellipse
     CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
     CGRect ellipse2 = CGRectMake(270, 450, 25, 25);
     CGContextAddEllipseInRect(context, ellipse2);
     CGContextStrokePath(context);
     CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
     CGContextFillEllipseInRect(context, ellipse2);
     
     
     //draw an arch, a curve, a quadcurve
     CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
     CGContextMoveToPoint(context, 80, 370);
     CGContextAddArcToPoint(context, 80, 400, 140, 400, 30);
     
     CGContextMoveToPoint(context, 10, 300);
     CGContextAddCurveToPoint(context, 40, 310, 50, 350, 60, 360);
     
     CGContextMoveToPoint(context, 10, 400);
     CGContextAddQuadCurveToPoint(context, 150, 380, 300, 400);
     
     
     CGContextStrokePath(context);
     
     

     
     
     
     
     //release
     // CGColorSpaceRelease(colorspace);
     // CGColorRelease(color);
 
 
 }


@end
