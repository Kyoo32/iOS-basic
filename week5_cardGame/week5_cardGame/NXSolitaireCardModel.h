//
//  NXCardModel.h
//  week5_cardGame
//
//  Created by Lee Kyu-Won on 3/30/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NXSolitaireCardModel : NSObject

@property(retain) NSMutableArray *cardResource;
@property(retain) NSMutableArray *userBucket;
@property(retain) NSMutableArray *gameStack;


-(instancetype)initCardModel;


-(void)shuffleCards;
-(void)displayCards;


@end
