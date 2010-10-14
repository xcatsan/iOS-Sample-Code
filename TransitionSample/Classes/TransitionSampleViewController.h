//
//  TransitionSampleViewController.h
//  TransitionSample
//
//  Created by Hiroshi Hashiguchi on 10/10/14.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionSampleViewController : UIViewController {

	UIImageView* imageView;

	NSMutableArray* images;
	
	NSInteger imageIndex;
	
	UISlider* slider;
	
	UILabel* duration;
}
@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet NSMutableArray* images;
@property (nonatomic, retain) IBOutlet UISlider* slider;
@property (nonatomic, retain) IBOutlet UILabel* duration;

-(IBAction)none:(id)sender;
-(IBAction)flipFromLeft:(id)sender;
-(IBAction)flipFromRight:(id)sender;
-(IBAction)curlUp:(id)sender;
-(IBAction)curlDown:(id)sender;
-(IBAction)didChangeDuration:(id)sender;
@end

