//
//  TransitionSample2ViewController.h
//  TransitionSample2
//
//  Created by Hiroshi Hashiguchi on 10/10/14.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionSample2ViewController : UIViewController {

	UIImageView* imageView1;
	UIImageView* imageView2;
	UISlider* slider;
	UILabel* duration;

	NSMutableArray* images;
	NSInteger imageIndex;

}
@property (nonatomic, retain) IBOutlet UIImageView* imageView1;
@property (nonatomic, retain) IBOutlet UIImageView* imageView2;
@property (nonatomic, retain) IBOutlet 	UISlider* slider;
@property (nonatomic, retain) NSMutableArray* images;
@property (nonatomic, retain) IBOutlet 	UILabel* duration;
-(IBAction)didChangeDuration:(id)sender;
-(IBAction)doTransition:(id)sender;

@end

