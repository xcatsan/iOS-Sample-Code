//
//  ObjcNewSampleAppDelegate.h
//  ObjcNewSample
//
//  Created by Hiroshi Hashiguchi on 10/12/08.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class ObjcNewSampleViewController;

@interface ObjcNewSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ObjcNewSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ObjcNewSampleViewController *viewController;

@end

