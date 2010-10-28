//
//  ImageScrollView.m
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/10/04.
//  Copyright 2010 . All rights reserved.
//

#import "XCGalleryInnerScrollView.h"


@implementation XCGalleryInnerScrollView

@synthesize imageView = imageView_;
@synthesize eventDelegate = eventDelegate_;

-(id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		
		// setup scrollview
//		[self setUserInteractionEnabled:YES];
		self.delegate = self;
		self.minimumZoomScale = 1.0;
		self.maximumZoomScale = 5.0;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		self.backgroundColor = [UIColor blackColor];
		self.clipsToBounds = YES;
		
		// setup imageview
		self.imageView =
			[[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
		self.imageView.autoresizingMask =
			UIViewAutoresizingFlexibleLeftMargin  |
			UIViewAutoresizingFlexibleWidth       |
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleTopMargin   |
			UIViewAutoresizingFlexibleHeight      |
			UIViewAutoresizingFlexibleBottomMargin;		
		self.imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:self.imageView];		
	}
	return self;
}


+ (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView
					  withScale:(float)scale withCenter:(CGPoint)center {
	
    CGRect zoomRect;
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
	zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
	
    return zoomRect;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.eventDelegate didTouched:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.eventDelegate didTouched:self];
	
	UITouch* touch = [touches anyObject];
	if ([touch tapCount] == 2) {
		[self.eventDelegate didDoubleTouched:self];

		/*
		CGRect zoomRect;
		if (self.zoomScale > 1.0) {
			zoomRect = self.bounds;
		} else {
			zoomRect = [XCGalleryInnerScrollView zoomRectForScrollView:self
													withScale:2.0
												   withCenter:[touch locationInView:self]];
		}
		[self zoomToRect:zoomRect animated:YES];
		*/
	}
}

- (void) dealloc
{
	self.imageView = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark UIScrollViewDelegate
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	UIView* zoomView = nil;
	
	if ([self.eventDelegate canZoom]) {
		zoomView = [self.subviews objectAtIndex:0];
	}
	return zoomView;
}


- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
	[self.eventDelegate didTouched:self];
}


@end
