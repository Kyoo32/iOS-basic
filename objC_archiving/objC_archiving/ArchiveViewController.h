//
//  ArchiveViewController.h
//  objC_archiving
//
//  Created by Lee Kyu-Won on 3/28/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchiveViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) NSString *dataFilePath;
- (IBAction)saveData:(id)sender;

@end
