//
//  UUTypeSampleAppDelegate.h
//  UUTypeSample
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UUTypeSampleViewController;

@interface UUTypeSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UUTypeSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UUTypeSampleViewController *viewController;

@end

