//
//  CGSampleAppDelegate.h
//  CGSample
//
//  Created by Hashiguchi Hiroshi on 11/08/24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CGSampleViewController;

@interface CGSampleAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CGSampleViewController *viewController;

@end
