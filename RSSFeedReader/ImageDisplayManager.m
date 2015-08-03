//
//  ImageDisplayManager.m
//  RSSFeedReader
//
//  Created by Jan Seredynski on 31/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "ImageDisplayManager.h"


@implementation ImageDisplayManager


+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    static ImageDisplayManager* sharedInstance;
    dispatch_once(&once, ^{
        
        // DO NOT DEALLOC !!
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


-(instancetype)init
{
    self = [super init];
    if(!self) return nil;
    
    self.operationQueue = [[[NSOperationQueue alloc]init] autorelease];
    return self;
}

// All pointers in MRC are week but in ARE they are strong
-(void)queueDisplayImageOfFeedItem:(FeedItem*)item inImageView:(UIImageView*)imageView
{
    ImageDisplayOperation *loadImageoperation = [[[ImageDisplayOperation alloc]
                                                 initWithIconOfFeedItem:item
                                                 forImageView:imageView] autorelease];
    [self.operationQueue addOperation: loadImageoperation];
}

+(NSData*) downloadItemImageWithInternetPath:(NSString*)imageInternetPath
{
    
    NSString* path = [NSHomeDirectory() stringByAppendingString:
                      [NSString stringWithFormat:@"/Library/Caches/Images/%@",
                       [imageInternetPath md5]]];
    
    //if file is not yet downloaded from the internet we fetch it and store in core data
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        
        
        NSData* imgData =  [NSData dataWithContentsOfURL:
                            [NSURL URLWithString:imageInternetPath]];
        [imgData writeToFile:path
                  atomically:YES];
        
    }
    
    // Now the image must be in core data so we fetch it
    
    NSData* retData = [NSData dataWithContentsOfFile:path];
    return retData;
}



@end
