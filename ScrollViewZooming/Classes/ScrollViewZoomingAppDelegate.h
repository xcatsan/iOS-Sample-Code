//
//  ScrollViewZoomingAppDelegate.h
//  ScrollViewZooming
//
//  Created by Hiroshi Hashiguchi on 10/10/04.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollViewZoomingViewController;

@interface ScrollViewZoomingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ScrollViewZoomingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ScrollViewZoomingViewController *viewController;

@end

