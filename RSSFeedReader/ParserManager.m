//
//  ParserManager.m
//  RSSReader
//
//  Created by Jan Seredynski on 28/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "ParserManager.h"
#include "Parser.h"

@interface ParserManager()

@property (retain, nonatomic) NSOperationQueue *operationQueue;


@end

@implementation ParserManager

-(void)dealloc
{
    self.operationQueue = nil;
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
    self.operationQueue = [[[NSOperationQueue alloc] init] autorelease];
    return self;
}

-(void)parse: (NSString*) url
{
   // self.operationQueue.maxConcurrentOperationCount = 3;
    [self.operationQueue addOperation:[Parser createGeneratorWithUrl:url]];
   
}



@end
