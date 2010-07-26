//
//  TableHeaderAppDelegate.h
//  TableHeader
//
//  Created by Hiroshi Hashiguchi on 10/07/26.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableHeaderViewController;

@interface TableHeaderAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TableHeaderViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TableHeaderViewController *viewController;

@end

