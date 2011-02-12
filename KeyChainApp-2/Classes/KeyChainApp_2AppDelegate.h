//
//  KeyChainApp_2AppDelegate.h
//  KeyChainApp-2
//
//  Created by Hiroshi Hashiguchi on 11/02/05.
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyChainApp_2ViewController;

@interface KeyChainApp_2AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    KeyChainApp_2ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet KeyChainApp_2ViewController *viewController;

@end

