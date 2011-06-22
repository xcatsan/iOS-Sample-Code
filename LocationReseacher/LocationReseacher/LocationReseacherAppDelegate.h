//
//  LocationReseacherAppDelegate.h
//  LocationReseacher
//
//  Created by Hiroshi Hashiguchi on 11/06/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationReseacherViewController;

@interface LocationReseacherAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet LocationReseacherViewController *viewController;

@end
