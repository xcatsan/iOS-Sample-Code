//
//  AVCaptreSampleAppDelegate.h
//  AVCaptreSample
//
//  Created by Hiroshi Hashiguchi on 11/04/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVCaptreSampleAppDelegate : NSObject <UIApplicationDelegate> {

}
@property (nonatomic, retain) IBOutlet UIView* previewView;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
