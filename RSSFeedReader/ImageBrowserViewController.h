//
//  ImageBrowserViewController.h
//  RSSReader
//
//  Created by Jan Seredynski on 27/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItem.h"
#import "ImageDisplayManager.h"
#import "NSString+MD5.h"

@interface ImageBrowserViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) FeedItem *item;

@end
