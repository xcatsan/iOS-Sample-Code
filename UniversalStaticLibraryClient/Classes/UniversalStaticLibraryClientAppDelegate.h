//
//  UniversalStaticLibraryClientAppDelegate.h
//  UniversalStaticLibraryClient
//
//  Created by Hiroshi Hashiguchi on 10/11/09.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class UniversalStaticLibraryClientViewController;

@interface UniversalStaticLibraryClientAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UniversalStaticLibraryClientViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UniversalStaticLibraryClientViewController *viewController;

@end

