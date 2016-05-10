//
//  main.m
//  nextPerson
//
//  Created by Lee Kyu-Won on 5/10/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XCODE_COLORS_ESCAPE_MAC @"\033["
#define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["

#if TARGET_OS_IPHONE
#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_IOS
#else
#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_MAC
#endif

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSData *rawColorData = [NSData dataWithContentsOfFile:@"/Users/KateKyuWon/Documents/NEXT16-1/mobileComputing/nextPerson/nextPerson/1C_jungWon.next"];
       //NSLog(@"%@",rawColorData);
        
       // const float* fileBytes = (const char*)[rawColorData bytes];
        NSUInteger length = [rawColorData length];
        length = length /4;
        NSUInteger index;
        NSLog(@"%d", length);
        
        NSUInteger startPoint = 0;
        NSRange range = NSMakeRange(startPoint, 4);
        
       for (index = 0; index < 1; index++)
        {
            
            range.location = startPoint;
            unsigned long int temp;
            [rawColorData getBytes:&temp range: range];
            
            int r = (temp >> (8*0)) & 0xff;
            int g = (temp >> (8*1)) & 0xff;
            int b = (temp >> (8*2)) & 0xff;
            int a = (temp >> (8*3)) & 0xff;
            //NSLog(@"%d %d %d %d", r,g,b,a);
            NSString *color = [NSString stringWithFormat:@"fg%d,%d,%d;",r,g,b];
            
            
            NSLog(XCODE_COLORS_ESCAPE @"%@" @"jungWon" XCODE_COLORS_RESET, color);
          // NSLog(@"");
            
            
            startPoint = startPoint + 4;
        }

       
        
        
    }
    return 0;
}
