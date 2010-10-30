//
//  CoreAnimation3DSample2AppDelegate.h
//  CoreAnimation3DSample2
//
//  Created by Hiroshi Hashiguchi on 10/10/30.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoreAnimation3DSample2ViewController;

@interface CoreAnimation3DSample2AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CoreAnimation3DSample2ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CoreAnimation3DSample2ViewController *viewController;

@end

