//
//  NSTimerBlocksViewController.h
//  NSTimerBlocks
//
//  Created by Hiroshi Hashiguchi on 10/08/05.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSTimerBlocksViewController : UIViewController {

	NSInteger counter1;
	NSInteger counter2;
	NSInteger counter3;
	
	NSTimer* timer1;
	NSTimer* timer2;
	NSTimer* timer3;
	
	UILabel* counterLabel;
}
@property (nonatomic, retain) IBOutlet UILabel* counterLabel1;
@property (nonatomic, retain) IBOutlet UILabel* counterLabel2;
@property (nonatomic, retain) IBOutlet UILabel* counterLabel3;

-(IBAction)stopTimer:(id)sender;

@end

