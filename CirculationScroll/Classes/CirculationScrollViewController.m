//
//  CirculationScrollViewController.m
//  CirculationScroll
//
//  Created by Hiroshi Hashiguchi on 10/08/17.
//  Copyright  2010. All rights reserved.
//

#import "CirculationScrollViewController.h"

#define IMAGE_WIDTH			80
#define IMAGE_HEIGHT		80
#define DISPLAY_VIEW_NUM	4
#define MAX_VIEW_NUM		(DISPLAY_VIEW_NUM+2)
#define MAX_SCROLLABLE_IMAGES		10000
#define SCROLL_INTERVAL		0.05
#define	AUTO_SCROLL_DELAY	2
#define IMAGE_MARGIN		3

@implementation CirculationScrollViewController

@synthesize scrollView = scrollView_;
@synthesize viewList = viewList_;
@synthesize imageList = imageList_;
@synthesize circulated = circulated_;
@synthesize timer = timer_;

#pragma mark -
#pragma mark Management auto ScrollDirection
- (void)stopAutoScroll
{
	autoScrollStopped_ = YES;
}

- (void)restartAutoScroll
{
	autoScrollStopped_ = NO;
}

- (void)restartAutoScrollAfterDelay
{
	[self performSelector:@selector(restartAutoScroll)
			   withObject:nil
			   afterDelay:AUTO_SCROLL_DELAY];
}


#pragma mark -
#pragma mark timer event handler
- (void)timerDidFire:(NSTimer*)timer
{
	if (autoScrollStopped_) {
		return;
	}
	
	CGPoint p = self.scrollView.contentOffset;
	p.x = p.x + 1;
	
	if (p.x < IMAGE_WIDTH * MAX_SCROLLABLE_IMAGES) {
		self.scrollView.contentOffset = p;
	}
}


#pragma mark -
#pragma mark event handler
- (void)touchedButton:(id)sender forEvent:(UIEvent *)event
{
	UITouch* touch = [event.allTouches anyObject];
	if (touch.phase == UITouchPhaseBegan) {
		[self stopAutoScroll];

	} else if (touch.phase == UITouchPhaseEnded) {
		// TODO: call delegate
		NSInteger viewIndex = [sender tag];
		NSInteger imageIndex = (leftImageIndex_ + (MAX_VIEW_NUM + viewIndex - leftViewIndex_) % MAX_VIEW_NUM - 1)% [imageList_ count];
		NSLog(@"imageIndex=%d", imageIndex);
	}
}


