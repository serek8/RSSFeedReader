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
    self.imageInScroll = [[[UIImageView alloc] init] autorelease];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[[NSOperationQueue alloc] init] autorelease] addOperationWithBlock:^{
        self.image = [UIImage imageWithData:[self.item getItemImage]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageInScroll.image = self.image;
            self.imageInScroll.center = self.scrollView.center;
        });
    }];
    self.imageInScroll.image = self.image;
    self.scrollView.contentSize = self.imageInScroll.image.size;
    self.scrollView.minimumZoomScale = 0.75;
    self.scrollView.maximumZoomScale=3;
    
    self.scrollView.delegate = self;
    
    
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    // center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect frameToCenter = self.imageInScroll.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
    {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
    {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    } else {
        frameToCenter.origin.y = 0;
    }
    
    self.imageInScroll.frame = frameToCenter;
    
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
