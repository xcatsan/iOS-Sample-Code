//
//  IBOutletCollectionSampleAppDelegate.h
//  IBOutletCollectionSample
//
//  Created by Hiroshi Hashiguchi on 10/12/05.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class IBOutletCollectionSampleViewController;

@interface IBOutletCollectionSampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IBOutletCollectionSampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet IBOutletCollectionSampleViewController *viewController;

@end

