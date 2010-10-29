//
//  CoreAnimation3DSampleAppDelegate.h
//  CoreAnimation3DSample
//
//  Created by Hiroshi Hashiguchi on 10/10/29.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoreAnimation3DSampleViewController;

@interface CoreAnimation3DSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CoreAnimation3DSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CoreAnimation3DSampleViewController *viewController;

@end

