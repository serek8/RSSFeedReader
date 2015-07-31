//
//  ImageDisplayOpetation.m
//  RSSFeedReader
//
//  Created by Jan Seredynski on 31/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "FeedItem.h"
#import <UIKit/UIKit.h>
#import "ImageDisplayOperation.h"

@interface ImageDisplayOperation()


@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) FeedItem *item;

@end


@implementation ImageDisplayOperation

-(instancetype)initWithIconOfFeedItem:(FeedItem*)item forImageView:(UIImageView*)imageView
{
    self = [super init];
    if(!self) return nil;
    
    self.imageView = imageView;
    self.item = item;
    return self;
}

-(void)main
{
        NSData *imageData;
        imageData = [self.item getItemIcon];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = [UIImage imageWithData:imageData];
            
        });
}





@end
