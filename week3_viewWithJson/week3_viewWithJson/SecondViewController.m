//
//  SecondViewController.m
//  week3_viewWithJson
//
//  Created by Lee Kyu-Won on 3/16/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mp = [[moviePicker alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"getDetail"]){
        NXDetailViewController *movieDetail = segue.destinationViewController;
        int lowerBound = 0;
        int upperBound = (int)[self.mp.movieBase count] ;
        int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
        
        movieDetail.selectedMovie = [[NSDictionary alloc] initWithDictionary:[self.mp itemAtIndex:rndValue]];
        NSLog(@"selected movie : %@", movieDetail.selectedMovie);

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
