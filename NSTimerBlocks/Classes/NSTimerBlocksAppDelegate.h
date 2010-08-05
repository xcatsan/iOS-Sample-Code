//
//  NSTimerBlocksAppDelegate.h
//  NSTimerBlocks
//
//  Created by Hiroshi Hashiguchi on 10/08/05.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSTimerBlocksViewController;

@interface NSTimerBlocksAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    NSTimerBlocksViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet NSTimerBlocksViewController *viewController;

@end

