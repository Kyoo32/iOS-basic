//
//  KWAlbumModel.m
//  week7_midTerm
//
//  Created by Lee Kyu-Won on 4/11/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "KWAlbumModel.h"
#import "Reachability.h"


NSInteger intSort(id num1, id num2, void *context)
{
    int v1 = [num1 intValue];
    int v2 = [num2 intValue];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}


@implementation KWAlbumModel{
    NSMutableSet<NSString*> *uniqueYearSet;
    Reachability *wifiReachability;
}

-(instancetype)init{
    
    self = [super init];
    
    if (self){
        uniqueYearSet = [[NSMutableSet alloc]init];
        wifiReachability = [Reachability reachabilityForLocalWiFi];
        
        _albumArray = [NSMutableArray alloc];
        _intialArray = [NSMutableArray alloc];
        
        NSData *jsonData;
        

        
        if( [wifiReachability currentReachabilityStatus] > 0){
            NSString *urlString = @"http://125.209.194.123/json.php";
        NSURL *url = [[NSURL alloc] initWithString:urlString];
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:url MIMEType:@"text/plain" expectedContentLength:NULL textEncodingName: NULL];
        

         jsonData= [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:&response error:NULL];
        
        
        
        NSLog(@"NETWORK : %@", jsonData);
        } else {
        
            NSLog(@"##### %@", [[NSBundle mainBundle] pathForResource:@"album" ofType:@"json"]);

           jsonData = [[NSData alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"album" ofType:@"json"] ];
            NSLog(@"%@", jsonData);
        }
        
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
        
        [self setCountYear];
        _yearCountBucket = [[NSMutableArray alloc]initWithCapacity: _countYear];
        [self setYearCountBucket];
        
    }
    return self;
}

-(void)resetArray{
    _albumArray =_intialArray;
         [[NSNotificationCenter defaultCenter] postNotificationName:@"dataReset" object:self];
}

-(void)setCountYear{
    for(int i = 0 ; i<[_albumArray count] ; i++){
        NSString *kYear =  [[_albumArray[i]valueForKey:@"date"] substringToIndex:4];
        
        //NSLog(@"this : %@",[[_albumArray[i]valueForKey:@"date"] substringToIndex:4]);
        [uniqueYearSet addObject: kYear];
    }
    
    _countYear =  (int)[uniqueYearSet count];
    //NSLog(@"Count year : %d",[uniqueYearSet count]);
    
}

-(void)setYearCountBucket{
    NSArray *yearSorted = [uniqueYearSet allObjects];
    yearSorted = [yearSorted sortedArrayUsingFunction:intSort context:nil];
    NSLog(@"YEAR sorted : %@" , yearSorted);
   
    
    NSEnumerator *setEnumerator = (NSString*)[yearSorted objectEnumerator];
    NSString *kYear;
    int i = 0;
    
    while( kYear = [setEnumerator nextObject]){
        [_yearCountBucket insertObject: [@{ @"count" : @0, @"year" : kYear } mutableCopy] atIndex:i];
        i++;
    }
    
    NSDictionary *object;
    for(int i = 0 ; i<[_albumArray count] ; i++){
        NSString *kYear =  [[_albumArray[i]valueForKey:@"date"] substringToIndex:4];
        NSLog(@"world");
        NSEnumerator *yearEnumerator = [_yearCountBucket objectEnumerator];
        
        while( object = [yearEnumerator nextObject]){
            if( [[object valueForKey:@"year"] isEqualToString:kYear]){
                int rowNum = (int)[[object valueForKey:@"count"] integerValue];
                [object setValue:[NSNumber numberWithInt:(int)(rowNum + 1)]forKey:@"count"];
                [object setValue:_albumArray[i] forKey: [NSString stringWithFormat:@"%d", rowNum]];
            }
        }
    }
    
    NSLog(@"year bucket : %@",_yearCountBucket);
}

@end
