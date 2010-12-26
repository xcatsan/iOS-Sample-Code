//
//  ProgressBarOnAlertViewViewController.h
//  ProgressBarOnAlertView
//
//  Created by Hiroshi Hashiguchi on 10/12/21.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressBarOnAlertViewViewController : UIViewController <UIAlertViewDelegate>{

	NSTimer* timer_;
}

- (IBAction)start:(id)sender;

@end

