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
    int countBlackStoneInColumn[11];
    int countWhiteStoneInColumn[11];
    int touchedRow;
    int touchedColumn;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        checkStonePut = [self setCheckStonePutArray];
        count = 0;
        [self setAllAsZeroCArray:countBlackStoneInColumn ToSize:11];
        [self setAllAsZeroCArray:countWhiteStoneInColumn ToSize:11];
        touchedRow = 30;
        touchedColumn = 30;
       
    }
    return self;

}

- (void)setAllAsZeroCArray:(int*)arr ToSize:(int) size{
    if(!arr) return;
    
    for(int i = 0 ; i<size ; i++){
        arr[i] = 0;
    }
    
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
        
        
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextMoveToPoint(context, 20, 42 + 28*i);
        CGContextAddLineToPoint(context, 300, 42 + 28*i);
        if( i == touchedRow ) CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextStrokePath(context);

        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextMoveToPoint(context, 20 +28*i, 42);
        CGContextAddLineToPoint(context, 20 +28*i, 322);
        if( i == touchedColumn ) CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextStrokePath(context);
    }
    
    

    
    for(int i = 0 ; i < 11 ; i++){
        for (int j = 0 ; j < 11 ; j++){
            if([checkStonePut[i][j]  isEqual: @1]){
                [self.blackStone drawInRect: CGRectMake(6 + 28*i, 28+28*j, 28, 28)];
                
                
            } else if ( [checkStonePut[i][j]  isEqual: @2] ){
                [self.whiteStone drawInRect: CGRectMake(6 + 28*i,  28 + 28*j, 28, 28)];
                
            }
            
            
        }
    }
    
    for(int i = 0 ; i < 11 ; i++){
        int blackMore = countBlackStoneInColumn[i] - countWhiteStoneInColumn[i];
        if(blackMore == 0) continue;
        
        if(blackMore > 0){
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextAddRect(context, CGRectMake(6 +28*i, 480 - 28*blackMore, 28, 28*blackMore));
        } else {
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextAddRect(context, CGRectMake(6 +28*i, 480 - 28*(-blackMore), 28, 28*(-blackMore)));
        }
        CGContextFillPath(context);
    }
    
    //CGContextFillPath(context);
    
    
    
    

}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if(event.type == UIEventTypeMotion){
        NSLog(@"shake!!!!!");
        checkStonePut = [self setCheckStonePutArray];
        count = 0;
        [self setAllAsZeroCArray:countBlackStoneInColumn ToSize:11];
        [self setAllAsZeroCArray:countWhiteStoneInColumn ToSize:11];
        [self setNeedsDisplay];
        return;
    }
}


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInView:self];
    
    NSLog(@"BEGIN x: %f , y :%f", location.x , location.y);
    if( location.x < 20 || location.x > 328 || location.y < 30 || location.y > 330) return;
    
    int xElement = (int)location.x / 28;
    int yElement = (int)(location.y -28) / 28;

    if( xElement > 10 || yElement > 10 || ![checkStonePut[xElement][yElement]  isEqual: @0]) return;

    touchedColumn = xElement;
    touchedRow = yElement;
    
    [self setNeedsDisplay];

}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInView:self];
    
    NSLog(@"MOVE x: %f , y :%f", location.x , location.y);
    if( location.x < 20 || location.x > 328 || location.y < 30 || location.y > 330) return;
    
    int xElement = (int)location.x / 28;
    int yElement = (int)(location.y -28) / 28;
    
    if( xElement > 10 || yElement > 10 || ![checkStonePut[xElement][yElement]  isEqual: @0]) return;
    
    touchedColumn = xElement;
    touchedRow = yElement;
    
    [self setNeedsDisplay];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInView:self];
    
    NSLog(@"END x: %f , y :%f", location.x , location.y);
    if( location.x < 20 || location.x > 328 || location.y < 30 || location.y > 330) return;
    
    int xElement = (int)location.x / 28;
    int yElement = (int)(location.y -28) / 28;
   
    NSLog(@"xe : %d , ye : %d", xElement ,yElement);
    
   
    if( xElement > 10 || yElement > 10 || ![checkStonePut[xElement][yElement]  isEqual: @0]) return;
    
    if(count % 2 == 0){
        checkStonePut[xElement][yElement] = @1;
        countBlackStoneInColumn[xElement]++;
    } else {
        checkStonePut[xElement][yElement] = @2;
        countWhiteStoneInColumn[xElement]++;
    }
    
    
    NSLog(@"%@",
          checkStonePut[xElement][yElement] );
    count++;
    
    [self setNeedsDisplay];
    
    touchedColumn = 30;
    touchedRow = 30;

}


- (void)awakeFromNib{
    self.background = [UIImage imageNamed:@"ockBG.png"];
    self.whiteStone = [UIImage imageNamed:@"white.png"];
    self.blackStone = [UIImage imageNamed:@"black.png"];
    
}

@end
