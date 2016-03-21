//
//  MyView.m
//  week4_forView
//
//  Created by Lee Kyu-Won on 3/21/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

 - (void)drawRect:(CGRect)rect {
     CGContextRef context = UIGraphicsGetCurrentContext();
     
     
     CGGradientRef gradient = [self gradient];
     CGPoint startPoint
     = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
     CGPoint endPoint
     = CGPointMake(CGRectGetMidX(self.bounds),
                   CGRectGetMaxY(self.bounds));
     CGContextDrawLinearGradient(context, gradient,
                                 startPoint, endPoint, 0);
     //CGGradientRelease(gradient);
     
     int rand1;
     int rand2;
     int rand3;
     int rand4;
     
     srand(time(0));
     
     for(int i = 0; i < 10; i++){
         rand1 = arc4random() % (int)CGRectGetMaxX(self.bounds);
         rand2 = arc4random() % (int)CGRectGetMaxY(self.bounds);
         rand3 = arc4random() % (int)CGRectGetMaxX(self.bounds);
         rand4 = arc4random() % (int)CGRectGetMaxY(self.bounds);
         
         UIBezierPath *path = [UIBezierPath bezierPath];
         CGPoint pathStartPoint = CGPointMake(rand1, rand2);
         [path moveToPoint:pathStartPoint];
         CGPoint nextPoint = CGPointMake(rand3, rand4);
         [path addLineToPoint:nextPoint];
         [path setLineWidth:10.0];
         
         rand4 = rand4 % 3 * 10;

         if(i == rand4){
             [[UIColor grayColor] setStroke];
         }
         [path stroke];
         if(i == rand4){
             [[UIColor blackColor] setStroke];
         }

         
         rand1 = rand1 * 3 % (int)CGRectGetMaxX(self.bounds);
         rand2 = rand2 * 7 % (int)CGRectGetMaxY(self.bounds);
         CGPoint center = CGPointMake((float)rand1, (float)rand2);
         
         rand3 = rand3 % 10;
         rand1 = rand1 % 100;
         UIBezierPath *arch = [UIBezierPath bezierPathWithArcCenter:center radius:rand1 startAngle:0 endAngle:(float)(2*3.14) clockwise:YES];
         [arch setLineWidth:(float)rand3];
         
         
         [[UIColor colorWithRed:drand48() green:drand48()  blue:drand48() alpha:drand48()]setFill];
         [arch fill];
         //[arch stroke];
     }
     
 }


//uiview has this method.
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self setNeedsDisplay];
}



- (CGGradientRef) gradient{
  
    NSArray *colors = [[NSArray alloc] initWithObjects:[UIColor yellowColor].CGColor, [UIColor brownColor].CGColor, nil];
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB() ,(CFArrayRef)colors,  NULL); //colorspace and component.
    
    return gradient;
};


@end
