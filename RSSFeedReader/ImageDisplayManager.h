//
//  ImageDisplayManager.h
//  RSSFeedReader
//
//  Created by Jan Seredynski on 31/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"
#import <UIKit/UIKit.h>
#import "ImageDisplayOperation.h"

@interface ImageDisplayManager : NSObject


@property (nonatomic, retain) NSOperationQueue* operationQueue;
+(instancetype)sharedInstance;
-(void)queueDisplayImageOfFeedItem:(FeedItem*)item inImageView:(UIImageView*)imageView;

@end
