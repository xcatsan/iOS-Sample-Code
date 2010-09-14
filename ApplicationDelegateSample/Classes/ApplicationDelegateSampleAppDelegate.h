//
//  ApplicationDelegateSampleAppDelegate.h
//  ApplicationDelegateSample
//
//  Created by Hiroshi Hashiguchi on 10/09/13.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApplicationDelegateSampleViewController;

@interface ApplicationDelegateSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ApplicationDelegateSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ApplicationDelegateSampleViewController *viewController;

@end

