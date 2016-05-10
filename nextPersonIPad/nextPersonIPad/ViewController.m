//
//  ViewController.m
//  nextPersonIPad
//
//  Created by Lee Kyu-Won on 5/10/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSData *rawColorData = [NSData dataWithContentsOfFile:@"/Users/KateKyuWon/Documents/NEXT16-1/mobileComputing/nextPerson/nextPerson/1C_jungWon.next"];
    
    NSUInteger length = [rawColorData length];
    length = length /4;
    NSUInteger index;
    
    NSUInteger startPoint = 0;
    NSRange range = NSMakeRange(startPoint, 4);
    
    float x = 0;
    float y = 0;
    for (index = 0; index < length; index++)
    {
        
        range.location = startPoint;
        unsigned long int temp;
        [rawColorData getBytes:&temp range: range];
        
        int r = (temp >> (8*0)) & 0xff;
        int g = (temp >> (8*1)) & 0xff;
        int b = (temp >> (8*2)) & 0xff;
        int a = (temp >> (8*3)) & 0xff;
       
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x, y, 4, 4)];
        view.backgroundColor = [UIColor colorWithRed:(float)r/255 green:(float)g/256 blue:(float)b/256 alpha:(float)a/256];
        [self.view addSubview:view];
                                                
        
        if(index % 256 == 0) {
            y = y + 4;
            x = 0;
        } else {
            x = x + 4;
        }
        
        startPoint = startPoint + 4;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
