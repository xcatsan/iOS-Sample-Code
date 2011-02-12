//
//  KeyChainApp_1AppDelegate.h
//  KeyChainApp-1
//
//  Created by Hiroshi Hashiguchi on 11/02/05.
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyChainApp_1ViewController;

@interface KeyChainApp_1AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    KeyChainApp_1ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet KeyChainApp_1ViewController *viewController;

@end

