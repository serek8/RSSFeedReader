//
//  Stack.m
//  RSSReader
//
//  Created by Jan Seredynski on 21/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "Stack.h"

@interface Stack()

@property (nonatomic,strong) NSMutableArray* m_array;

@end

@implementation Stack

- (instancetype)init
{
    if( self=[super init] )
    {
        self.m_array = [NSMutableArray array];
    }
    return self;
}
- (void)dealloc
{
    self.m_array = nil;
    [super dealloc];
}
- (void)push:(id)anObject
{
    [self.m_array addObject:anObject];
}
- (id)pop
{
    id obj = nil;
    if(self.m_array.count > 0)
    {
        obj = [[[self.m_array lastObject]retain] autorelease];
        [self.m_array removeLastObject];
    }
    return obj;
}
- (void)clear
{
    [self.m_array removeAllObjects];
}
- (void)printFromBottom
{
    NSMutableString *print = [[[NSMutableString alloc] init] autorelease];
    [print appendString:@"{\n"];

    for(id tobj in self.m_array)
    {
        [print appendString: [NSString stringWithFormat:@"%@\n", [tobj description]]];
    }
    [print appendString:@"\n}"];
    NSLog(@"%@", print);
}

- (id)showTop
{
    return self.m_array.lastObject;
}
@end