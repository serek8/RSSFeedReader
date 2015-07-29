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
    

    if(_serverURL==nil) [self updateServerURL];
    return _serverURL;
    
}


-(void)updateServerURL
{
    if([[NSUserDefaults standardUserDefaults] stringForKey:@"chosenFeed"] == nil ||
       [[NSUserDefaults standardUserDefaults] boolForKey:@"isCustomUrl"] == YES)
    {
        _serverURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"feedUrl"];
    }
    
    else if([[NSUserDefaults standardUserDefaults] boolForKey:@"isCustomUrl"] == NO)
    {
        _serverURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"chosenFeed"];
    }
    
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:@DEFAULT_FEED_URL
                                                 forKey:@"feedUrl"];
        _serverURL = @DEFAULT_FEED_URL;
    }
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"SettingsUpdatedNotification"
     object:nil];
    
    
}



@end
