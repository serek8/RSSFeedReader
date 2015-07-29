//
//  SettingsManager.m
//  RSSReader
//
//  Created by Jan Seredynski on 28/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "SettingsManager.h"

@implementation SettingsManager


+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    static SettingsManager* sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    
    
    
    
    
    return sharedInstance;
}

-(NSString*)serverURL
{
    
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"feedUrl"] == nil)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@DEFAULT_FEED_URL
                                                 forKey:@"feedUrl"];
        _serverURL = @DEFAULT_FEED_URL;
    }
    else if(_serverURL==nil) _serverURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"feedUrl"];
    
    return _serverURL;
    
}


-(void)updateServerURL
{
    _serverURL =[[NSUserDefaults standardUserDefaults] stringForKey:@"feedUrl"];
}



@end
