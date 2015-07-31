//
//  ImageDisplayOperation.h
//  RSSFeedReader
//
//  Created by Jan Seredynski on 31/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FeedItem.h"


@interface ImageDisplayOperation : NSOperation

-(instancetype)initWithIconOfFeedItem:(FeedItem*)item forImageView:(UIImageView*)imageView;




@end
