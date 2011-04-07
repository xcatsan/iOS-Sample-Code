//
//  BackgroundQueueSampleAppDelegate.h
//  BackgroundQueueSample
//
//  Created by Hiroshi Hashiguchi on 11/04/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Queue;
@class RootViewController;
@interface BackgroundQueueSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIBackgroundTaskIdentifier backgroundTaskIdentifer;
}
@property (nonatomic, retain) IBOutlet RootViewController* rootViewController;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
