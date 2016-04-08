//
//  MyDocument.m
//  objC_iCloud
//
//  Created by Lee Kyu-Won on 4/8/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

- (id)contentsForType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError{
    return [NSData dataWithBytes:[_userText UTF8String] length:[_userText length]];
}



- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError{
    
    
    if([contents length] > 0) {
        _userText = [[NSString alloc] initWithBytes:[contents bytes] length:[contents length] encoding: NSUTF8StringEncoding];
    } else {
        _userText = @"";
    }
    return YES;
}


@end
