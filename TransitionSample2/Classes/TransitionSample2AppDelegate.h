//
//  TransitionSample2AppDelegate.h
//  TransitionSample2
//
//  Created by Hiroshi Hashiguchi on 10/10/14.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransitionSample2ViewController;

@interface TransitionSample2AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TransitionSample2ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TransitionSample2ViewController *viewController;

@end

