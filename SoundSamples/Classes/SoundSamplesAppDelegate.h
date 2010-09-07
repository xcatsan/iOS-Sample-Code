//
//  SoundSamplesAppDelegate.h
//  SoundSamples
//
//  Created by Hiroshi Hashiguchi on 10/09/07.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SoundSamplesViewController;

@interface SoundSamplesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SoundSamplesViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SoundSamplesViewController *viewController;

@end

