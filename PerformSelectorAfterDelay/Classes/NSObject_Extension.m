//
//  NSObject_Extension.m
//  PerformSelectorAfterDelay
//
//  Created by Hiroshi Hashiguchi on 10/07/30.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "NSObject_Extension.h"


@implementation NSObject (Extension)


/*
- (void)executeBlock:(void (^)(id selfObject))block
{
	block(self);
}

- (void)performBlock:(void (^)(id selfObject))block afterDelay:(NSTimeInterval)delay
{
	[self performSelector:@selector(executeBlock:)
			   withObject:block
			   afterDelay:delay];
}
*/

- (void)executeBlock__:(void (^)(void))block
{
	block();
	[block release];
}

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
	[self performSelector:@selector(executeBlock__:)
			   withObject:[block copy]
			   afterDelay:delay];
}

@end
