//
//  DetailViewController.m
//  week8_CFStreamCam
//
//  Created by Lee Kyu-Won on 4/20/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController (){
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    NSOutputStream *outStream;
    NSMutableData *data;
}

@end

@implementation DetailViewController

#pragma mark - Managing the detail item


- (void)createOutputStream:(NSString*)hostAddress{
    NSLog(@"Creating and opening NSOutputStream...");
    // oStream is an instance variable
    
    //CFStreamCreatePairWithSocketToHost(NULL,(__bridge CFStringRef)(hostAddress), 8000, &writeStream, NULL);
    outStream = (__bridge NSOutputStream *)(writeStream);
    [outStream setDelegate:self];
    [outStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                       forMode:NSDefaultRunLoopMode];
    [outStream open];
}

-(void) readRequestToServer:(NSString*)hostAddress{
    
    
    NSLog(@"request!");
    CFStreamCreatePairWithSocketToHost(NULL,(__bridge CFStringRef)(hostAddress), 8000, &readStream, &writeStream);
    
    NSInputStream *inputStream = (__bridge_transfer NSInputStream *)readStream;
    [inputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    
    [self createOutputStream:hostAddress];
    
}
- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    
    switch(eventCode) {
        case NSStreamEventHasSpaceAvailable: {
//            uint8_t *readBytes = (uint8_t *)[data mutableBytes];
//            readBytes += byteIndex; // ivar
//            int data_len = [data length];
//            unsigned int len = ((data_len - byteIndex >= 1024) ? 1024 : (data_len - byteIndex));
//            uint8_t buf[len];
//            (void)memcpy(buf, readBytes, len);
           
            //byteIndex += len;
            break;
        }
        case NSStreamEventHasBytesAvailable:
        {
             NSLog(@"stream read!");
           
            data = [NSMutableData data];
            
            uint8_t buf[1024];
            unsigned int len = 0;
            len = [(NSInputStream *)stream read:buf maxLength:8];
            //NSData *imageLen = [NSData dataWithBytes:buf length:8];
            long imageLong = atol(buf);
            
            
            buf[len] = 0;
            int imageCount = 0;
            int imageRead = 0;
            if(imageLong) {
                while(imageCount < imageLong){
                    imageRead = [(NSInputStream *)stream read:buf maxLength:1024];
                    [data appendBytes:(const void *)buf length:1024];
                    imageCount += imageRead;
                }
            } else {
                NSLog(@"no image");
            }
            _camViewImage = [UIImage imageWithData:data];
            _camView.image = _camViewImage;
//            [self.view reloadInputViews];
            int outlen  = 0;
            char *Ack  = "ACK";
            outlen = [outStream write:Ack maxLength:3];
           // NSLog(@"Sending ack");
            
            break;
        }
        case NSStreamEventEndEncountered:
        {
            [stream close];
            [stream removeFromRunLoop:[NSRunLoop currentRunLoop]
                              forMode:NSDefaultRunLoopMode];
            stream = nil; // stream is ivar, so reinit it
            break;
        }
    }
}

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
      //  self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self readRequestToServer:@"127.0.0.1"];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
