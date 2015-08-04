//
//  ImageBrowserViewController.m
//  RSSReader
//
//  Created by Jan Seredynski on 27/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "ImageBrowserViewController.h"

@interface ImageBrowserViewController () <UIScrollViewDelegate>
{

}

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic)  UIImageView *imageView;
@property (retain, nonatomic) NSString* imageInternetPath;
@end

@implementation ImageBrowserViewController

- (void)dealloc {
    self.imageInternetPath = nil;
    self.item = nil;
    self.imageView = nil;
    [_scrollView release];
    [super dealloc];
}

-(instancetype)init
{
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.minimumZoomScale = 0.75;
    self.scrollView.maximumZoomScale=10;
    self.imageInternetPath = [self.item findImageInternetPath];

    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.imageView = [[[UIImageView alloc] init] autorelease];
    [[ImageDisplayManager sharedInstance]
        queueDisplayImageWithInternetPath:self.imageInternetPath
     inImageView:self.imageView
     withCompletionBlock:^{
         self.scrollView.contentSize = self.imageView.image.size;
         self.scrollView.clipsToBounds = YES;
         self.scrollView.delegate= self;
         [self.scrollView addSubview:self.imageView];
         [self.imageView sizeToFit ];
         [self scrollViewDidZoom:self.scrollView];
     }
     ];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    // center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = scrollView.bounds.size;
    CGRect frameToCenter = self.imageView.frame;
    
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
    {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) /2;
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
    
    self.imageView.frame = frameToCenter;
    

}




-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
    
}




@end
