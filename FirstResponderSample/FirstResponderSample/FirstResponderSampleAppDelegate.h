//
//  FirstResponderSampleAppDelegate.h
//  FirstResponderSample
//
//  Created by Hashiguchi Hiroshi on 11/08/22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FirstResponderSampleViewController;

@interface FirstResponderSampleAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet FirstResponderSampleViewController *viewController;

@end
