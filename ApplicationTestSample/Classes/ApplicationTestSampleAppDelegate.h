//
//  ApplicationTestSampleAppDelegate.h
//  ApplicationTestSample
//
//  Created by Hiroshi Hashiguchi on 10/11/23.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class ApplicationTestSampleViewController;

@interface ApplicationTestSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ApplicationTestSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ApplicationTestSampleViewController *viewController;

@end