#pragma mark -
#pragma mark Initialization & deallocation
- (id)initWithCoder:(NSCoder*)coder
{
	self = [super initWithCoder:coder];
	if (self != nil) {
		// test
		circulated_ = YES;
		autoScrollStopped_ = NO;
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

	NSMutableArray* array = [NSMutableArray array];
	
	CGRect imageViewFrame = CGRectMake(-IMAGE_WIDTH, 0, IMAGE_WIDTH, IMAGE_HEIGHT);

	for (int i=0; i < MAX_VIEW_NUM; i++) {
		UIButton* view = [[[UIButton alloc]
							  initWithFrame:imageViewFrame] autorelease];
		[view setBackgroundImage:[UIImage imageNamed:@"background"]
						forState:UIControlStateNormal]; 
		view.imageEdgeInsets = UIEdgeInsetsMake(IMAGE_MARGIN, IMAGE_MARGIN, IMAGE_MARGIN, IMAGE_MARGIN);
		view.tag = i;
		[view addTarget:self
				 action:@selector(touchedButton:forEvent:)
	   forControlEvents:UIControlEventAllEvents];

		[array addObject:view];
		
		imageViewFrame.origin.x += IMAGE_WIDTH;

		[self.scrollView addSubview:view];
	}
	self.viewList = array;

	
	if (circulated_) {
		[self stopAutoScroll];

		if ([self.timer isValid]) {
			[self.timer invalidate];
		}
		self.timer = [NSTimer scheduledTimerWithTimeInterval:SCROLL_INTERVAL
													  target:self
													selector:@selector(timerDidFire:)
													userInfo:nil
													 repeats:YES];
		[self restartAutoScrollAfterDelay];
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.scrollView = nil;
	if ([self.timer isValid]) {
		[self.timer invalidate];
	}
	self.timer = nil;
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark image management
- (UIImage*)blankImage
{
	return [UIImage imageNamed:@"blank.jpg"];
}

- (UIImage*)imageAtIndex:(NSInteger)index
{
	NSInteger numberOfImages = [self.imageList count];
	UIImage* image = nil;

	if (self.circulated) {
		if (0 <= index && index <= MAX_SCROLLABLE_IMAGES-1) {
			index = (index + numberOfImages) % numberOfImages;
		}
	}

	if (0 <= index && index < numberOfImages) {
		image = [self.imageList objectAtIndex:index];
	} else {
		image = [self blankImage];
	}

	return image;
	
}


#pragma mark -
#pragma mark control scroll
- (void)updateScrollViewSetting
{
	CGSize contentSize = CGSizeMake(0, IMAGE_HEIGHT);
	NSInteger numberOfImages = [imageList_ count];

	if (self.circulated) {
		contentSize.width = IMAGE_WIDTH * MAX_SCROLLABLE_IMAGES;
		CGPoint contentOffset = CGPointZero;
		contentOffset.x = ((MAX_SCROLLABLE_IMAGES-numberOfImages)/2) * IMAGE_WIDTH;
		CGRect viewFrame = CGRectMake(
				contentOffset.x - IMAGE_WIDTH, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
		for (UIButton* view in self.viewList) {
			view.frame = viewFrame;
			viewFrame.origin.x += IMAGE_WIDTH;
		}
		
		leftImageIndex_ = contentOffset.x / IMAGE_HEIGHT;
		self.scrollView.contentOffset = contentOffset;

		UIButton* leftView = [self.viewList objectAtIndex:leftViewIndex_];
		[leftView setImage:[self imageAtIndex:DISPLAY_VIEW_NUM]
				  forState:UIControlStateNormal];

	} else {
		contentSize.width = IMAGE_WIDTH * numberOfImages;
	}

	self.scrollView.contentSize = contentSize;
	self.scrollView.showsHorizontalScrollIndicator = !self.circulated;
}

typedef enum {
	kScrollDirectionLeft,
	kScrollDirectionRight
} ScrollDirection;

- (NSInteger)addViewIndex:(NSInteger)index incremental:(NSInteger)incremental
{
	return (index + incremental + MAX_VIEW_NUM) % MAX_VIEW_NUM;
}

- (void)scrollWithDirection:(ScrollDirection)scrollDirection
{
	NSInteger incremental = 0;
	NSInteger viewIndex = 0;
	NSInteger imageIndex = 0;
	
	if (scrollDirection == kScrollDirectionLeft) {
		incremental = -1;
		viewIndex = rightViewIndex_;
	} else if (scrollDirection == kScrollDirectionRight) {
		incremental = 1;
		viewIndex = leftViewIndex_;
	}
	
	// change position
	UIButton* view = [self.viewList objectAtIndex:viewIndex];
	CGRect frame = view.frame;
	frame.origin.x += IMAGE_WIDTH * MAX_VIEW_NUM * incremental;
	view.frame = frame;
	
	// change image
	leftImageIndex_ = leftImageIndex_ + incremental;
	
	if (scrollDirection == kScrollDirectionLeft) {
		imageIndex = leftImageIndex_ -1;
	} else if (scrollDirection == kScrollDirectionRight) {
		imageIndex = leftImageIndex_ + DISPLAY_VIEW_NUM;
	}	
	[view setImage:[self imageAtIndex:imageIndex]
		  forState:UIControlStateNormal];
	
	
	// adjust indicies
	leftViewIndex_ = [self addViewIndex:leftViewIndex_ incremental:incremental];
	rightViewIndex_ = [self addViewIndex:rightViewIndex_ incremental:incremental];
}



#pragma mark -
#pragma mark Accsessors
- (void)setImageList:(NSArray*)list
{
	// store list
	[list retain];
	[imageList_ release];
	imageList_ = list;
	
	// initialize indices
	leftImageIndex_ = 0;
	leftViewIndex_ = 0;
	rightViewIndex_ = MAX_VIEW_NUM-1;
	
	// [1]setup blank
	for (int i=0; i < MAX_VIEW_NUM; i++) {
		UIButton* view = [self.viewList objectAtIndex:i];
		[view setImage:[self blankImage]
			  forState:UIControlStateNormal];
	}

	// [2]display area
	NSInteger index = 1;	// skip 0
	for (UIImage* image in imageList_) {
		UIButton* view = [self.viewList objectAtIndex:index];
		[view setImage:image
			  forState:UIControlStateNormal];
		index++;
		if (index > DISPLAY_VIEW_NUM) {
			break;
		}
	}
	
	// [3]outside
	UIButton* rightView = [self.viewList objectAtIndex:MAX_VIEW_NUM-1];
	[rightView setImage:[self imageAtIndex:DISPLAY_VIEW_NUM]
			   forState:UIControlStateNormal];


	// [4]setup scrollView
	[self updateScrollViewSetting];
}


#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat position = scrollView.contentOffset.x / IMAGE_WIDTH;
	CGFloat delta = position - (CGFloat)leftImageIndex_;
	NSInteger count = (NSInteger)fabs(delta);

	for (int i=0; i < count; i++) {
		if (delta > 0) {
			[self scrollWithDirection:kScrollDirectionRight];
		} else {
			[self scrollWithDirection:kScrollDirectionLeft];			
		}		
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	[self stopAutoScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	NSLog(@"scrollViewDidEndDecelerating");
	[self restartAutoScrollAfterDelay];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	NSLog(@"scrollViewDidEndDragging: %d", decelerate);
	if (!decelerate) {
		[self restartAutoScrollAfterDelay];
	}
}

@end
