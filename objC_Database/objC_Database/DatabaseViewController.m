//
//  ViewController.m
//  objC_Database
//
//  Created by Lee Kyu-Won on 3/28/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "DatabaseViewController.h"

@interface DatabaseViewController ()

@end

@implementation DatabaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *docsDir;
    NSArray *dirPath;
    
    
    dirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPath[0];
    
    _dataBasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"contacts.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if( [filemgr fileExistsAtPath:_dataBasePath] == NO){
        NSLog(@"no db");
        
        const char *dbpath = [_dataBasePath UTF8String];
        
        if(sqlite3_open(dbpath, &_contactDB) == SQLITE_OK){
            char *errMsg;
            
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)";
            
            if( sqlite3_exec(_contactDB, sql_stmt, NULL, NULL,&errMsg) != SQLITE_OK){
                _status.text = @"Failed to create table";
            }
             _status.text = @"Table is created";
            sqlite3_close(_contactDB);
            
        } else {
            _status.text = @"Failed to open/create datebase";
        }

    }
    
   // NSLog(@"yes db: %@", &_contactDB);

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveData:(id)sender {
    
    
    sqlite3_stmt *statement;
    const char *dbpath = [_dataBasePath UTF8String];
    
    if(sqlite3_open( dbpath, &_contactDB) == SQLITE_OK ){
        NSLog(@"yes");
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO CONTACTS (name, address, phone) VALUES(\"%@\", \"%@\", \"%@\")", self.name.text, self.address.text, self.phone.text ];
        
        const char* insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        if(sqlite3_step(statement) == SQLITE_DONE){
            _status.text = @"Contact added";
            _name.text = @"";
            _address.text = @"";
            _phone.text = @"";
            
        } else {
            _status.text = @"Failed to add contact";
        }
        
         //_status.text = @"SQL doesn't work";
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
    
    
    
}

- (IBAction)findContact:(id)sender {
    
    
    sqlite3_stmt *statement;
    const char *dbpath = [_dataBasePath UTF8String];
    
    if(sqlite3_open( dbpath, &_contactDB) == SQLITE_OK ){
        NSLog(@"yes ");
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT address, phone FROM contacts WHERE name = \"%@\"", _name.text];
        
        const *query_stmt = [querySQL UTF8String];
        
        if(sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
    
            if(sqlite3_step(statement) == SQLITE_ROW){
                NSString *addressField = [[NSString alloc]initWithUTF8String:(const char*) sqlite3_column_text(statement, 0)];
                _address.text = addressField;
                NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(statement, 1)];
                _phone.text = phoneField;
                _status.text = @"Match Found";
            } else {
                _status.text = @"Match Not Found";
                _address.text = @"";
                _phone.text = @"";
            }
            
            sqlite3_finalize(statement);
        }
        
        //_status.text = @"SQL doesn't work";

        sqlite3_close(_contactDB);
    }
    
}
    
@end
