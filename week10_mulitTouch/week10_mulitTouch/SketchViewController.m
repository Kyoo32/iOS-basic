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



//스케치 뷰 컨트롤러는 뷰의 터치 점 콜렉션을 가져와 숫자인지, 숫자라면 어떤 숫자인지 판단합니다.

-(void)viewDidLoad{
     _myview = [[NumberSketchBookView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    NSLog(@"myview : %@",_myview);
    [self.view addSubview:_myview];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(judgeNumberOne) name:@"judgeNumberOne" object:_myview];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(judgeNumberTwo) name:@"judgeNumberTwo" object:_myview];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(judgeNumberThree) name:@"judgeNumberThree" object:_myview];
    
    // 숫자 인식하는 매소드 10개를 다 만들면, 노티 하나에 selector는 judgeNumber로 합니다. //일단 1,2,3
    // judgeNumber는 judgeNumberZero, judgeNumberOne,... , judgeNumberNine을 병렬처리 합니다.
    // judgeNumberN의 구조는 같습니다.  뷰의 터치 점 콜렉션을 판단하여 숫자 N인지 판단합니다. 맞으면 맞다는 메세지가 담긴, 아니라면 아니라는 메세지의 알림창을 보냅니다.
}

-(void)judgeNumberThree{
    points = _myview.touchPoints;
    int pointCount = [points count];
    /* 숫자 3 판단 과정
     
     숫자 3은 아치도형 두개가 이어진 모양이다.
        1. 먼저 아치도형 두개를 구분하는 지점(분리점)을 찾는다.:x값이 증가하는 도입, 두번째 지점
        2. 아치도형은 "시작점, 분리점, 시작점과 분리점의 중점에서 가장 먼 점이 이루는 삼각형의 넓이보다 각 점들에서 시작점 분리점 직선에서 수직으로 내린 직선의 합이 클 경우"이다. 두개 다 확인한다.
     */
    CGPoint start;
    [points[0] getValue:&start];
    CGPoint end;
    [points[pointCount-1] getValue:&end];
    
    CGPoint cusp;
    
    CGPoint current;
    CGPoint previous;
    [points[0] getValue:&previous];
    int times = 1;
    
    for(int i = 1 ; i < pointCount - 1; i++){
        [points[i] getValue:&current];
        if( times == 1 && (current.x - previous.x)){
            times++;
        }
        if((current.x - previous.x)){
            [points[i] getValue:&cusp];
            break;
        }
    }
    
    
    
    
    
    
}

-(void)judgeNumberTwo{
    points = _myview.touchPoints;
    int pointCount = [points count];
    /* 숫자 2 판단 과정
     
    숫자 2는 아치도형과 선이 이어진 모양이다.
        1. 먼저 아치도형과 선을 분리하는 지점(분리점)을 찾는다.: x값이 증가하는 도입, 두번째 지점
        2. 아치도형은 "시작점, 분리점, 시작점과 분리점의 중점에서 가장 먼 점이 이루는 삼각형의 넓이보다 각 점들에서 시작점 분리점 직선에서 수직으로 내린 직선의 합이 클 경우"이다.
        3. 선은 분리점과 끝점의 x차가 y차보다 크면 된다.
     */
    
    CGPoint start;
    [points[0] getValue:&start];
    CGPoint end;
    [points[pointCount-1] getValue:&end];
    
    CGPoint cusp;
    
    CGPoint current;
    CGPoint previous;
    [points[0] getValue:&previous];
    int times = 1;
    
    for(int i = 1 ; i < pointCount - 1; i++){
        [points[i] getValue:&current];
        if( times == 1 && (current.x - previous.x)){
            times++;
        }
        if((current.x - previous.x)){
            [points[i] getValue:&cusp];
            break;
        }
    }
    
    
    float xDis = end.x - cusp.x;
    float yDis = end.y - cusp.y;
    if(xDis < yDis){
        [self showAlertWithMessage:@"not 2"];
        return;
    }
    

    
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
