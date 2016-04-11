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
        
        NSLog(@"##### %@", [[NSBundle mainBundle] pathForResource:@"album" ofType:@"json"]);
        
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"album" ofType:@"json"] ];
        
        NSLog(@"%@", jsonData);
        if(jsonData){
            NSError *error = NULL;
            NSLog(@"???%@",[NSJSONSerialization JSONObjectWithData:jsonData options:0 error: &error]);
            // NSLog(@"%@", jsonData);
        }
        
        _albumArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
        
        NSLog(@"\n\n\n !!! : %@", _albumArray);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dataSet" object:self];
            
    }
    return self;
}

@end
