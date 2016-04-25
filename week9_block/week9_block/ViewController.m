//
//  ViewController.m
//  week9_block
//
//  Created by Lee Kyu-Won on 4/25/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // [_firstBtn addTarget:self action:@selector(btnClicked) forControlEvents:NULL];
    
    
}

- (IBAction)bookButtonClicked:(id)sender {
    _progressBar.progress = 0;
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //dispatch_queue_create(NULL, nil);
    
    //or dispatch_get_main_queue();
    dispatch_async(aQueue, ^{
        [self workingProgress];
    });

}



-(void)workingProgress {
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"] encoding:NSUTF8StringEncoding error:nil];
    int length = bookfile.length;
    int spaceCount = 0;
    float progress = 0;
    unichar aChar;
    for (int nLoop=0; nLoop<length; nLoop++) {
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' ') spaceCount++;
        progress = (float)nLoop / (float)length;

            dispatch_async(dispatch_get_main_queue(), ^{
                    _progressBar.progress = progress;
            });
    }
    
    [[[UIAlertView alloc] initWithTitle:@"완료"
                                message:[NSString stringWithFormat:@"찾았다 %d개",spaceCount]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstBtnClicked:(id)sender {
    
    [UIView animateWithDuration: 4 delay: 0 options:1 << 16 animations:^(){
        _leadingC.constant = 100;
        _topC.constant = 100;
        _widthC.constant = 400;
        _heightC.constant = 100;
        _firstBtn.backgroundColor = [UIColor yellowColor];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished){
        _leadingC.constant = 70;
        _topC.constant = 30;
        _widthC.constant = 200;
        _heightC.constant = 150;
        _firstBtn.backgroundColor = [UIColor magentaColor];
        [self.view layoutIfNeeded];
    
    }];
    


}
@end
