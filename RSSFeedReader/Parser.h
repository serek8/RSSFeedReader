//
//  Parser.h
//  RSSReader
//
//  Created by Jan Seredynski on 21/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedItem.h"
#import "FeedServer.h"
#import "AppDelegate.h"
#import "Stack.h"

@interface Parser : NSOperation <NSXMLParserDelegate>

+(instancetype)createGeneratorWithUrl:(NSString*)url;


@end
