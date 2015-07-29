//
//  ImageBrowserViewController.m
//  RSSReader
//
//  Created by Jan Seredynski on 27/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "ImageBrowserViewController.h"

@interface ImageBrowserViewController ()

@end

@implementation ImageBrowserViewController

-(instancetype)init
{
    self = [super init];
    self.imageInScroll = [[UIImageView alloc] init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageInScroll.image = self.image;
    self.scrollView.contentSize = self.imageInScroll.image.size;
    self.scrollView.minimumZoomScale = 0.75;
    self.scrollView.maximumZoomScale=4;
    
    self.scrollView.delegate = self;
    
    // Do any additional setup after loading the view.
}

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageInScroll;
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

- (void)dealloc {
    [_scrollView release];
    [_imageInScroll release];
    [super dealloc];
}
@end
