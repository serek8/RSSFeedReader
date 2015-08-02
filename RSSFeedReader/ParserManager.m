//
//  ParserManager.m
//  RSSReader
//
//  Created by Jan Seredynski on 28/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "ParserManager.h"
#import "Parser.h"

#import "SettingsManager.h"


@interface ParserManager()
{
    NetworkStatus networkStatus;
}

@property (retain, nonatomic) NSOperationQueue *operationQueue;
@property (retain, nonatomic) Reachability *reachability;

@end

@implementation ParserManager

-(void)dealloc
{
    self.operationQueue = nil;
    [self.reachability stopNotifier];
    self.reachability=nil;
    [super dealloc];
}

+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    static ParserManager* sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


-(ParserManager*)init
{
    if(![super init]) return nil;
    self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectionStatusDidChange:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    return self;
}

-(NetworkStatus)currentNetworkStatus
{
    return self.reachability.currentReachabilityStatus;
}

-(void)connectionStatusDidChange:(NSNotification *) notification
{
    if(networkStatus == NotReachable && self.reachability.currentReachabilityStatus != NotReachable)
    {
        [self parse:[SettingsManager sharedInstance].serverURL];
    }
    networkStatus=self.reachability.currentReachabilityStatus;
}


-(void)parse: (NSString*) url
{
    if(self.reachability.currentReachabilityStatus ==  NotReachable) return;
    [self.operationQueue addOperation:[Parser createGeneratorWithUrl:url]];
}



@end
