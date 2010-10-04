//
//  ScrollViewZoomingViewController.h
//  ScrollViewZooming
//
//  Created by Hiroshi Hashiguchi on 10/10/04.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewZoomingViewController : UIViewController <UIScrollViewDelegate> {
	
	UIImageView* imageView;
	UIScrollView* scrollView;
	UILabel* contentOffsetLabel;
	UILabel* contentSizeLabel;
}
@property (nonatomic, retain) IBOutlet	UIImageView* imageView;
@property (nonatomic, retain) IBOutlet 	UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet 	UILabel* contentOffsetLabel;
@property (nonatomic, retain) IBOutlet 	UILabel* contentSizeLabel;
- (IBAction)x1:(id)sender;
- (IBAction)x2:(id)sender;
- (IBAction)x3:(id)sender;

@end

