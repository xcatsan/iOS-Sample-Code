//
//  Queue.m
//  BackgroundQueueSample
//
//  Created by Hiroshi Hashiguchi on 11/04/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Queue.h"


@implementation Queue

@synthesize queue;

- (id)init {
    self = [super init];
    if (self) {
        self.queue = [NSMutableArray array];
    }
    return self;
}
- (void)dealloc {
    self.queue = nil;
    [super dealloc];
}

- (void)putObject:(id)object
{
    @synchronized (self) {
        [self.queue addObject:object];
    }
}

- (id)getObject
{
    @synchronized (self) {
        if ([self.queue count] > 0) {
            return [self.queue objectAtIndex:0];
        } else {
            return nil;
        }
    }
}

- (void)removeObject
{
    @synchronized (self) {
        if ([self.queue count] > 0) {
            [self.queue removeObjectAtIndex:0];
        }
    }
}

- (NSUInteger)count
{
    return [self.queue count];
}

- (NSArray*)list
{
    return queue;
}

@end
