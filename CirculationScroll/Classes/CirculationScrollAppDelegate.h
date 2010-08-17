//
//  CirculationScrollAppDelegate.h
//  CirculationScroll
//
//  Created by Hiroshi Hashiguchi on 10/08/17.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CirculationScrollViewController;

@interface CirculationScrollAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CirculationScrollViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CirculationScrollViewController *viewController;

@end

