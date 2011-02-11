//
//  LazyStartSampleAppDelegate.h
//  LazyStartSample
//
//  Created by Hiroshi Hashiguchi on 11/02/11.
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class LazyStartSampleViewController;

@interface LazyStartSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    LazyStartSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet LazyStartSampleViewController *viewController;

@end

