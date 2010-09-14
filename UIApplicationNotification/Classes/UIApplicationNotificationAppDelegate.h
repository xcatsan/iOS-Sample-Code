//
//  UIApplicationNotificationAppDelegate.h
//  UIApplicationNotification
//
//  Created by Hiroshi Hashiguchi on 10/09/14.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIApplicationNotificationViewController;

@interface UIApplicationNotificationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIApplicationNotificationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIApplicationNotificationViewController *viewController;

@end

