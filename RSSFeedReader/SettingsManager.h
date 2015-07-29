//
//  SettingsManager.h
//  RSSReader
//
//  Created by Jan Seredynski on 28/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEFAULT_FEED_URL "http://feeds.bbci.co.uk/news/rss.xml"

@interface SettingsManager : NSObject

@property (nonatomic, strong) NSString* serverURL;


+(instancetype)sharedInstance;

-(void)updateServerURL;





@end
