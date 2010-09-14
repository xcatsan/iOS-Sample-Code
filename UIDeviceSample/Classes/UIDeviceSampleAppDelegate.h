//
//  UIDeviceSampleAppDelegate.h
//  UIDeviceSample
//
//  Created by Hiroshi Hashiguchi on 10/09/12.
//  Copyright Hiroshi Hashiguchi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDeviceSampleAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

