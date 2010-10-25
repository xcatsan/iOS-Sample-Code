//
//  XCGalleryView.m
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/10/07.
//  Copyright 2010 . All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "XCGalleryView.h"

#define DEFAULT_SPACING_WIDTH	40
#define DEFAULT_SPACING_HEIGHT	0
#define DEFAULT_MARGIN_HEIGHT	20
#define DEFAULT_MARGIN_WIDTH_RATE	0.2
// DEBUG
#define DEFAULT_SLIDESHOW_DURATION 3.0/2
#define DEFAULT_TRANSITION_DURATION	0.75
//#define DEFAULT_SLIDESHOW_DURATION 3
//#define DEFAULT_TRANSITION_DURATION	0.75

#define kMaxOfScrollView			5
#define kLengthFromCetner			((kMaxOfScrollView-1)/2)
#define kIndexOfCurrentScrollView	((kMaxOfScrollView-1)/2)


// private properties
@interface XCGalleryView()

@property (nonatomic, assign) NSInteger currentImageIndex;

@property (nonatomic, retain) UIScrollView* scrollView;
@property (nonatomic, assign) NSInteger contentOffsetIndex;

@property (nonatomic, retain) NSMutableArray* innerScrollViews;

@property (nonatomic, assign) CGSize showcaseMargin;
@property (nonatomic, assign) CGSize viewSpacing;
@property (nonatomic, retain) UIPageControl* pageControl;
@property (nonatomic, retain) NSTimer* timer;

@property (nonatomic, retain) XCGalleryInnerScrollView* transitionInnerScrollView;
@end



@implementation XCGalleryView

@synthesize currentImageIndex = currentImageIndex_;
@synthesize scrollView = scrollView_;
@synthesize contentOffsetIndex = contentOffsetIndex_;
@synthesize innerScrollViews = innerScrollViews_;
@synthesize delegate = delegate_;
@synthesize showcaseModeEnabled = showcaseModeEnabled_;
@synthesize showcaseMargin = showcaseMargin_;
@synthesize viewSpacing = viewSpacing_;
@synthesize pageControlEnabled = pageControlEnabled_;
@synthesize pageControl = pageControl_;
@synthesize isRunningSlideShow = isRunningSlideShow_;
@synthesize slideShowDuration = slideShowDuration_;
@synthesize timer = timer_;
@synthesize transitionInnerScrollView = transitionInnerScrollView_;

#pragma mark -
#pragma mark Controle scroll views
- (void)resetZoomScrollView:(XCGalleryInnerScrollView*)innerScrollView
{
	innerScrollView.zoomScale = 1.0;
	innerScrollView.contentOffset = CGPointZero;
}

- (void)setImageAtIndex:(NSInteger)index toScrollView:(XCGalleryInnerScrollView*)innerScrollView
{
	if (index < 0 || [self.delegate numberImagesInGallery:self] <= index) {
		innerScrollView.imageView.image = nil;
		return;
	}
	
	innerScrollView.imageView.image =
		[self.delegate galleryImage:self filenameAtIndex:index];
	
	[self resetZoomScrollView:innerScrollView];
}


- (void)reloadData
{
	NSInteger numberOfViews = [self.delegate numberImagesInGallery:self];
	if (self.currentImageIndex >= numberOfViews) {
		if (numberOfViews == 0) {
			self.currentImageIndex = 0;
		} else {
			self.currentImageIndex = numberOfViews-1;
		}
		self.contentOffsetIndex = self.currentImageIndex;
	}
	
	for (int index=0; index < kMaxOfScrollView; index++) {
		[self setImageAtIndex:self.currentImageIndex+index-kLengthFromCetner
				 toScrollView:[self.innerScrollViews objectAtIndex:index]];
	}
	
	self.pageControl.numberOfPages = numberOfViews;
	self.pageControl.currentPage = self.currentImageIndex;
}


- (void)setupSpacingAndMarginAndClips
{
	if (self.showcaseModeEnabled) {
		spacing_ = self.viewSpacing;
		spacing_.width = spacing_.width / 2.0;
		margin_ = self.showcaseMargin;
		self.scrollView.clipsToBounds = NO;
	} else {
		spacing_ = self.viewSpacing;
		margin_ = CGSizeZero;
		self.scrollView.clipsToBounds = YES;
	}
}

