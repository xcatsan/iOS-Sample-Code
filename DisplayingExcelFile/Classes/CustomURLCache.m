//
//  CustomURLCache.m
//  DisplayingExcelFile
//
//  Created by Hiroshi Hashiguchi on 11/01/10.
//  Copyright 2011 . All rights reserved.
//

#import "CustomURLCache.h"


@implementation CustomURLCache

-(NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request
{
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, request);
	return [super cachedResponseForRequest:request];
}

@end
