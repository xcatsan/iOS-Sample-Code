//
//  ImageViewTapAppDelegate.h
//  ImageViewTap
//
//  Created by Hiroshi Hashiguchi on 11/06/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageViewTapViewController;

@interface ImageViewTapAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ImageViewTapViewController *viewController;

@end
