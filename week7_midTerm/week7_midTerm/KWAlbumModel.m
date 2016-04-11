//
//  KWAlbumModel.m
//  week7_midTerm
//
//  Created by Lee Kyu-Won on 4/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "KWAlbumModel.h"

@implementation KWAlbumModel


-(instancetype)init{
    
    self = [super init];
    
    if (self){
        
        
        _albumArray = [NSMutableArray alloc];
        _intialArray = [NSMutableArray alloc];
        
        NSLog(@"##### %@", [[NSBundle mainBundle] pathForResource:@"album" ofType:@"json"]);
        
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"album" ofType:@"json"] ];
        
        NSLog(@"%@", jsonData);
        if(jsonData){
            NSError *error = NULL;
            NSLog(@"???%@",[NSJSONSerialization JSONObjectWithData:jsonData options:0 error: &error]);
            // NSLog(@"%@", jsonData);
        }
        
        _intialArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
        
        NSLog(@"\n\n\n !!! : %@",_intialArray);
        
        _albumArray = _intialArray;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dataSet" object:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetArray) name:@"resetArray" object:nil];
            
    }
    return self;
}

-(void)resetArray{
    _albumArray =_intialArray;
         [[NSNotificationCenter defaultCenter] postNotificationName:@"dataSet" object:self];
}

@end
