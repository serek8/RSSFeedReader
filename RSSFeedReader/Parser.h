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
#import "FeedImage.h"
#import <CoreData/CoreData.h>
#import "NSString+MD5.h"
#import "SettingsManager.h"
#import "ParserManager.h"

@interface Parser : NSOperation <NSXMLParserDelegate>
{

    
}

+(instancetype)createParseOperationWithUrl:(NSString*)url;


@end
