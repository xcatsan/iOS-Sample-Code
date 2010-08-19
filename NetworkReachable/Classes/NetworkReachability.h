//
//  NetworkReachability.h
//  NetworkReachable
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

enum {
	kNetworkReachableNon = 0,
	kNetworkReachableWiFi,
	kNetworkReachableWWAN
};

#define NetworkReachabilityChangedNotification @"NetworkReachabilityChangedNotification"

@interface NetworkReachability : NSObject {

	SCNetworkReachabilityRef reachability_;
}

- (id)initWithHostname:(NSString*)hostname;
+ (NetworkReachability*)networkReachabilityWithHostname:(NSString *)hostname;

- (NSInteger)getConnectionMode;

- (BOOL) startNotifier;
- (void) stopNotifier;

@end
