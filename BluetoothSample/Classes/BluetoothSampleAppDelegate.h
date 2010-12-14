//
//  BluetoothSampleAppDelegate.h
//  BluetoothSample
//
//  Created by Hiroshi Hashiguchi on 10/12/14.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class BluetoothSampleViewController;

@interface BluetoothSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    BluetoothSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BluetoothSampleViewController *viewController;

@end

