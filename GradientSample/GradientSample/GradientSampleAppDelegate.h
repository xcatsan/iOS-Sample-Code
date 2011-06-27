//
//  GradientSampleAppDelegate.h
//  GradientSample
//
//  Created by Hiroshi Hashiguchi on 11/06/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GradientSampleViewController;

@interface GradientSampleAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet GradientSampleViewController *viewController;

@end
