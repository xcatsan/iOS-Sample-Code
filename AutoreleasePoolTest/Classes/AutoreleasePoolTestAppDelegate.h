//
//  AutoreleasePoolTestAppDelegate.h
//  AutoreleasePoolTest
//
//  Created by Hiroshi Hashiguchi on 10/10/15.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class AutoreleasePoolTestViewController;

@interface AutoreleasePoolTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AutoreleasePoolTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AutoreleasePoolTestViewController *viewController;

@end

