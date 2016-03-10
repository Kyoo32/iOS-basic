//
//  JPDirectoryManager.h
//  week1_object
//
//  Created by Lee Kyu-Won on 3/10/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPDirectoryManager : NSObject

/* 
 #### iOS file system summary
 we can save the data in two different ways.
 1. local device
 2. remote iCloud

 <local device sandbox> can access only
 - /documents
 - /tmp
 
 <Foundation Framework>
 - NSFileManager
 - NSFileHandle
 - NSData
 
 <object-c path name> follows standard unix
 ex) absolute : /User/demo/mapdata/local.xml
     relative : mapdata/local.xml
 
 */

@property NSFileManager *filemgr;

@end
