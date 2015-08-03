//
//  ImageBrowserViewController.m
//  RSSReader
//
//  Created by Jan Seredynski on 27/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "ImageBrowserViewController.h"

@interface ImageBrowserViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageInScroll;
@property (strong, nonatomic) NSString* imageInternetPath;
@end

@implementation ImageBrowserViewController

- (void)dealloc {
    self.imageInternetPath = nil;
    self.item = nil;
    [_scrollView release];
    [_imageInScroll release];
    [super dealloc];
}

-(instancetype)init
{
    self = [super init];
    self.imageInScroll = [[[UIImageView alloc] init] autorelease];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageInternetPath = [self.item findImageInternetPath];
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        [ImageDisplayManager downloadItemImageWithInternetPath:self.imageInternetPath
                                          withCopmpletionBlock:^(NSData *imageData)
         {
             self.imageInScroll.image = [UIImage imageWithData:imageData];
             self.scrollView.contentSize = self.imageInScroll.image.size;
             [self centerScrollViewContents ];
         }];
    }];
    
    self.scrollView.minimumZoomScale = 0.75;
    self.scrollView.maximumZoomScale=3;
    
    self.scrollView.delegate = self;
    
    
    // Do any additional setup after loading the view.
}

- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = CGRectMake(0, 0, self.imageInScroll.image.size.width, self.imageInScroll.image.size.height);
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageInScroll.frame = contentsFrame;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerScrollViewContents];
    
}


-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageInScroll;
    
}




@end
