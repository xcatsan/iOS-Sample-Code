//
//  TransitionSampleAppDelegate.h
//  TransitionSample
//
//  Created by Hiroshi Hashiguchi on 10/10/14.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransitionSampleViewController;

@interface TransitionSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TransitionSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TransitionSampleViewController *viewController;

@end

