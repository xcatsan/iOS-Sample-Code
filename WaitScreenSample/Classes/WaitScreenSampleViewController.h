//
//  WaitScreenSampleViewController.h
//  WaitScreenSample
//
//  Created by Hiroshi Hashiguchi on 10/09/13.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitScreenSampleViewController : UIViewController {

	UILabel* label;
	UILabel* label2;
}
@property (nonatomic, retain) IBOutlet UILabel* label;
@property (nonatomic, retain) IBOutlet UILabel* label2;
- (IBAction)start:(id)sender;
@end

