//
//  FeedManager.m
//  RSSReader
//
//  Created by Jan Seredynski on 23/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "FeedManager.h"
#import <CoreData/CoreData.h>
#import "FeedServer.h"
#import "AppDelegate.h"
#import "FeedItem.h"
#import "Parser.h"

@interface FeedManager()

@property (nonatomic, retain) NSManagedObjectContext* context;
@property (nonatomic, retain) NSOperationQueue* operationQueue;



@end


@implementation FeedManager

-(void)dealloc
{
    self.serverURL = nil;
    self.context = nil;
    self.operationQueue = nil;
    [super dealloc];
}


+(instancetype)sharedInstance
{
    static dispatch_once_t once;
    static FeedManager* sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init
{
    self = [super init];
    
    self.context = [[[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType] autorelease];
    self.context.persistentStoreCoordinator = ((AppDelegate*)[UIApplication sharedApplication].delegate).persistentStoreCoordinator;
    
    return self;
}





@end
