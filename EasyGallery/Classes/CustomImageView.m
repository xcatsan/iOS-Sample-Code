//
//  CustomImageView.m
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/09/29.
//  Copyright 2010 . All rights reserved.
//

#import "CustomImageView.h"


@implementation CustomImageView

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self;
}

-(id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		[self setUserInteractionEnabled:YES];
	}
	return self;
}


- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView
					  withScale:(float)scale withCenter:(CGPoint)center {
	
    CGRect zoomRect;
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
	zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
	
    return zoomRect;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	if ([touch tapCount] == 2) {
		UIScrollView* scrollView = (UIScrollView*)self.superview;

		CGRect zoomRect;
		if (scrollView.zoomScale > 1.0) {
			zoomRect = scrollView.bounds;
		} else {
			zoomRect = [self zoomRectForScrollView:scrollView
										 withScale:2.0
										withCenter:[touch locationInView:nil]];
		}
		[scrollView zoomToRect:zoomRect animated:YES];
	}
}
@end
