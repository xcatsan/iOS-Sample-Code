//
//  XCGalleryView.m
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/10/07.
//  Copyright 2010 . All rights reserved.
//

#import "XCGalleryView.h"
#import "XCGalleryInerScrollView.h"

#define DEFAULT_SPACE_WIDTH	40

enum {
	kIndexOfPreviousScrollView = 0,
	kIndexOfCurrentScrollView,
	kIndexOfNextScrollView,
	kMaxOfScrollView
};

@implementation XCGalleryView

@synthesize currentImageIndex = currentImageIndex_;
@synthesize scrollView = scrollView_;
@synthesize contentOffsetIndex = contentOffsetIndex_;
@synthesize imageScrollViews = imageScrollViews_;
@synthesize delegate = delegate_;
@synthesize spaceWidth = spaceWidth_;

#pragma mark -
#pragma mark Controle scroll views
- (void)setImageAtIndex:(NSInteger)index toScrollView:(UIScrollView*)scrollView
{
	UIImageView* imageView = [scrollView.subviews objectAtIndex:0];
	if (index < 0 || [self.delegate numberViewsInGallery:self] <= index) {
		imageView.image = nil;
		scrollView.delegate = nil;
		return;
	}
	
	UIImage* image = [self.delegate galleryImage:self filenameAtIndex:index];
	imageView.image = image;
	imageView.contentMode = (image.size.width > image.size.height) ?
	UIViewContentModeScaleAspectFit : UIViewContentModeScaleAspectFill;
}

- (void)layoutSubviews
{
	CGSize newSize = self.bounds.size;
	CGSize oldSize = previousScrollSize_;

	if (CGSizeEqualToSize(newSize, oldSize)) {
		return;
	}

	previousScrollSize_ = newSize;
	CGSize newSizeWithSpace = newSize;
	newSizeWithSpace.width += spaceWidth_;
	
	// save previous contentSize
	//--
	XCGalleryInerScrollView* currentScrollView =
	[self.imageScrollViews objectAtIndex:kIndexOfCurrentScrollView];
	CGSize oldContentSize = currentScrollView.contentSize;
	CGPoint oldContentOffset = currentScrollView.contentOffset;
	
	CGFloat zoomScale = currentScrollView.zoomScale;
	
	// calculate ratio (center / size)
	CGPoint oldCenter;
	oldCenter.x = oldContentOffset.x + oldSize.width/2.0;
	oldCenter.y = oldContentOffset.y + oldSize.height/2.0;
	
	CGFloat ratioW = oldCenter.x / oldContentSize.width;
	CGFloat ratioH = oldCenter.y / oldContentSize.height;
	
	
	// set new origin and size to imageScrollViews
	//--
	CGFloat x = (self.contentOffsetIndex-1) * newSizeWithSpace.width;
	for (XCGalleryInerScrollView* scrollView in self.imageScrollViews) {
		
		x += spaceWidth_/2.0;	// left space
		
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
		x += spaceWidth_/2.0;	// right space
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

		/*
		NSLog(@"oldContentSize  : %@", NSStringFromCGSize(oldContentSize));
		NSLog(@"oldContentOffset: %@", NSStringFromCGPoint(oldContentOffset));
		NSLog(@"ratio           : %f, %f", ratioW, ratioH);
		NSLog(@"oldCenter       : %@", NSStringFromCGPoint(oldCenter));
		NSLog(@"newCenter       : %@", NSStringFromCGPoint(newCenter));
		NSLog(@"newContentOffset: %@", NSStringFromCGPoint(newContentOffset));
		NSLog(@"-----");
		 */
	}
	/*
	NSLog(@"oldSize         : %@", NSStringFromCGSize(oldSize));
	NSLog(@"newSize         : %@", NSStringFromCGSize(newSize));
	NSLog(@"scrollView.frame: %@", NSStringFromCGRect(self.scrollView.frame));
	 */
	
	// adjust content size and offset of base scrollView
	//--
	self.scrollView.contentSize = CGSizeMake(
		[self.delegate numberViewsInGallery:self]*newSizeWithSpace.width,
		newSize.height);
	self.scrollView.contentOffset = CGPointMake(
		self.contentOffsetIndex*newSizeWithSpace.width, 0);
}


