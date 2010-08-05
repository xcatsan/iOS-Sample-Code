//
//  NSObject_Extension.h
//  PerformSelectorAfterDelay
//
//  Created by Hiroshi Hashiguchi on 10/07/30.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Extension)
//- (void)performBlock:(void (^)(id selfObject))block afterDelay:(NSTimeInterval)delay;
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
