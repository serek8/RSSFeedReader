//
//  FeedManager.h
//  RSSReader
//
//  Created by Jan Seredynski on 23/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedManager : NSObject


@property (nonatomic, retain) NSString* serverURL;
@property (nonatomic, retain) NSString* serverName;

+(instancetype)sharedInstance;
//-(void)refreshFeeds;



@end
