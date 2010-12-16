//
//  NetworkReachability.h
//  NetworkReachable
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

typedef enum {
	kNetworkReachableUninitialization = 0,
	kNetworkReachableNon,
	kNetworkReachableWiFi,
	kNetworkReachableWWAN
} NetworkReachabilityConnectionMode;

#define NetworkReachabilityChangedNotification @"NetworkReachabilityChangedNotification"

@interface NetworkReachability : NSObject {

	SCNetworkReachabilityRef reachability_;
	NetworkReachabilityConnectionMode connectionMode_;
}

+ (NetworkReachability*)networkReachabilityWithHostname:(NSString *)hostname;
- (NetworkReachabilityConnectionMode)connectionMode;
- (NSString*)connectionModeString;

@end
