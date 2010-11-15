//
//  SampleKitClientAppDelegate.h
//  SampleKitClient
//
//  Created by Hiroshi Hashiguchi on 10/11/15.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class SampleKitClientViewController;

@interface SampleKitClientAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SampleKitClientViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SampleKitClientViewController *viewController;

@end

