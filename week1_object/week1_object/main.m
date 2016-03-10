//
//  main.m
//  week1_object
//
//  Created by Lee Kyu-Won on 3/2/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPen.h"
#import "NXFileList.h"
///////////////////////////////
#import "JPDirectoryManager.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NXPen *kyooPen = [[NXPen alloc] initRedWithOwnerName: @"Kyoo"];
        [kyooPen printDescriptionOfRed];
     
        
        
        NXFileList *ls = [[NXFileList alloc] init];
        
        //[ls showListUnderDirectory:@"/Users/KateKyuWon/Desktop"];
        //[ls DisplayAllFilesAtPath:@"/Users/KateKyuWon/Desktop" filterByExtension:@"png"];
        [ls DisplayAllFilesAtPath:@"/Users/KateKyuWon/Desktop/nearHoneyTip/NearHoneyTip/NearHoneyTip" filterByExtension:@"m"]; //deep안됨;;
        
        
        ////////////////////////////////////////////////////
        NSLog(@"\n\n\n +++ from here, JPub iOS7");
        
        JPDirectoryManager *ex = [[JPDirectoryManager alloc] init];
        ex.filemgr = [NSFileManager defaultManager];
        
        //pwd
        NSString *currentPath = [ex.filemgr currentDirectoryPath];
        NSLog(@"pwd > %@", currentPath);
        
        //locate "/documents"
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES); // need not call as c function
        NSString *docsDir = dirPaths[0];
        NSLog(@"locate /docuements > %@", docsDir); //result in actual iOS device : /var/moblie/Application/<app id>/Documents
        
        //locate "/tmp"
        NSString *tmpDir = NSTemporaryDirectory();
        NSLog(@"locate /tmp > %@", tmpDir);
        
        //cd to /document
        if([ex.filemgr changeCurrentDirectoryPath:docsDir] == NO){ //if YES return, it means that changeCurrentDirectoryPath works.
            NSLog(@"fail changing directory");
        }
        
        
        //create new directory
        NSString *newDir = [docsDir stringByAppendingString:@"jpub"];
        if([ex.filemgr createDirectoryAtPath:newDir withIntermediateDirectories:YES attributes:nil error:NULL] ==NO){ //if 'withIntermediateDirectory is no, it fails because there is no intermediate Directory and it doesn't deal that
            NSLog(@"fail making directory");
        }
        
        
        //remove a directory
        if( [ex.filemgr removeItemAtPath:newDir error:NULL] == NO){
            NSLog(@"fail removing directory");
        }
        
        
        //list Directory   ???????????????????
        if( [ex.filemgr createSymbolicLinkAtPath:@"/Users/KateKyuwon/Desktop/src.txt" withDestinationPath:@"/Users/KateKyuwon/Desktop/dst.txt" error:NULL] == YES) {
            NSLog(@"Succeed in listing files");
        } else {
            NSLog(@"fail listing files");
        }
        
        
        //get file attribute
        NSDictionary *attribs = [ex.filemgr attributesOfItemAtPath:@"/Users/KateKyuwon/Desktop/src.txt" error:NULL];
        NSLog(@"File type: %@ \n File size: %@ \n POSIX permission: %@", [attribs objectForKey:NSFileType], [attribs objectForKey:NSFileSize], [attribs objectForKey:NSFilePosixPermissions]);
        
        
        
        
        
        
    }
    return 0;
}
