//
//  ResponderChainStudyAppDelegate.h
//  ResponderChainStudy
//
//  Created by Hiroshi Hashiguchi on 11/06/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ResponderChainStudyViewController;

@interface ResponderChainStudyAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ResponderChainStudyViewController *viewController;

@end
