//
//  NXCardModel.m
//  week5_cardGame
//
//  Created by Lee Kyu-Won on 3/30/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXSolitaireCardModel.h"

@implementation NXSolitaireCardModel

-(instancetype)initCardModel{
    self = [super init];
    if (self) {
        self.cardResource = [@[[@{@"c2" : @NO} mutableCopy], [@{@"c3" : @NO} mutableCopy], [@{@"c4" : @NO} mutableCopy],
                               [@{@"c5" : @NO} mutableCopy], [@{@"c6" : @NO} mutableCopy], [@{@"c7" : @NO} mutableCopy],
                               [@{@"c8" : @NO} mutableCopy], [@{@"c9" : @NO} mutableCopy], [@{@"c10" : @NO} mutableCopy],
                               [@{@"cA" : @NO} mutableCopy], [@{@"cJ" : @NO} mutableCopy], [@{@"cK" : @NO} mutableCopy],
                               [@{@"cQ" : @NO} mutableCopy],
                               [@{@"d2" : @NO} mutableCopy], [@{@"d3" : @NO} mutableCopy], [@{@"d4" : @NO} mutableCopy],
                               [@{@"d5" : @NO} mutableCopy], [@{@"d6" : @NO} mutableCopy], [@{@"d7" : @NO} mutableCopy],
                               [@{@"d8" : @NO} mutableCopy], [@{@"d9" : @NO} mutableCopy], [@{@"d10" : @NO} mutableCopy],
                               [@{@"dA" : @NO} mutableCopy], [@{@"dJ" : @NO} mutableCopy], [@{@"dK" : @NO} mutableCopy],
                               [@{@"dQ" : @NO} mutableCopy],
                               [@{@"h2" : @NO} mutableCopy], [@{@"h3" : @NO} mutableCopy], [@{@"h4" : @NO} mutableCopy],
                               [@{@"h5" : @NO} mutableCopy], [@{@"h6" : @NO} mutableCopy], [@{@"h7" : @NO} mutableCopy],
                               [@{@"h8" : @NO} mutableCopy], [@{@"h9" : @NO} mutableCopy], [@{@"h10" : @NO} mutableCopy],
                               [@{@"hA" : @NO} mutableCopy], [@{@"hJ" : @NO} mutableCopy], [@{@"hK" : @NO} mutableCopy],
                               [@{@"hQ" : @NO} mutableCopy],
                               [@{@"s2" : @NO} mutableCopy], [@{@"s3" : @NO} mutableCopy], [@{@"s4" : @NO} mutableCopy],
                               [@{@"s5" : @NO} mutableCopy], [@{@"s6" : @NO} mutableCopy], [@{@"s7" : @NO} mutableCopy],
                               [@{@"s8" : @NO} mutableCopy], [@{@"s9" : @NO} mutableCopy], [@{@"s10" : @NO} mutableCopy],
                               [@{@"sA" : @NO} mutableCopy], [@{@"sJ" : @NO} mutableCopy], [@{@"sK" : @NO} mutableCopy],
                               [@{@"sQ" : @NO} mutableCopy]  ] mutableCopy];
        /*
         literal로 만들었을 때 수정가능하게 만들고 싶다면 NSDictionry도 mutableCopy해야 한다.
         
         NSDictionary *bookListing = {key1 : object1, key2 : object2, key3 : object3 };
         bookObject = bookListing[key1];
         bookListing[key2] = newBookObject;
         //automatically mutable.
         
         위 코드의 딕셔너리는 literal 아님 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        */
        self.userBucket = [[NSMutableArray alloc] init];
        self.gameStack = [[NSMutableArray alloc] initWithCapacity:7];
        
    }
    return self;
}



-(void)shuffleCards{
    
        
    [self.userBucket removeAllObjects];
    [self.gameStack removeAllObjects];
    
    NSArray *tempArray;
    NSString *temp;
    NSMutableDictionary *tempDic;
    
    //NSLog(@"HELlo 1");
    int randNum;
    int count = 0;
    while(count < 24){
       // NSLog(@"HELlo 2");
        while(true){ //다른 방법 : Set
            randNum = arc4random_uniform(52);
            tempArray = [self.cardResource[randNum] allValues];
         //   NSLog(@"%@", tempArray);
            if([[tempArray firstObject] isEqualToNumber: @0]){
                break;
            }
        }
        
    
        temp = [[self.cardResource[randNum] allKeys] firstObject];
       // NSLog(@"%@", temp);
        
        [self.userBucket addObject: temp];
        
        tempDic = self.cardResource[randNum];
        [tempDic setObject:@YES forKey:temp];
        
        count++;
        
    }
    
    for(int i = 1 ; i <= 7 ;  i++ ) {
        
        NSMutableArray *innerArray = [[NSMutableArray alloc] initWithCapacity:i];
        int breakPoint = count + i;
            
        while(count < breakPoint){
         //   NSLog(@"HELlo 3");
            while(true){ //다른 방법 : Set
                randNum = arc4random_uniform(52);
                tempArray = [self.cardResource[randNum] allValues];
           //     NSLog(@"%@", tempArray);
                
                if([[tempArray firstObject] isEqualToNumber: @0]){
                    break;
                }
            }
            
            temp = [[self.cardResource[randNum] allKeys] firstObject];
            [innerArray addObject:temp];
            
            tempDic = self.cardResource[randNum];
            [tempDic setObject:@YES forKey:temp];

            
            count++;
            
        }
        
        [self.gameStack insertObject:innerArray atIndex:(i-1)];
        [innerArray release];
    }
       
    for(int i = 0 ; i < 52 ; i++){
        temp = [[self.cardResource[i] allKeys] firstObject];
        tempDic = self.cardResource[i];
        [tempDic setObject:@NO forKey:temp];
    }
    

}


-(void)displayCards{
    
    NSLog(@"GAMESTACK : %@",self.gameStack);
    NSLog(@"BUcKET : %@", self.userBucket);
    
}


@end
