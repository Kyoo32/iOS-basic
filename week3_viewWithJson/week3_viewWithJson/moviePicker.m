//
//  moviePicker.m
//  week3_viewWithJson
//
//  Created by Lee Kyu-Won on 3/16/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "moviePicker.h"

@implementation moviePicker


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"##### %@", [[NSBundle mainBundle] pathForResource:@"movieRaw" ofType:@"json"]);
        
        movieRaw = [[NSData alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"movieRaw" ofType:@"json"] ];
        
        NSLog(@"%@", movieRaw);
        if(movieRaw){
            NSError *error = NULL;
            NSLog(@"???%@",[NSJSONSerialization JSONObjectWithData:movieRaw options:0 error: &error]);
        
        self.movieBase =[NSJSONSerialization JSONObjectWithData:movieRaw options:0 error:nil];
        NSLog(@"&&&&%@", self.movieBase);
            
        }
    }
    return self;
}

//- (void)arrayToDictinary{
//    NSString* kTitle = @"title";
//    NSString* kImage = @"image";
//    NSString* kContent = @"content";
//    NSString* kComments = @"comments";
//
//    int count = [self.movies count];
//    self.movies = [NSMutableDictionary alloc];
//    for(int i = 0 ; i < count ; i++){
//        [self.movies ]
//    }
//    
//}

- (NSDictionary*)itemAtIndex:(int)index{
    return [self.movieBase objectAtIndex:index];
}



@end
