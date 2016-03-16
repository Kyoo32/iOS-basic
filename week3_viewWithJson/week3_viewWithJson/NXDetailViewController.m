//
//  NXDetailViewController.m
//  week3_viewWithJson
//
//  Created by Lee Kyu-Won on 3/16/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "NXDetailViewController.h"

@interface NXDetailViewController ()

@end

@implementation NXDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.selectedMovie = [NSDictionary alloc];
    
    NSString* imagePath = @"/movies/";
    imagePath = [imagePath stringByAppendingString: [self.selectedMovie objectForKey:@"image"]];
    imagePath = [imagePath substringToIndex:[imagePath length] - 4];
    NSLog(@"path: %@", imagePath);
    
    UIImage* selectedImage = [[UIImage alloc ] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imagePath ofType:@"jpg"]];
    NSLog(@"image: %@",selectedImage);
    self.movieImage.image = selectedImage;
    //[[NSBundle mainBundle] pathForResource:imagePath ofType:@"jpg"];
    self.movieTitle.text = [self.selectedMovie objectForKey:@"title"];
    self.movieContent.text = [self.selectedMovie objectForKey:@"content"];
    
    // Do any additional setup after loading the view.
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

@end
