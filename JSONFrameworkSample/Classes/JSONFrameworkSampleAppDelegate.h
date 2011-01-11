//
//  JSONFrameworkSampleAppDelegate.h
//  JSONFrameworkSample
//
//  Created by Hiroshi Hashiguchi on 11/01/11.
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSONFrameworkSampleViewController;

@interface JSONFrameworkSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    JSONFrameworkSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet JSONFrameworkSampleViewController *viewController;

@end

