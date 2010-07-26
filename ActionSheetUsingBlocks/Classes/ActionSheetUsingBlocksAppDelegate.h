//
//  ActionSheetUsingBlocksAppDelegate.h
//  ActionSheetUsingBlocks
//
//  Created by Hiroshi Hashiguchi on 10/07/26.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionSheetUsingBlocksViewController;

@interface ActionSheetUsingBlocksAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ActionSheetUsingBlocksViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ActionSheetUsingBlocksViewController *viewController;

@end

