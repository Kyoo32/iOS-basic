//
//  ArchiveViewController.m
//  objC_archiving
//
//  Created by Lee Kyu-Won on 3/28/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ArchiveViewController.h"

@interface ArchiveViewController ()

@end

@implementation ArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSFileManager *filemgr;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    
    // get a documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // make a path of the data file
    _dataFilePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"data.archive"]];
    
    // check whether file exists
    if([filemgr fileExistsAtPath: _dataFilePath]){
        NSMutableArray *dataArray;
        dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile: _dataFilePath];
        
        
        _name.text = dataArray[0];
        _address.text = dataArray[1];
        _phone.text = dataArray[2];
    }
    



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveData:(id)sender {
    NSMutableArray *contactArray;
    
    contactArray = [[NSMutableArray alloc] init];
    [contactArray addObject:self.name.text];
    [contactArray addObject:self.address.text];
    [contactArray addObject:self.phone.text];
    
    [NSKeyedArchiver archiveRootObject:contactArray toFile:_dataFilePath];
    
    
    
}
@end
