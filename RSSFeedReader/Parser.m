//
//  Parser.m
//  RSSReader
//
//  Created by Jan Seredynski on 21/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "Parser.h"



typedef enum : NSInteger {
    NewInstance = 0,
    DuplicateInstance
} ItemAvaliability;


@interface Parser()
{
    ItemAvaliability _flag;
}

//@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) FeedItem* item;
@property (nonatomic, strong) FeedServer* server;
@property (nonatomic, strong) NSManagedObjectContext* mainContext;
@property (nonatomic, strong) NSManagedObjectContext* context;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) Stack* tagStack;
@property (nonatomic, strong) Stack* attributeStack;
@property (nonatomic, strong) NSMutableString* element;
@property (nonatomic, strong) NSXMLParser* parser;

@end


@implementation Parser // How to crete abstract class ?

-(void)dealloc
{
    self.url=nil;
    self.item=nil;
    self.tagStack = nil;
    self.attributeStack = nil;
    self.element = nil;
    self.parser = nil;
    self.context = nil;
   [super dealloc];
}

+(instancetype)createGeneratorWithUrl:(NSString*)url
{
    Parser* inst = [[[Parser alloc] init]autorelease];
    if (inst)
    {
        inst.mainContext =((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
        inst.url = url;
        inst.tagStack = [[[Stack alloc] init] autorelease];
        inst.attributeStack = [[[Stack alloc] init] autorelease];
        inst.parser = [[[NSXMLParser alloc] initWithContentsOfURL: [NSURL URLWithString:[SettingsManager sharedInstance].serverURL]] autorelease];
        //inst.parser.delegate = inst;
        inst->_flag = NewInstance;
    
    
    }
    return inst;
}

-(void)contextChanged:(NSNotification*)notification
{
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       // Merging changes to persistant store
                       [self.mainContext mergeChangesFromContextDidSaveNotification:notification];
                   });
}

-(void) main
{

    self.context = [[[NSManagedObjectContext alloc] init] autorelease];
    self.context.persistentStoreCoordinator = self.mainContext.persistentStoreCoordinator;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contextChanged:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:self.context];
    
    // if server exists
    if((self.server = [FeedServer getFeedServerWithURL : self.url
                                      inContext: self.context]));
    else
    {
        self.server = [FeedServer insertInManagedObjectContext:self.context];
        self.server.serverUrl = self.url;
        self.server.serverName = self.url;
    }
    self.parser.delegate=self;
    [self.parser parse];
    [FeedItem deleteOldFeedItemsInContext: self.context];
}

// start of tag
-(void)     parser:(NSXMLParser *)parser
   didStartElement:(NSString *)elementName
      namespaceURI:(NSString *)namespaceURI
     qualifiedName:(NSString *)qName
        attributes:(NSDictionary *)attributeDict
{
    [self.tagStack push:elementName];
    //[self.tagStack printFromBottom];
    self.element = [NSMutableString string];
    [self.attributeStack push:attributeDict];
    // if new item tag is being detected I create a new Item instance NSManagaedObject
    if ([elementName isEqualToString:@"item"])
    {
        
        self.item= [FeedItem insertInManagedObjectContext:self.context ];
        [self.server addFeedItemRelationshipObject:self.item];
    }
    
}

-(void) parser  :(NSXMLParser *)parser
 foundCharacters:(NSString *)element
{
    //self.element = element;
    [self.element appendString:element];
}

// end of tag
-(void) parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"title"])
    {
        [self.tagStack pop];
        [self.attributeStack pop];
        if(_flag) return;
        
        if([self.tagStack.showTop isEqualToString:@"item"])
        {
            self.item.itemTitle = self.element;
        }
        else if([self.tagStack.showTop isEqualToString:@"channel"])
        {
            self.server.serverName = self.element;
        }
    }
    
    else if ([elementName isEqualToString:@"description"])
    {
        [self.tagStack pop];
        [self.attributeStack pop];
        [self.attributeStack pop];
        if(_flag) return;
        
        if([self.tagStack.showTop isEqualToString:@"item"])
        {
            self.item.itemDetail = self.element;
            
        }
    }
    
    else if ([elementName isEqualToString:@"link"])
    {
        [self.tagStack pop];
        [self.attributeStack pop];
        if(_flag) return;
        
        if([self.tagStack.showTop isEqualToString:@"item"])
        {
            self.item.itemLink = self.element;
        }
    }
    
    else if ([elementName isEqualToString:@"guid"]) // checks for duplicate
    {
        [self.tagStack pop];
        [self.attributeStack pop];
        if([self.tagStack.showTop isEqualToString:@"item"])
        {
            // if duplicate exists
            if([FeedItem isSetItemWithGUID:self.element inContext:self.context] == YES)
            {
                _flag=1;
                self.item = nil;
                //[self.context rollback ];
            }
            else
            {
                self.item.itemGuid = [self.element md5];
            }
        }
    }
    
    else if ([elementName isEqualToString:@"pubDate"])
    {
        [self.tagStack pop];
        [self.attributeStack pop];
        if(_flag) return;
        
        if([self.tagStack.showTop isEqualToString:@"item"])
        {
            NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
            [dateFormat setDateFormat:@"EE, d LLLL yyyy HH:mm:ss Z"];
            NSDate *date = [dateFormat dateFromString:self.element];
            //[dateFormat release];
            self.item.itemPublicationDate = date;
        }
    }
    
    else if ([elementName isEqualToString:@"media:thumbnail"] ||
             [elementName isEqualToString:@"media:content"])
    {
        [self.tagStack pop];
        if(_flag) return;
        if([self.tagStack.showTop isEqualToString:@"item"])
        {
            NSError *error;
            [self.context save:&error];
            
            FeedImage *image = [FeedImage insertInManagedObjectContext:self.context];
            image.imageWidth = @([[[self.attributeStack showTop ] objectForKey:@"width"] integerValue]);
            image.imageHeight = @([[[self.attributeStack showTop] objectForKey:@"height"] integerValue]);
            image.imageUrl = [[self.attributeStack showTop ] objectForKey:@"url"];
            
            [self.item addFeedImageRelationshipObject:image];
            
            [self.attributeStack pop];
        }
    }
    else if([elementName isEqualToString:@"item"])
    {
        [self.tagStack pop];
        [self.attributeStack pop];
        if(_flag) { _flag=NewInstance; return;}
        NSError *error;
        [self.context save:&error];
    }
    else if (self.server.serverImageUrl == nil && [elementName isEqualToString:@"url"])
    {
        [self.tagStack pop];
        [self.attributeStack pop];
        if(_flag) return;
        
        if([self.tagStack.showTop isEqualToString:@"image"])
        {
            NSString *str;
            str = [self.element stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
            self.server.serverImageUrl = str;
            NSError *error;
            [self.context save:&error];
        }
    }
    // if we dont recognize tag just leave it - drop out from stack
    else
    {
        [self.tagStack pop];
        [self.attributeStack pop];
        return;
    }
  
}


@end


