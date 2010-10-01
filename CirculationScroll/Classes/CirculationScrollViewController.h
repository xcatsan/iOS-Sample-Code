//
//  CirculationScrollViewController.h
//  CirculationScroll
//
//  Created by Hiroshi Hashiguchi on 10/08/17.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CirculationScrollViewController : UIViewController <UIScrollViewDelegate> {

	UIScrollView* scrollView_;
	NSArray* viewList_;

	NSArray* imageList_;

	NSInteger leftImageIndex_;	// index of imageList

	NSInteger leftViewIndex_;	// index of viewList
	NSInteger rightViewIndex_;	// index of viewList
	
	BOOL circulated_;
	
	NSTimer* timer_;
	BOOL autoScrollStopped_;
}
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) NSArray* viewList;
@property (nonatomic, retain) NSArray* imageList;
@property (nonatomic, readonly, getter=isCirculated) BOOL circulated;
@property (nonatomic, retain) NSTimer* timer;
@end

