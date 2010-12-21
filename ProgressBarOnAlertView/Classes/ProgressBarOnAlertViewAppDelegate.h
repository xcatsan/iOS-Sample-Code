//
//  ProgressBarOnAlertViewAppDelegate.h
//  ProgressBarOnAlertView
//
//  Created by Hiroshi Hashiguchi on 10/12/21.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProgressBarOnAlertViewViewController;

@interface ProgressBarOnAlertViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ProgressBarOnAlertViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ProgressBarOnAlertViewViewController *viewController;

@end

