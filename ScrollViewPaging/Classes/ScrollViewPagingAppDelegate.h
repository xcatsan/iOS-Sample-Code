//
//  ScrollViewPagingAppDelegate.h
//  ScrollViewPaging
//
//  Created by Hiroshi Hashiguchi on 10/10/06.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollViewPagingViewController;

@interface ScrollViewPagingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ScrollViewPagingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ScrollViewPagingViewController *viewController;

@end

