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
#import "NSString+MD5.h"

typedef void(^completionBlock)(NSData*);
typedef void(^compBlock)();

@interface ImageDisplayManager : NSObject



@property (nonatomic, retain) NSOperationQueue* operationQueue;
+(instancetype)sharedInstance;
-(void)queueDisplayImageOfFeedItem:(FeedItem*)item inImageView:(UIImageView*)image;
-(void)queueDisplayImageWithInternetPath:(NSString*)internetPath
                       inImageView:(UIImageView*)imageView
               withCompletionBlock: (compBlock)complBlock;


+(void) downloadItemImageWithInternetPath:(NSString*)imageInternetPath
                     withCopmpletionBlock:(completionBlock)block;
@end
