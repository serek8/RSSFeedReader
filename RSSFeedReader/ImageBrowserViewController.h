//
//  ImageBrowserViewController.h
//  RSSReader
//
//  Created by Jan Seredynski on 27/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"
#import "NSString+MD5.h"

@interface ImageBrowserViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *imageInScroll;
@property (strong, nonatomic) NSString* imageInternetPath;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) FeedItem *item;

@end
