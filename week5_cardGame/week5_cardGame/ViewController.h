//
//  ViewController.h
//  week5_cardGame
//
//  Created by Lee Kyu-Won on 3/30/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXSolitaireCardModel.h"

@interface ViewController : UIViewController

@property(retain) NXSolitaireCardModel *i_var;

- (void)goShuffle;
- (void)drawCards;

@end

