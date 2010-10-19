//
//  CoreLocationSampleAppDelegate.h
//  CoreLocationSample
//
//  Created by Hiroshi Hashiguchi on 10/10/20.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoreLocationSampleViewController;

@interface CoreLocationSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CoreLocationSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CoreLocationSampleViewController *viewController;

@end

