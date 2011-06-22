//
//  GCDSuspendSampleAppDelegate.h
//  GCDSuspendSample
//
//  Created by Hiroshi Hashiguchi on 11/05/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCDSuspendSampleAppDelegate : NSObject <UIApplicationDelegate> {

    dispatch_queue_t    backgroundQueue_;
    int count_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UILabel* countLabel;

- (IBAction)addTask:(id)sedner;
- (IBAction)executeBlock:(id)sender;

@end
