//
//  ParserManager.m
//  RSSReader
//
//  Created by Jan Seredynski on 28/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "ParserManager.h"



@interface ParserManager()
{
    NetworkStatus networkStatus;
}

@property (retain, nonatomic) NSOperationQueue *operationQueue;
@property (retain, nonatomic) Reachability *reachability;
@property (retain, nonatomic) NSString *currentParsingServerUrl;
//@property (retain, nonatomic) NSOperation *operation;

@end

@implementation ParserManager

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.operationQueue = nil;
    self.currentParsingServerUrl = nil;
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
    self.operationQueue.maxConcurrentOperationCount = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectionStatusDidChange:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    self.reachability = [Reachability reachabilityForInternetConnection];
    [self.reachability startNotifier];
    //self.currentParsingServerUrl = [SettingsManager sharedInstance].serverURL;
    return self;
}

-(NetworkStatus)currentNetworkStatus
{
    return self.reachability.currentReachabilityStatus;
}

-(void)connectionStatusDidChange:(NSNotification *) notification
{
    // Disconnected -> Connected
    if(networkStatus == NotReachable && self.reachability.currentReachabilityStatus != NotReachable)
    {
        [self parse:[SettingsManager sharedInstance].serverURL];
        self.currentParsingServerUrl = nil;
        
    }
    networkStatus=self.reachability.currentReachabilityStatus;
}


-(void)parse: (NSString*) url
{
    if([self.currentParsingServerUrl isEqualToString:url]) return; // server didn't change, so return
    if(self.reachability.currentReachabilityStatus ==  NotReachable) return; // no connection so return
    self.currentParsingServerUrl = url;
    [self.operationQueue cancelAllOperations];
    [self.operationQueue addOperation:[Parser createParseOperationWithUrl:url]];
}



@end
