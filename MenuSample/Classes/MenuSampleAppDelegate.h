//
//  MenuSampleAppDelegate.h
//  MenuSample
//
//  Created by Hiroshi Hashiguchi on 10/10/01.
//  Copyright Hiroshi Hashiguchi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuSampleViewController;

@interface MenuSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MenuSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MenuSampleViewController *viewController;

@end

