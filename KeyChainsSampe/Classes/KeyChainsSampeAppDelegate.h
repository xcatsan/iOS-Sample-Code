//
//  KeyChainsSampeAppDelegate.h
//  KeyChainsSampe
//
//  Created by Hiroshi Hashiguchi on 11/02/02.
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyChainsSampeViewController;

@interface KeyChainsSampeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    KeyChainsSampeViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet KeyChainsSampeViewController *viewController;

@end

