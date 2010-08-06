//
//  NSTimer_Extension.m
//  NSTimerBlocks
//
//  Created by Hiroshi Hashiguchi on 10/08/05.
//  Copyright 2010 . All rights reserved.
//

#import "NSTimer_Extension.h"

@implementation NSTimer (Extension)

/*
 #define KEY_BLOCK		@"block"
 #define KEY_USERINFO	@"userInfo"
+ (void)executeBlock__:(NSTimer*)timer
{
	if (![timer isValid]) {
		return;
		// do nothing
	}

	NSDictionary* context = [timer userInfo];
	TIMER_BLOCK__ block = [context objectForKey:KEY_BLOCK];
	id userInfo = [context objectForKey:KEY_USERINFO];

	block(timer, userInfo);
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(TIMER_BLOCK__)block userInfo:(id)userInfo repeats:(BOOL)repeats
{
	NSMutableDictionary* context = [NSMutableDictionary dictionary];

	[context setObject:[[block copy] autorelease]
				forKey:KEY_BLOCK];
	if (userInfo) {
		[context setObject:userInfo forKey:KEY_USERINFO];
	}

	NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:seconds
													  target:self
													selector:@selector(executeBlock__:)
													userInfo:context
													repeats:repeats];
	return timer;
}
*/

+ (void)executeBlock__:(NSTimer*)timer
{
	if (![timer isValid]) {
		return;
		// do nothing
	}
	
	TIMER_BLOCK__ block = [timer userInfo];
	block(timer);
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(TIMER_BLOCK__)block repeats:(BOOL)repeats
{
	NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:seconds
			  target:self
			selector:@selector(executeBlock__:)
			userInfo:[[block copy] autorelease]
			 repeats:repeats];
	return timer;
	
}


@end