- (void)setupSubViews
{
	spaceWidth_ = DEFAULT_SPACE_WIDTH;

	// setup base scroll view
	//-------------------------
	self.scrollView = [[[UIScrollView alloc] initWithFrame:self.frame] autorelease];
	self.scrollView.delegate = self;
	self.scrollView.pagingEnabled = YES;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
	self.scrollView.scrollsToTop = NO;
	CGRect scrollViewFrame = self.scrollView.frame;
	scrollViewFrame.origin.x -= spaceWidth_/2.0;
	scrollViewFrame.size.width += spaceWidth_;
	self.scrollView.frame = scrollViewFrame;
	//	self.scrollView.clipsToBounds = NO;
	self.scrollView.autoresizingMask =
		UIViewAutoresizingFlexibleWidth |
		UIViewAutoresizingFlexibleHeight;
	
	[self addSubview:self.scrollView];

	// setup internal scroll views
	//------------------------------
	CGRect imageScrollViewFrame = CGRectZero;
	imageScrollViewFrame.size = self.scrollView.bounds.size;
	imageScrollViewFrame.origin.x = (self.contentOffsetIndex-1) * imageScrollViewFrame.size.width;
	
	self.imageScrollViews = [NSMutableArray array];
	
	CGRect imageViewFrame = CGRectZero;
	imageViewFrame.size = self.scrollView.bounds.size;
	
	for (int i=0; i < kMaxOfScrollView; i++) {
		
		// image view
		//--------------
		UIImageView* imageView =
		[[UIImageView alloc] initWithFrame:imageViewFrame];
		imageView.autoresizingMask =
			UIViewAutoresizingFlexibleLeftMargin  |
			UIViewAutoresizingFlexibleWidth       |
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleTopMargin   |
			UIViewAutoresizingFlexibleHeight      |
			UIViewAutoresizingFlexibleBottomMargin;
		
		// scroll view
		//--------------
		// left space
		imageScrollViewFrame.origin.x += spaceWidth_/2.0;
		
		XCGalleryInerScrollView* imageScrollView =
		[[XCGalleryInerScrollView alloc] initWithFrame:imageScrollViewFrame];
		imageScrollView.minimumZoomScale = 1.0;
		imageScrollView.maximumZoomScale = 5.0;
		imageScrollView.showsHorizontalScrollIndicator = NO;
		imageScrollView.showsVerticalScrollIndicator = NO;
		imageScrollView.backgroundColor = [UIColor blackColor];
		
		// bind views
		[imageScrollView addSubview:imageView];
		[self.scrollView addSubview:imageScrollView];
		
		// store scrollViews
		[self.imageScrollViews addObject:imageScrollView];
		
		// release all
		[imageView release];
		[imageScrollView release];
		
		// setup initial image
		[self setImageAtIndex:i-1 toScrollView:imageScrollView];
		
		// next image
		imageScrollViewFrame.origin.x += imageScrollViewFrame.size.width;
		
		// right space
		imageScrollViewFrame.origin.x += spaceWidth_/2.0;
	}
	
}	

- (void)reloadData
{
	NSInteger numberOfViews = [self.delegate numberViewsInGallery:self];
	if (self.currentImageIndex >= numberOfViews) {
		if (numberOfViews == 0) {
			self.currentImageIndex = 0;
		} else {
			self.currentImageIndex = numberOfViews-1;
		}
		self.contentOffsetIndex = self.currentImageIndex;
	}
	
	for (int index=0; index < kMaxOfScrollView; index++) {
		[self setImageAtIndex:self.currentImageIndex+index-1
				 toScrollView:[self.imageScrollViews objectAtIndex:index]];
	}
}


#pragma mark -
#pragma mark Accessors
- (void)setDelegate:(id <XCGalleryViewDelegate>)delegate
{
	delegate_ = delegate;
	[self reloadData];
}


#pragma mark -
#pragma mark Initialization and deallocation

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
		[self setupSubViews];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self setupSubViews];
    }
    return self;
}

/*
 - (void)awakeFromNib
 {
 [self setupSubViews];
 }
 */

- (void)dealloc {
	self.scrollView = nil;
	self.imageScrollViews = nil;

    [super dealloc];
}


#pragma mark -
#pragma mark Control Scroll

-(void)setupPreviousImage
{
	XCGalleryInerScrollView* previousScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfPreviousScrollView];
	XCGalleryInerScrollView* currentScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfCurrentScrollView];
	XCGalleryInerScrollView* nextScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfNextScrollView];
	
	[self.imageScrollViews removeAllObjects];
	[self.imageScrollViews addObject:nextScrollView];
	[self.imageScrollViews addObject:previousScrollView];
	[self.imageScrollViews addObject:currentScrollView];
	
	CGRect frame = previousScrollView.frame;
	frame.origin.x -= frame.size.width + spaceWidth_;
	nextScrollView.frame = frame;
	[self setImageAtIndex:self.currentImageIndex-1 toScrollView:nextScrollView];
}

-(void)setupNextImage
{
	XCGalleryInerScrollView* previousScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfPreviousScrollView];
	XCGalleryInerScrollView* currentScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfCurrentScrollView];
	XCGalleryInerScrollView* nextScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfNextScrollView];
	
	[self.imageScrollViews removeAllObjects];
	[self.imageScrollViews addObject:currentScrollView];
	[self.imageScrollViews addObject:nextScrollView];
	[self.imageScrollViews addObject:previousScrollView];
	
	CGRect frame = nextScrollView.frame;
	frame.origin.x += frame.size.width + spaceWidth_;
	previousScrollView.frame = frame;
	[self setImageAtIndex:self.currentImageIndex+1 toScrollView:previousScrollView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat position = scrollView.contentOffset.x / scrollView.bounds.size.width;
	CGFloat delta = position - (CGFloat)self.currentImageIndex;
	
	if (fabs(delta) >= 1.0f) {
		XCGalleryInerScrollView* currentScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfCurrentScrollView];
		currentScrollView.zoomScale = 1.0;
		currentScrollView.contentOffset = CGPointZero;
		
		//		NSLog(@"%f (%d=>%d)", delta, self.currentImageIndex, index);
		
		if (delta > 0) {
			// the current page moved to right
			self.currentImageIndex = self.currentImageIndex+1;
			self.contentOffsetIndex = self.contentOffsetIndex+1;
			[self setupNextImage];
			
		} else {
			// the current page moved to left
			self.currentImageIndex = self.currentImageIndex-1;
			self.contentOffsetIndex = self.contentOffsetIndex-1;
			[self setupPreviousImage];
		}
		
	}
	
}


@end
