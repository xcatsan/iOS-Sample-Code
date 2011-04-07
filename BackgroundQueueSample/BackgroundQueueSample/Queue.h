//
//  Queue.h
//  BackgroundQueueSample
//
//  Created by Hiroshi Hashiguchi on 11/04/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Queue : NSObject {

}
@property (retain) NSMutableArray* queue;

- (void)putObject:(id)object;
- (id)getObject;
- (void)removeObject;
- (NSUInteger)count;
- (NSArray*)list;

@end
