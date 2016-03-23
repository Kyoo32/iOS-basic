//
//  baduk.m
//  week4_Alfago
//
//  Created by Lee Kyu-Won on 3/23/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "baduk.h"

@implementation baduk{
    int count;
    NSMutableArray* checkStonePut;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        checkStonePut = [self setCheckStonePutArray];
        count = 0;
        NSLog(@"!! %@ ?? %d", checkStonePut ,count);
    }
    return self;

}


- (NSMutableArray*)setCheckStonePutArray{
  
    return[ @[ [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy],
               [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy],
               [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy],
               [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy],
               [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy],
               [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy],
               [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy],
               [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy],
               [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy],
               [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy],
               [@[ @0, @0, @0, @0, @0, @0, @0, @0, @0, @0, @0] mutableCopy]
            ] mutableCopy];
    
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
     
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect backgroundRect = CGRectMake(0, 0, 320, 480);
    [self.background drawInRect:backgroundRect];
    
    CGContextSetLineWidth(context, 1);
    for(int i = 0; i < 11 ; i++){
        CGContextMoveToPoint(context, 20, 42 + 28*i);
        CGContextAddLineToPoint(context, 300, 42 + 28*i);
        CGContextMoveToPoint(context, 20 +28*i, 	42);
        CGContextAddLineToPoint(context, 20 +28*i, 322);
    }
    
    CGContextStrokePath(context);

    
    for(int i = 0 ; i < 11 ; i++){
        for (int j = 0 ; j < 11 ; j++){
            if([checkStonePut[i][j]  isEqual: @1]){
                [self.blackStone drawInRect: CGRectMake(6 + 28*i, 28+28*j, 28, 28)];
            } else if ( [checkStonePut[i][j]  isEqual: @2] ){
                [self.whiteStone drawInRect: CGRectMake(6 + 28*i,  28 + 28*j, 28, 28)];
            }
            
            
        }
    }
    
    
    //CGContextStrokePath(context);

}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if(event.type == UIEventTypeMotion){
        NSLog(@"shake!!!!!");
        checkStonePut = [self setCheckStonePutArray];
        count = 0;
        [self setNeedsDisplay];
        return;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];

    
    
    CGPoint location = [touch locationInView:self];
    
    NSLog(@" x: %f , y :%f", location.x , location.y);
    if( location.x < 20 || location.x > 328 || location.y < 30 || location.y > 330) return;
    
    int xElement = (int)location.x / 28;
    int yElement = (int)(location.y -28) / 28;
   
    NSLog(@"xe : %d , ye : %d", xElement ,yElement);
    
   
    if( xElement > 10 || yElement > 10 || ![checkStonePut[xElement][yElement]  isEqual: @0]) return;
    
    if(count % 2 == 0){
        checkStonePut[xElement][yElement] = @1;
    } else {
        checkStonePut[xElement][yElement] = @2;
    }
    
    
    
    NSLog(@"%@",
          checkStonePut[xElement][yElement] );
    count++;
    
    [self setNeedsDisplay];

}




- (void)awakeFromNib{
    self.background = [UIImage imageNamed:@"ockBG.png"];
    self.whiteStone = [UIImage imageNamed:@"white.png"];
    self.blackStone = [UIImage imageNamed:@"black.png"];
    
}

@end
