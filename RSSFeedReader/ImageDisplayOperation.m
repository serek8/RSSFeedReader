//
//  ImageDisplayOpetation.m
//  RSSFeedReader
//
//  Created by Jan Seredynski on 31/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//
#import "NSString+MD5.h"
#import "FeedItem.h"
#import <UIKit/UIKit.h>
#import "ImageDisplayOperation.h"

@interface ImageDisplayOperation()


@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) NSString *imageInternetPath;

@end


@implementation ImageDisplayOperation


-(void)dealloc
{
    self.imageView = nil;
    self.imageInternetPath = nil;
    [super dealloc];
}


-(instancetype)initWithIconOfFeedItem:(FeedItem*)item forImageView:(UIImageView*)imageView
{
    self = [super init];
    if(!self) return nil;
    
    self.imageView = imageView;
    self.imageInternetPath = [item findIconInternetPath];
    return self;
}

-(void)main
{

        [ImageDisplayManager downloadItemImageWithInternetPath:self.imageInternetPath
                                          withCopmpletionBlock:^(NSData *imageData) {
                                              [self.imageView setImage:[UIImage imageWithData:imageData]];
                                          }];
   
}




@end
