//
//  HorizontalScrollableUITableViewAppDelegate.h
//  HorizontalScrollableUITableView
//
//  Created by Hiroshi Hashiguchi on 10/10/19.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalScrollableUITableViewViewController;

@interface HorizontalScrollableUITableViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HorizontalScrollableUITableViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HorizontalScrollableUITableViewViewController *viewController;

@end

