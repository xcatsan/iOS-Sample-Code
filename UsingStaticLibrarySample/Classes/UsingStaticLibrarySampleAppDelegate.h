//
//  UsingStaticLibrarySampleAppDelegate.h
//  UsingStaticLibrarySample
//
//  Created by Hiroshi Hashiguchi on 10/11/02.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class UsingStaticLibrarySampleViewController;

@interface UsingStaticLibrarySampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UsingStaticLibrarySampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UsingStaticLibrarySampleViewController *viewController;

@end

