//
//  ViewController.m
//  week9_block
//
//  Created by Lee Kyu-Won on 4/25/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSArray *object;
    NSString *bookfile;
    int length;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://125.209.194.123/wordlist.php"]];
    object = [NSJSONSerialization JSONObjectWithData:data options:NULL error:NULL];
  
    bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                   pathForResource:@"bookfile" ofType:@".txt"] encoding:NSUTF8StringEncoding error:nil];
    length = bookfile.length;

}

- (IBAction)bookButtonClicked:(id)sender {
    _progressBar.progress = 0;
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(aQueue, ^{
       //[self workingProgress];
        [self countSearchingString:@"주식"];
        [self countWordSet];
        [self countAllWord];
    });
}

-(void)showAlertWithMessage:(NSString*)message{

    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc] initWithTitle:@"완료"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
        
    });
}

-(void)countAllWord{
    NSString *strippedString = [bookfile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0) {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }
    
    [self showAlertWithMessage:[NSString stringWithFormat:@"전체 단어 갯수: %lu", (unsigned long)[searchItems count]]];
}

-(void)countWordSet{
    
    NSMutableSet *wordSet = [NSMutableSet set];
    for(int i = 0; i < [object count] ; i++){
        [wordSet addObject:object[i]];
    }
    NSArray *wordSetArray = [wordSet allObjects];
    //NSLog(@"%@",wordSetArray);
    int setCount = [wordSetArray count];
    NSMutableArray *wordCountBucket = [[NSMutableArray alloc]initWithCapacity:setCount];
    
    for(int i=0; i<setCount ; i++){
        [wordCountBucket insertObject:@0 atIndex:i];
    }
    
    NSOperationQueue *queueForCountingWordSet = [[NSOperationQueue alloc]init];
    for(int i = 0; i < setCount; i++){
        NSString *exceptNewlineString = [wordSetArray[i] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        int searchinglength = exceptNewlineString.length;

        [queueForCountingWordSet addOperationWithBlock:^{
            NSString *aChar;

            for (int nLoop=0; nLoop< length - searchinglength; nLoop++) {
                aChar = [bookfile substringWithRange:NSMakeRange(nLoop, searchinglength)];
                if([aChar isEqualToString:exceptNewlineString]) [wordCountBucket replaceObjectAtIndex:i withObject: [NSNumber numberWithInteger: ([[wordCountBucket objectAtIndex:i ] integerValue] + 1)]];

            }
        
         }];
    }
    
    [queueForCountingWordSet waitUntilAllOperationsAreFinished];
    int bigIndex = 0, smallIndex = 0;
    for(int i = 0; i < setCount ; i++){
        if(wordCountBucket[i] > wordCountBucket[bigIndex]) bigIndex = i;
        if(wordCountBucket[i] < wordCountBucket[smallIndex]) smallIndex = i;
    }
   
    NSLog(@"%@",wordCountBucket);
    
    [self showAlertWithMessage:[NSString stringWithFormat:@"제일 많은 단어(%@) : %@개\n제일 적은 단어(%@) : %@개",wordSetArray[bigIndex], wordCountBucket[bigIndex],wordSetArray[smallIndex], wordCountBucket[smallIndex]]];
    
}



-(void)countSearchingString:(NSString*)searchingString {
    
    int count = 0;
    // strip out all the leading and trailing spaces
    NSString *exceptNewlineString = [searchingString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
    int searchinglength = exceptNewlineString.length;

    float progress = 0;
    
    
    //방법1
    NSRegularExpression *rxp = [[NSRegularExpression alloc]initWithPattern:exceptNewlineString options:NULL error:nil];
    
    count = [rxp numberOfMatchesInString:bookfile options:NULL range:NSMakeRange(0, length)];
    
    //방법2
//    NSString *aChar;
//    for (int nLoop=0; nLoop< length - searchinglength; nLoop++) {
//        aChar = [bookfile substringWithRange:NSMakeRange(nLoop, searchinglength)];
//        if([aChar isEqualToString:exceptNewlineString]) count++;
//        progress = (float)nLoop / (float)length;
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _progressBar.progress = progress;
//        });
//    }
    
    [self showAlertWithMessage:[NSString stringWithFormat:@"%@ 갯수: %d개",searchingString,count]];
}




-(void)workingProgress {
    
    int spaceCount = 0;
    float progress = 0;
    unichar aChar;
    for (int nLoop=0; nLoop<length; nLoop++) {
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' ') spaceCount++;
        progress = (float)nLoop / (float)length;

        dispatch_async(dispatch_get_main_queue(), ^{
                _progressBar.progress = progress;
        });
    }
    [self showAlertWithMessage:[NSString stringWithFormat:@"스페이스 갯수: %d개",spaceCount]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstBtnClicked:(id)sender {
    
    [UIView animateWithDuration: 4 delay: 0 options:1 << 16 animations:^(){
        _leadingC.constant = 100;
        _topC.constant = 100;
        _widthC.constant = 400;
        _heightC.constant = 100;
        _firstBtn.backgroundColor = [UIColor yellowColor];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished){
        _leadingC.constant = 70;
        _topC.constant = 30;
        _widthC.constant = 200;
        _heightC.constant = 150;
        _firstBtn.backgroundColor = [UIColor magentaColor];
        [self.view layoutIfNeeded];
    
    }];
    


}
@end
