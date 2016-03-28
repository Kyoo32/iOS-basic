//
//  ViewController.h
//  objC_Database
//
//  Created by Lee Kyu-Won on 3/28/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface DatabaseViewController : UIViewController

@property(strong, nonatomic) NSString *dataBasePath;
@property(nonatomic) sqlite3 *contactDB;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UILabel *status;

- (IBAction)saveData:(id)sender;
- (IBAction)findContact:(id)sender;




@end

