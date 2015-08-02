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
        NSData *imageData;
    imageData = [self downloadItemMedia];

        dispatch_async(dispatch_get_main_queue(), ^{
        //self.imageView.image = [UIImage imageWithData:imageData];
        [self.imageView setImage:[UIImage imageWithData:imageData]];

        });
}

-(NSData*) downloadItemMedia
{
    
    NSString* path = [NSHomeDirectory() stringByAppendingString:
                      [NSString stringWithFormat:@"/Library/Caches/Images/%@",
                       [self.imageInternetPath md5]]];
    
    //if file is not yet downloaded from the internet we fetch it and store in core data
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        
        
        NSData* imgData =  [NSData dataWithContentsOfURL:
                            [NSURL URLWithString:self.imageInternetPath]];
        [imgData writeToFile:path
                  atomically:YES];
        
    }
    
    // Now the image must be in core data so we fetch it
    
    NSData* retData = [NSData dataWithContentsOfFile:path];
    return retData;
}



@end
