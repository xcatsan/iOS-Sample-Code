//
//  EasyGalleryAppDelegate.h
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/09/28.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class EasyGalleryViewController;

@interface EasyGalleryAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EasyGalleryViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EasyGalleryViewController *viewController;

@end

