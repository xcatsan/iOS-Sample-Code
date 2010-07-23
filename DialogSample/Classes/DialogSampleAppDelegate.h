//
//  DialogSampleAppDelegate.h
//  DialogSample
//
//  Created by Hiroshi Hashiguchi on 10/07/23.
//  Copyright Hiroshi Hashiguchi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DialogSampleViewController;

@interface DialogSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DialogSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DialogSampleViewController *viewController;

@end

