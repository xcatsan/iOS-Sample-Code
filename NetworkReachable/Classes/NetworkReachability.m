//
//  NetworkReachability.m
//  NetworkReachable
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright 2010 . All rights reserved.
//

#import "NetworkReachability.h"

#import <arpa/inet.h>
#import <ifaddrs.h>
#import <net/if.h>

@interface NetworkReachability()
- (BOOL)startNotifier_;
@end


@implementation NetworkReachability

#pragma mark -
#pragma mark Initailization
- (id)initWithHostname:(NSString*)hostname
{
	if (self = [super init]) {
		reachability_=
		SCNetworkReachabilityCreateWithName(kCFAllocatorDefault,
											[hostname UTF8String]);
		connectionMode_ = kNetworkReachableUninitialization;		
		[self startNotifier_];
	}
	return self;
}

+ (NetworkReachability*)networkReachabilityWithHostname:(NSString *)hostname
{
	return [[[self alloc] initWithHostname:hostname] autorelease];
}

- (void) dealloc
{
	CFRelease(reachability_);
	[super dealloc];
}


#pragma mark -
#pragma mark Utilities (private)
- (NSString*)getWiFiIPAddress_
{
	BOOL success;
	struct ifaddrs * addrs;
	const struct ifaddrs * cursor;
	
	success = getifaddrs(&addrs) == 0;
	if (success) {
		cursor = addrs;
		while (cursor != NULL) {
			if (cursor->ifa_addr->sa_family == AF_INET
				&& (cursor->ifa_flags & IFF_LOOPBACK) == 0) {
				NSString *name =
				[NSString stringWithUTF8String:cursor->ifa_name];
				
				if ([name isEqualToString:@"en0"] ||
					[name isEqualToString:@"en1"]) { // found the WiFi adapter
					NSString* addressString = [NSString stringWithUTF8String:
											   inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
					freeifaddrs(addrs);
					return addressString;
				}
			}
			
			cursor = cursor->ifa_next;
		}
		freeifaddrs(addrs);
	}
	return NULL;
}

- (NetworkReachabilityConnectionMode)getConnectionModeWithFlags_:(SCNetworkReachabilityFlags)flags
{
	BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
	BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
	if (isReachable && !needsConnection) {
		if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
			return kNetworkReachableWWAN;
		}
		
		if ([self getWiFiIPAddress_]) {
			return kNetworkReachableWiFi;
		}
		
	}
	return kNetworkReachableNon;	
}

- (void)updateConnectionModeWithFlags_:(SCNetworkReachabilityFlags)flags
{
	connectionMode_ = [self getConnectionModeWithFlags_:flags];
}



static void ReachabilityCallback_(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
	NSAutoreleasePool* myPool = [[NSAutoreleasePool alloc] init];
	
	NetworkReachability* noteObject = (NetworkReachability*)info;
	[noteObject updateConnectionModeWithFlags_:flags];
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:NetworkReachabilityChangedNotification object:noteObject];
	
	[myPool release];
}

- (BOOL)startNotifier_
{
	BOOL ret = NO;
	SCNetworkReachabilityContext context = {0, self, NULL, NULL, NULL};
	if(SCNetworkReachabilitySetCallback(reachability_, ReachabilityCallback_, &context))
	{
		if(SCNetworkReachabilityScheduleWithRunLoop(
													reachability_, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
		{
			ret = YES;
		}
	}
	return ret;
}	

- (void) stopNotifier_
{
	if(reachability_!= NULL)
	{
		SCNetworkReachabilityUnscheduleFromRunLoop(reachability_, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
	}
}


#pragma mark -
#pragma mark Public methods
- (NSString*)connectionModeString
{
	NSString* desc;
	
	switch (connectionMode_) {
		case kNetworkReachableUninitialization:
			desc = @"Not initialized";
			break;
			
		case kNetworkReachableNon:
			desc = @"Not available";
			break;
			
		case kNetworkReachableWWAN:
			desc = @"WWAN";
			break;
			
		case kNetworkReachableWiFi:
			desc = @"WiFi";
			break;
			
	}
	return desc;
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"Connection Mode: %@", [self connectionModeString]];
}

- (NetworkReachabilityConnectionMode)connectionMode
{
	return connectionMode_;
}

@end
