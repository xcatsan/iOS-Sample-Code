//
//  UIViewController_Extension.m
//  HairConcierge
//
//  Created by Hiroshi Hashiguchi on 10/07/10.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "UIViewController_Extension.h"

@implementation UIViewController (CustomDialog)

#pragma mark -
#pragma mark Manage dialog
- (BOOL)isExistSubView:(UIView*)view
{
	BOOL is_exist = NO;
	for (UIView* subview in self.view.subviews) {
		if (view == subview) {
			is_exist = YES;
			break;
		}
	}
	return is_exist;
}

- (void)presentDialogViewController:(UIViewController*)controller animated:(BOOL)animated
{
	CGRect frame1 = self.view.frame;
	CGRect frame2 = controller.view.frame;
	
	// (1) init position
	frame2.origin.y = frame1.size.height;
	controller.view.frame = frame2;

	if ([self isExistSubView:controller.view]) {
		[self.view bringSubviewToFront:controller.view];
	} else {
		[self.view addSubview:controller.view];
	}

	// (2) animate
	frame2.origin.y = frame1.size.height - frame2.size.height;
	if (animated) {
		[UIView animateWithDuration:0.5
						 animations:^{controller.view.frame = frame2;}];
	} else {
		controller.view.frame = frame2;
	}
	
}

- (void)dismissDialogViewController:(UIViewController*)controller animated:(BOOL)animated
{
	if (![self isExistSubView:controller.view]) {
		return;
		// do nothing
	}
	
	CGRect frame1 = self.view.frame;
	CGRect frame2 = controller.view.frame;
	
	// (1) animate
	frame2.origin.y = frame1.size.height;
	if (animated) {
		[UIView animateWithDuration:0.5
						 animations:^{controller.view.frame = frame2;}
						 completion:^(BOOL finished){[controller.view removeFromSuperview];}
		 ];
	} else {
		[controller.view removeFromSuperview];
	}
}

@end