- (void)setupSubViews
{	
	NSLog(@"setupSubviews");

	// initialize vars
	self.viewSpacing = CGSizeMake(
								  DEFAULT_SPACING_WIDTH, DEFAULT_SPACING_HEIGHT);
	self.showcaseMargin = CGSizeMake(
									 (int)(self.bounds.size.width * DEFAULT_MARGIN_WIDTH_RATE),
									 DEFAULT_MARGIN_HEIGHT);
	[self setupSpacingAndMarginAndClips];
	
	// setup self view
	//-------------------------
	self.autoresizingMask =
		UIViewAutoresizingFlexibleLeftMargin  |
		UIViewAutoresizingFlexibleWidth       |
		UIViewAutoresizingFlexibleRightMargin |
		UIViewAutoresizingFlexibleTopMargin   |
		UIViewAutoresizingFlexibleHeight      |
		UIViewAutoresizingFlexibleBottomMargin;
	self.clipsToBounds = YES;
	self.backgroundColor = [UIColor blackColor];	// default
	
	
	// setup base scroll view
	//-------------------------
	CGRect baseFrame = self.bounds;
	baseFrame = CGRectInset(baseFrame, margin_.width, margin_.height);
	
	self.scrollView = [[[UIScrollView alloc] initWithFrame:baseFrame] autorelease];
	
	self.scrollView.delegate = self;
	self.scrollView.pagingEnabled = YES;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
	self.scrollView.scrollsToTop = NO;
	CGRect scrollViewFrame = self.scrollView.frame;
	scrollViewFrame.origin.x -= spacing_.width/2.0;
	scrollViewFrame.size.width += spacing_.width;
	self.scrollView.frame =scrollViewFrame;
	self.scrollView.autoresizingMask =
		UIViewAutoresizingFlexibleWidth |
		UIViewAutoresizingFlexibleHeight;
	
	[self addSubview:self.scrollView];
	
	// setup internal scroll views
	//------------------------------
	CGRect innerScrollViewFrame = CGRectZero;
	innerScrollViewFrame.size = baseFrame.size;
	innerScrollViewFrame.origin.x = -kLengthFromCetner * innerScrollViewFrame.size.width;
	if (self.showcaseModeEnabled) {
		innerScrollViewFrame.origin.x -= spacing_.width;
	}

	self.innerScrollViews = [NSMutableArray array];
		
	for (int i=0; i < kMaxOfScrollView; i++) {
		
		// image view
		//--------------

		// scroll view
		//--------------
		innerScrollViewFrame.origin.x += spacing_.width/2.0;	// left space
		
		XCGalleryInnerScrollView* innerScrollView =
			[[XCGalleryInnerScrollView alloc] initWithFrame:innerScrollViewFrame];
		innerScrollView.clipsToBounds = YES;
		innerScrollView.backgroundColor = self.backgroundColor;
		innerScrollView.eventDelegate = self;
		
		// bind & store views
		[self.scrollView addSubview:innerScrollView];
		[self.innerScrollViews addObject:innerScrollView];
		
		// release all
		[innerScrollView release];
		
		// adust origin.x
		innerScrollViewFrame.origin.x += innerScrollViewFrame.size.width;
		innerScrollViewFrame.origin.x += spacing_.width/2.0;	// right space
		
	}
	
	// setup temporary view for slideshow transition
	self.transitionInnerScrollView =
		[[[XCGalleryInnerScrollView alloc]
		  initWithFrame:innerScrollViewFrame] autorelease];
	self.transitionInnerScrollView.hidden = YES;
	[self.scrollView addSubview:self.transitionInnerScrollView];

	// setup page control
	CGRect pageControlFrame = CGRectMake(0, self.bounds.size.height-DEFAULT_MARGIN_HEIGHT, self.bounds.size.width, DEFAULT_MARGIN_HEIGHT);
	self.pageControl = [[[UIPageControl alloc] initWithFrame:pageControlFrame] autorelease];
	self.pageControl.autoresizingMask =
		UIViewAutoresizingFlexibleLeftMargin  |
		UIViewAutoresizingFlexibleWidth       |
		UIViewAutoresizingFlexibleRightMargin |
		UIViewAutoresizingFlexibleTopMargin   |
		UIViewAutoresizingFlexibleHeight      |
		UIViewAutoresizingFlexibleBottomMargin;
	self.pageControl.hidesForSinglePage = NO;
	[self.pageControl addTarget:self
						 action:@selector(pageControlDidChange:)
			   forControlEvents:UIControlEventValueChanged];
	self.pageControl.hidden = !pageControlEnabled_;
	[self addSubview:self.pageControl];
}	

