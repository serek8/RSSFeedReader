//
//  AnyImageDisplayOperation.h
//  RSSFeedReader
//
//  Created by Jan Seredynski on 04/08/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ImageDisplayManager.h"

@interface AnyImageDisplayOperation : NSOperation

-(instancetype)initWithInternetPath:(NSString*)internetPath
              forImageView:(UIImageView*)imageView
        withCopletionBlock:(compBlock)completionBlock;

@end
