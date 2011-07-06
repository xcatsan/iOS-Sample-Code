//
//  RotateImageSampleAppDelegate.h
//  RotateImageSample
//
//  Created by Hiroshi Hashiguchi on 11/07/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RotateImageSampleViewController;

@interface RotateImageSampleAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet RotateImageSampleViewController *viewController;

@end