- (void)layoutSubviews
{
	NSLog(@"layoutSubviews");
	if (!didSetup_) {
		// initialization for only first time
		[self setupSubViews];
		[self reloadData];
		didSetup_ = YES;
	}

	CGSize newSize;
	if (self.showcaseModeEnabled) {
		newSize = self.scrollView.bounds.size;
		newSize.width -= spacing_.width;
	} else {
		newSize = self.bounds.size;
	}
	CGSize oldSize = previousScrollSize_;

	if (CGSizeEqualToSize(newSize, oldSize)) {
		return;
	}

	[self setupSpacingAndMarginAndClips];

	previousScrollSize_ = newSize;
	CGSize newSizeWithSpace = newSize;
	newSizeWithSpace.width += spacing_.width;
	
	// save previous contentSize
	//--
	XCGalleryInnerScrollView* currentScrollView =
		[self.innerScrollViews objectAtIndex:kIndexOfCurrentScrollView];
	CGSize oldContentSize = currentScrollView.contentSize;
	CGPoint oldContentOffset = currentScrollView.contentOffset;
	
	CGFloat zoomScale = currentScrollView.zoomScale;
	
	// calculate ratio (center / size)
	CGPoint oldCenter;
	oldCenter.x = oldContentOffset.x + oldSize.width/2.0;
	oldCenter.y = oldContentOffset.y + oldSize.height/2.0;
	
	CGFloat ratioW = oldCenter.x / oldContentSize.width;
	CGFloat ratioH = oldCenter.y / oldContentSize.height;
	
	
	// set new origin and size to innerScrollViews
	//--
	CGFloat x = (self.contentOffsetIndex-kLengthFromCetner) * newSizeWithSpace.width;
	for (XCGalleryInnerScrollView* scrollView in self.innerScrollViews) {

		x += spacing_.width/2.0;	// left space
		
		scrollView.frame = CGRectMake(x, 0, newSize.width, newSize.height);
		CGSize contentSize;
		if (scrollView == currentScrollView) {
			contentSize.width  = newSize.width  * scrollView.zoomScale;
			contentSize.height = newSize.height * scrollView.zoomScale;
		} else {
			contentSize = newSize;
		}
		scrollView.contentSize = contentSize;
		x += newSize.width;
		x += spacing_.width/2.0;	// right space
	}
	
	
	// adjust current scroll view for zooming
	//--
	if (zoomScale > 1.0) {
		CGSize newContentSize = currentScrollView.contentSize;
		
		CGPoint newCenter;
		newCenter.x = ratioW * newContentSize.width;
		newCenter.y = ratioH * newContentSize.height;
		
		CGPoint newContentOffset;
		newContentOffset.x = newCenter.x - newSize.width /2.0;
		newContentOffset.y = newCenter.y - newSize.height/2.0;
		currentScrollView.contentOffset = newContentOffset;

		/* DEBUG
		NSLog(@"oldContentSize  : %@", NSStringFromCGSize(oldContentSize));
		NSLog(@"oldContentOffset: %@", NSStringFromCGPoint(oldContentOffset));
		NSLog(@"ratio           : %f, %f", ratioW, ratioH);
		NSLog(@"oldCenter       : %@", NSStringFromCGPoint(oldCenter));
		NSLog(@"newCenter       : %@", NSStringFromCGPoint(newCenter));
		NSLog(@"newContentOffset: %@", NSStringFromCGPoint(newContentOffset));
		NSLog(@"-----");
		 */
	}
	
	// adjust content size and offset of base scrollView
	//--
	self.scrollView.contentSize = CGSizeMake(
		[self.delegate numberImagesInGallery:self]*newSizeWithSpace.width,
		newSize.height);
	self.scrollView.contentOffset = CGPointMake(
		self.contentOffsetIndex*newSizeWithSpace.width, 0);

	/* DEBUG
	 NSLog(@"oldSize         : %@", NSStringFromCGSize(oldSize));
	 NSLog(@"newSize         : %@", NSStringFromCGSize(newSize));
	 NSLog(@"scrollView.frame: %@", NSStringFromCGRect(self.scrollView.frame));
	 NSLog(@"newSizeWithSpace:%@", NSStringFromCGSize(newSizeWithSpace));
	 NSLog(@"scrollView.contentOffset: %@", NSStringFromCGPoint(self.scrollView.contentOffset))	 */
;
}


