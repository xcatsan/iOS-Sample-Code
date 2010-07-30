//
//  PerformSelectorAfterDelayAppDelegate.h
//  PerformSelectorAfterDelay
//
//  Created by Hiroshi Hashiguchi on 10/07/30.
//  Copyright Hiroshi Hashiguchi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PerformSelectorAfterDelayViewController;

@interface PerformSelectorAfterDelayAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PerformSelectorAfterDelayViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PerformSelectorAfterDelayViewController *viewController;

@end

