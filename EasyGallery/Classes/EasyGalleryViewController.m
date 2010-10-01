//
//  EasyGalleryViewController.m
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/09/28.
//  Copyright 2010 . All rights reserved.
//

#import "EasyGalleryViewController.h"
#import "CustomImageView.h"

enum {
	kIndexOfPreviousScrollView = 0,
	kIndexOfCurrentScrollView,
	kIndexOfNextScrollView,
	kMaxOfScrollView
};

@implementation EasyGalleryViewController

@synthesize imageFiles = imageFiles_;
@synthesize currentImageIndex = currentImageIndex_;

@synthesize scrollView = scrollView_;
@synthesize contentOffsetIndex = contentOffsetIndex_;

@synthesize imageScrollViews = imageScrollViews_;

#pragma mark -
#pragma mark Controle scroll views
- (void)setImageAtIndex:(NSInteger)index toScrollView:(UIScrollView*)scrollView
{
	CustomImageView* imageView = [scrollView.subviews objectAtIndex:0];
	if (index < 0 || [self.imageFiles count] <= index) {
		imageView.image = nil;
		scrollView.delegate = nil;
		return;
	}

	UIImage* image = [UIImage imageWithContentsOfFile:[self.imageFiles objectAtIndex:index]];
	imageView.image = image;
	imageView.contentMode = (image.size.width > image.size.height) ?
	UIViewContentModeScaleAspectFit : UIViewContentModeScaleAspectFill;
	scrollView.delegate = imageView;
}


- (void)layoutScrollViews
{
	CGSize newSize = self.view.bounds.size;
	
	CGFloat x = (self.contentOffsetIndex-1) * newSize.width;
	for (UIScrollView* scrollView in self.imageScrollViews) {
		scrollView.frame = CGRectMake(x, 0, newSize.width, newSize.height);
		scrollView.contentSize = newSize;
		x += newSize.width;
	}
	
	self.scrollView.contentSize = CGSizeMake(
											 [self.imageFiles count]*newSize.width, newSize.height);
	self.scrollView.contentOffset = CGPointMake(self.contentOffsetIndex*newSize.width, 0);
}


#pragma mark -
#pragma mark UIViewController
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// setup internal scroll views
	CGRect imageScrollViewFrame = CGRectZero;
	imageScrollViewFrame.size = self.scrollView.bounds.size;
	imageScrollViewFrame.origin.x = (self.contentOffsetIndex-1) * imageScrollViewFrame.size.width;
	
	self.imageScrollViews = [NSMutableArray array];
	
	CGRect imageViewFrame = CGRectZero;
	imageViewFrame.size = self.scrollView.bounds.size;
	
	for (int i=0; i < kMaxOfScrollView; i++) {

		// image view
		CustomImageView* imageView =
			[[CustomImageView alloc] initWithFrame:imageViewFrame];
		imageView.autoresizingMask =
			UIViewAutoresizingFlexibleLeftMargin  |
			UIViewAutoresizingFlexibleWidth       |
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleTopMargin   |
			UIViewAutoresizingFlexibleHeight      |
			UIViewAutoresizingFlexibleBottomMargin;
		
		// scroll view
		UIScrollView* imageScrollView =
			[[UIScrollView alloc] initWithFrame:imageScrollViewFrame];
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
	}
	
	// setup base scroll view
	self.scrollView.pagingEnabled = YES;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
	self.scrollView.scrollsToTop = NO;

	// final init
	[self layoutScrollViews];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	[self layoutScrollViews];
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.imageFiles = nil;

	self.scrollView = nil;
	self.imageScrollViews = nil;
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark COntrol 

-(void)setupPreviousImage
{
	UIScrollView* previousScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfPreviousScrollView];
	UIScrollView* currentScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfCurrentScrollView];
	UIScrollView* nextScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfNextScrollView];
	
	[self.imageScrollViews removeAllObjects];
	[self.imageScrollViews addObject:nextScrollView];
	[self.imageScrollViews addObject:previousScrollView];
	[self.imageScrollViews addObject:currentScrollView];

	CGRect frame = previousScrollView.frame;
	frame.origin.x -= frame.size.width;
	nextScrollView.frame = frame;
	[self setImageAtIndex:self.currentImageIndex-1 toScrollView:nextScrollView];
}

-(void)setupNextImage
{
	UIScrollView* previousScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfPreviousScrollView];
	UIScrollView* currentScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfCurrentScrollView];
	UIScrollView* nextScrollView =
		[self.imageScrollViews objectAtIndex:kIndexOfNextScrollView];
	
	[self.imageScrollViews removeAllObjects];
	[self.imageScrollViews addObject:currentScrollView];
	[self.imageScrollViews addObject:nextScrollView];
	[self.imageScrollViews addObject:previousScrollView];
	
	CGRect frame = nextScrollView.frame;
	frame.origin.x += frame.size.width;
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
		UIScrollView* currentScrollView =
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