#pragma mark -
#pragma mark Accessors
- (void)setDelegate:(id <XCGalleryViewDelegate>)delegate
{
	delegate_ = delegate;
	[self reloadData];
}

- (void)setPageControlEnabled:(BOOL)enabled
{
	pageControlEnabled_ = enabled;
	self.pageControl.hidden = !enabled;
}


#pragma mark -
#pragma mark change mode

- (void)setShowcaseModeEnabled:(BOOL)enabled animated:(BOOL)animated
{
	showcaseModeEnabled_ = enabled;
	
//	NSLog(@"%d", self.showcaseModeEnabled);

//	[self layoutSubviews];
	
}


- (void)setShowcaseModeEnabled:(BOOL)enabled
{
	[self setShowcaseModeEnabled:enabled animated:YES];
}


#pragma mark -
#pragma mark Initialization and deallocation
- (void)setup
{
	pageControlEnabled_ = NO;
	showcaseModeEnabled_ = NO;
	
	isRunningSlideShow_ = NO;
	slideShowDuration_ = DEFAULT_SLIDESHOW_DURATION;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
		[self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self setup];
    }
    return self;
}


- (void)dealloc {
	self.scrollView = nil;
	self.innerScrollViews = nil;
	self.pageControl = nil;
	self.timer = nil;
	self.transitionInnerScrollView = nil;
	
    [super dealloc];
}


#pragma mark -
#pragma mark Control Scroll

-(void)setupPreviousImage
{
	XCGalleryInnerScrollView* rightView =
		[self.innerScrollViews objectAtIndex:kMaxOfScrollView-1];
	XCGalleryInnerScrollView* leftView = [self.innerScrollViews objectAtIndex:0];

	CGRect frame = leftView.frame;
	frame.origin.x -= frame.size.width + spacing_.width;
	rightView.frame = frame;

	[self.innerScrollViews removeObjectAtIndex:kMaxOfScrollView-1];
	[self.innerScrollViews insertObject:rightView atIndex:0];
	[self setImageAtIndex:self.currentImageIndex-kLengthFromCetner toScrollView:rightView];

}

-(void)setupNextImage
{
	XCGalleryInnerScrollView* rightView =
		[self.innerScrollViews objectAtIndex:kMaxOfScrollView-1];
	XCGalleryInnerScrollView* leftView = [self.innerScrollViews objectAtIndex:0];
	
	CGRect frame = rightView.frame;
	frame.origin.x += frame.size.width + spacing_.width;
	leftView.frame = frame;
	
	[self.innerScrollViews removeObjectAtIndex:0];
	[self.innerScrollViews addObject:leftView];
	[self setImageAtIndex:self.currentImageIndex+kLengthFromCetner toScrollView:leftView];

}


#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat position = scrollView.contentOffset.x / scrollView.bounds.size.width;
	CGFloat delta = position - (CGFloat)self.currentImageIndex;
	
	if (fabs(delta) >= 1.0f) {
		XCGalleryInnerScrollView* currentScrollView =
			[self.innerScrollViews objectAtIndex:kIndexOfCurrentScrollView];
		[self resetZoomScrollView:currentScrollView];
		
		//		NSLog(@"%f (%d=>%d)", delta, self.currentImageIndex, index);
		
		if (delta > 0) {
			// the current page moved to right
			self.currentImageIndex = self.currentImageIndex+1;
			self.contentOffsetIndex = self.contentOffsetIndex+1;
			self.pageControl.currentPage = self.currentImageIndex;
			[self setupNextImage];
			
		} else {
			// the current page moved to left
			self.currentImageIndex = self.currentImageIndex-1;
			self.contentOffsetIndex = self.contentOffsetIndex-1;
			self.pageControl.currentPage = self.currentImageIndex;
			[self setupPreviousImage];
		}
		
	}
	
}


