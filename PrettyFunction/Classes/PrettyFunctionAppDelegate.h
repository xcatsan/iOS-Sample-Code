//
//  PrettyFunctionAppDelegate.h
//  PrettyFunction
//
//  Created by Hiroshi Hashiguchi on 10/10/22.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface PrettyFunctionAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ViewController *viewController;

@end

