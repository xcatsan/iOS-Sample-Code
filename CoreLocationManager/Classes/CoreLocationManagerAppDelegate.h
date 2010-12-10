//
//  CoreLocationManagerAppDelegate.h
//  CoreLocationManager
//
//  Created by Hiroshi Hashiguchi on 10/11/20.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoreLocationManagerViewController;

@interface CoreLocationManagerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CoreLocationManagerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CoreLocationManagerViewController *viewController;

@end