#pragma mark -
#pragma mark Event
-(void)pageControlDidChange:(id)sender
{
	BOOL previous;
	if (self.pageControl.currentPage < self.currentImageIndex) {
		previous = YES;
	} else {
		previous = NO;
	}

	self.currentImageIndex = self.pageControl.currentPage;
	self.contentOffsetIndex = self.pageControl.currentPage;

	XCGalleryInnerScrollView* currentScrollView = 
	[self.innerScrollViews objectAtIndex:kIndexOfCurrentScrollView];
	[self resetZoomScrollView:currentScrollView];	
	
	CGSize size;
	if (self.showcaseModeEnabled) {
		size = self.scrollView.bounds.size;
		size.width -= spacing_.width;
	} else {
		size = self.bounds.size;
	}
	size.width += spacing_.width;

	[UIView beginAnimations:nil context:nil];
	self.scrollView.contentOffset = CGPointMake(
			self.contentOffsetIndex*size.width, 0);
	[UIView commitAnimations];
	
	if (previous) {
		[self setupPreviousImage];
	} else {
		[self setupNextImage];
	}
}


#pragma mark -
#pragma mark Slide Show 
- (void)stopSlideShow
{
	if (self.isRunningSlideShow && self.timer && [self.timer isValid]) {
		[self.timer invalidate];
		self.isRunningSlideShow = NO;	
		[self.delegate galleryDidStopSlideShow:self];
	} else {
		// nothing
	}

}

- (void)nextSlideShow:(NSTimer*)timer
{
	NSInteger numberOfViews = [self.delegate numberImagesInGallery:self];

	if (numberOfViews <= (self.currentImageIndex+1)) {
		[self stopSlideShow];
		return;
		// abort
	}

	// [1] setup transitionView
	[self setImageAtIndex:self.currentImageIndex
			 toScrollView:self.transitionInnerScrollView];
	self.currentImageIndex = self.currentImageIndex + 1;
	
	self.contentOffsetIndex = self.contentOffsetIndex + 1;
	XCGalleryInnerScrollView* nextInnerScrollView =
		[self.innerScrollViews objectAtIndex:kIndexOfCurrentScrollView];
	
	self.transitionInnerScrollView.frame = nextInnerScrollView.frame;
	
	[self.innerScrollViews replaceObjectAtIndex:kIndexOfCurrentScrollView
									 withObject:self.transitionInnerScrollView];

	nextInnerScrollView.hidden = YES;
	self.transitionInnerScrollView.hidden = NO;

	self.scrollView.contentOffset = CGPointMake(self.contentOffsetIndex*self.scrollView.bounds.size.width, 0);

	
	// [2] do transition
	CATransition* transition = [CATransition animation];
	transition.duration = DEFAULT_TRANSITION_DURATION;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	transition.delegate = self;
	
	[self.scrollView.layer addAnimation:transition forKey:nil];

	nextInnerScrollView.hidden = YES;
	self.transitionInnerScrollView.hidden = NO;
	
	[self.innerScrollViews replaceObjectAtIndex:kIndexOfCurrentScrollView
									 withObject:self.transitionInnerScrollView];
	self.transitionInnerScrollView = nextInnerScrollView;

	// [3] setup next
	[self setupNextImage];
}

- (void)startSlideShow
{
	if (self.isRunningSlideShow) {
		return;
	}
	
	self.timer = [NSTimer scheduledTimerWithTimeInterval:self.slideShowDuration
												  target:self
												selector:@selector(nextSlideShow:)
												userInfo:nil
												 repeats:YES];
	self.isRunningSlideShow = YES;
}


#pragma mark -
#pragma mark Delegate methods for CAAnimation
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	NSLog(@"animationDidStop:finished:");
}


#pragma mark -
#pragma mark Event
/*
 - (void)touchesBegin:(NSSet *)touches withEvent:(UIEvent *)event
 {
 NSLog(@"begin");
 }
 */

- (void)innerScrollView:(XCGalleryInnerScrollView*)innerScrollView
		   touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self stopSlideShow];
}





@end
