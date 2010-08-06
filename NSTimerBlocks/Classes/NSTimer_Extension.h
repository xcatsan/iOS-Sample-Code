//
//  NSTimer_Extension.h
//  NSTimerBlocks
//
//  Created by Hiroshi Hashiguchi on 10/08/05.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TIMER_BLOCK__)(NSTimer*);

@interface NSTimer (Extension)

//+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(TIMER_BLOCK__)block userInfo:(id)userInfo repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(TIMER_BLOCK__)block repeats:(BOOL)repeats;

@end
