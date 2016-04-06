//
//  ViewController.m
//  week5_cardGame
//
//  Created by Lee Kyu-Won on 3/30/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ViewController.h"
#import "NXSolitaireCardModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLastCardOrder) name:@"getlastorder" object:NULL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveLastCardOrder) name:@"savelastorder" object:NULL];
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    self.i_var = [[NXSolitaireCardModel alloc] initCardModel];
    

    if(![user objectForKey:@"userbucket"]){
        [self.i_var shuffleCards];
    } else {
        [self getLastCardOrder];
    }
    [self.i_var displayCards];


    // Do any additional setup after loading the view, typically from a nib.
}

-(void)getLastCardOrder{
    NSLog(@"\n\nget\n\n");

    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    self.i_var.userBucket = [[user objectForKey:@"userbucket"]  mutableCopy];
    self.i_var.gameStack = [[user objectForKey:@"gamestack"] mutableCopy];
}

-(void)saveLastCardOrder{
    NSLog(@"\n\nsave\n\n");
    NSUserDefaults* userD = [NSUserDefaults standardUserDefaults];
    [userD setObject:self.i_var.gameStack forKey:@"gamestack"];
    [userD setObject:self.i_var.userBucket forKey:@"userbucket"];
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated]; //necessity
    [self drawCards];
 
    
    UIButton *goShuffleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [goShuffleBtn setTitle:NSLocalizedStringFromTable(@"btn", @"button", nil) forState:UIControlStateNormal];
    [goShuffleBtn setFrame:CGRectMake(800, 570, 100, 10)];
    [self.view addSubview:goShuffleBtn];
    
    [goShuffleBtn addTarget:self
                     action:@selector(goShuffle)
     forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (void) drawCards{
    
    NSLog(@"draw cards");
    for(int i = 0 ; i < 24 ; i++ ){
        NSString *cardName = [[NSString alloc] initWithFormat:NSLocalizedStringFromTable(@"cardPath",@"button" , nil), self.i_var.userBucket[i]];
        UIImageView *cardImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:cardName ]];
        [cardImage setFrame:CGRectMake(26 + 24*i, 500 , 130, 150)];
        [self.view addSubview:cardImage];
        
        [cardName release];
        [cardImage release];
    }
    
    
    for(int i = 0 ; i < 7 ; i++ ){
        for(int j = 0 ; j  <= i ; j++){
            NSString *cardName = [[NSString alloc] initWithFormat:NSLocalizedStringFromTable(@"cardPath",@"button", nil), self.i_var.gameStack[i][j]];
            UIImageView *cardImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:cardName ]];
            [cardImage setFrame:CGRectMake(26 + 140 * i, 100 + 40* j , 130, 150)];
            [self.view addSubview:cardImage];
            
            [cardName release];
            [cardImage release];
        }
    }

}

- (void)goShuffle {
    
    for( UIView* each in self.view.subviews) {
        if([each isKindOfClass:UIButton.class]) continue;
        [each removeFromSuperview];
    }
    NSLog(@"SHUFFLE");
    [self.i_var shuffleCards];
    [self.i_var displayCards];
    [self drawCards];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
