//
//  LayerShadowSampleAppDelegate.h
//  LayerShadowSample
//
//  Created by Hashiguchi Hiroshi on 11/08/08.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LayerShadowSampleViewController;

@interface LayerShadowSampleAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet LayerShadowSampleViewController *viewController;

@end
