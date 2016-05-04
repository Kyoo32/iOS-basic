//
//  SketchViewController.m
//  week10_mulitTouch
//
//  Created by Lee Kyu-Won on 5/4/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "SketchViewController.h"
#import "NumberSketchBookView.h"

@implementation SketchViewController{
    NSMutableArray *points;
}


-(void)viewDidLoad{
     _myview = [[NumberSketchBookView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    NSLog(@"myview : %@",_myview);
    [self.view addSubview:_myview];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(judgeNumberOne) name:@"judgeNumberOne" object:_myview];
}

-(void)judgeNumberOne{
    points = _myview.touchPoints;
    int pointCount = [points count];
    /*  숫자 1 판단 조건
     1. 웬만하면 세로로 그리라는 조건
        시작점 끝점의 y차이가 x차이보다 크거나 같다
     2. 웬만하면 직선으로 그리라는 조건
        시작점 끝점 위치인 직선에 비해, 각각 점갯수 대비 위치 지점의 점들이 시작점 끝점x,y차이 1.5배 미만 떨어져있다.
     */
    
    CGPoint start;
    [points[0] getValue:&start];
    CGPoint end;
    [points[pointCount-1] getValue:&end];
    
    float xDis = fabs(end.x - start.x);
    float yDis = fabs(end.y - start.y);
    
    if( yDis - xDis < 0) {
        [self showAlertWithMessage:@"1 아님"];
        return;
    }
    
    CGPoint current;
    for(int i = 1 ; i < pointCount - 1; i++){
        [points[i] getValue:&current];
        
        float startXdis = fabs(current.x - start.x);
        float startYdis = fabs(current.y - start.y);
//        float endXdis = fabs(current.x - end.x);
//        float endYdis = fabs(current.y - end.y);
        
        
        float xPivot = xDis * ((float)i / pointCount);
        float yPivoit = yDis * ((float)i / pointCount);
        
        NSLog(@"%f %f %f %f %f %f", xDis, yDis, startXdis, xPivot, startYdis, yPivoit);
        
        if( startXdis > xPivot * 5 || startYdis > yPivoit * 5){
            [self showAlertWithMessage:@"1 아님"];
            return;
        }
        
    }
    
    [self showAlertWithMessage:@"1 이다"];
    
}

-(void)showAlertWithMessage:(NSString*)message{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:@"결과"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        
    });
}




@end
