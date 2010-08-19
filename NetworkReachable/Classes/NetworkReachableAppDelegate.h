//
//  NetworkReachableAppDelegate.h
//  NetworkReachable
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetworkReachableViewController;

@interface NetworkReachableAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    NetworkReachableViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet NetworkReachableViewController *viewController;

@end

