//
//  DisplayingExcelFileAppDelegate.h
//  DisplayingExcelFile
//
//  Created by Hiroshi Hashiguchi on 10/12/31.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class DisplayingExcelFileViewController;

@interface DisplayingExcelFileAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DisplayingExcelFileViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DisplayingExcelFileViewController *viewController;

@end

