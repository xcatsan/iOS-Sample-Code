//
//  WaitScreenSampleAppDelegate.h
//  WaitScreenSample
//
//  Created by Hiroshi Hashiguchi on 10/09/13.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaitScreenSampleViewController;

@interface WaitScreenSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    WaitScreenSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet WaitScreenSampleViewController *viewController;

@end

