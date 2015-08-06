//
//  ImageDisplayManager.m
//  RSSFeedReader
//
//  Created by Jan Seredynski on 31/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "ImageDisplayManager.h"
#import "AnyImageDisplayOperation.h"
#import <UIKit/UIKit.h>

@implementation ImageDisplayManager

-(void)dealloc
{
    self.downloadImageDictionary = nil;
    self.operationQueue = nil;
    [super dealloc];
}

+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    static ImageDisplayManager* sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


-(instancetype)init
{
    self = [super init];
    if(!self) return nil;
    self.downloadImageDictionary = [[[NSMutableDictionary alloc] init] autorelease];
    self.operationQueue = [[[NSOperationQueue alloc]init] autorelease];
    [[NSFileManager defaultManager] createDirectoryAtPath:
     [NSHomeDirectory() stringByAppendingString: @"/Library/Caches/Images"]
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:nil];

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

-(void)queueDisplayImageWithInternetPath:(NSString*)internetPath
               withCompletionBlock: (compBlock)complBlock
{
    AnyImageDisplayOperation *loadImageoperation = [[[AnyImageDisplayOperation alloc]
                                                  initWithInternetPath:internetPath
                                                     withCopletionBlock:complBlock ] autorelease];
    [self.operationQueue addOperation: loadImageoperation];
}


+(void) downloadItemImageWithInternetPath:(NSString*)imageInternetPath
                     withCopmpletionBlock:(completionBlock)block
{
    NSString* path = [NSHomeDirectory() stringByAppendingString:
                      [NSString stringWithFormat:@"/Library/Caches/Images/%@",
                       [imageInternetPath md5]]];
    
    //if file is not yet downloaded from the internet we fetch it and store in core data
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:path] &&
       ![[ImageDisplayManager sharedInstance].downloadImageDictionary valueForKeyPath:path])
    {
        [[ImageDisplayManager sharedInstance].downloadImageDictionary setValue:@1 forKey:path];
        NSData* imgData =  [NSData dataWithContentsOfURL:
                            [NSURL URLWithString:imageInternetPath]];
        [imgData writeToFile:path
                  atomically:YES];
    }
    
    // Now the image must be in core data so we fetch it
    
    NSData* retData = [NSData dataWithContentsOfFile:path];
    dispatch_sync(dispatch_get_main_queue(), ^{
        block(retData);
    });
}


@end
