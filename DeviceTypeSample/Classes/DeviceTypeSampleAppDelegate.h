//
//  DeviceTypeSampleAppDelegate.h
//  DeviceTypeSample
//
//  Created by Hiroshi Hashiguchi on 10/09/12.
//  Copyright Hiroshi Hashiguchi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DeviceTypeSampleViewController;

@interface DeviceTypeSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DeviceTypeSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DeviceTypeSampleViewController *viewController;

@end

