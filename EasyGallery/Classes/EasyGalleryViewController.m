//
//  EasyGalleryViewController.m
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/09/28.
//  Copyright 2010 . All rights reserved.
//

#import "EasyGalleryViewController.h"

@implementation EasyGalleryViewController

@synthesize imageFiles = imageFiles_;

@synthesize scrollView = scrollView_;

@synthesize previousScrollView = previousScrollView_;
@synthesize currentScrollView = currentScrollView_;
@synthesize nextScrollView = nextScrollView_;

@synthesize currentIndex = currentIndex_;


#pragma mark -
#pragma mark Controle scroll views
- (void)setImageAtIndex:(NSInteger)index toScrollView:(UIScrollView*)scrollView
{
	UIImageView* imageView = [scrollView.subviews objectAtIndex:0];
	if (index < 0 || [self.imageFiles count] <= index) {
		imageView.image = nil;
		scrollView.delegate = nil;
		return;
	}

	UIImage* image = [UIImage imageWithContentsOfFile:[self.imageFiles objectAtIndex:index]];
	imageView.image = image;
	imageView.contentMode = (image.size.width > image.size.height) ?
	UIViewContentModeScaleAspectFit : UIViewContentModeScaleAspectFill;
//	scrollView.delegate = imageView;
}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated
{
	CGPoint contentOffset =
	CGPointMake(index * self.scrollView.frame.size.width, 0);
	[self.scrollView setContentOffset:contentOffset animated:animated];
	
}

- (void)adjustViews
{
	CGSize contentSize = CGSizeMake(
									self.currentScrollView.frame.size.width * [self.imageFiles count], 
									self.currentScrollView.frame.size.height);
	self.scrollView.contentSize = contentSize;
	
	[self setImageAtIndex:self.currentIndex-1 toScrollView:self.previousScrollView];
	[self setImageAtIndex:self.currentIndex   toScrollView:self.currentScrollView];
	[self setImageAtIndex:self.currentIndex+1 toScrollView:self.nextScrollView];
}


#pragma mark -
#pragma mark UIViewController
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// setup scroll views
	CGRect imageScrollViewFrame = CGRectZero;
	imageScrollViewFrame.size = self.scrollView.frame.size;
	imageScrollViewFrame.origin.x = (self.currentIndex-1) * imageScrollViewFrame.size.width;
	
	CGRect imageViewFrame = CGRectZero;
	imageViewFrame.size = self.scrollView.frame.size;
	
	for (int i=0; i < 3; i++) {

		// image view
		UIImageView* imageView =
			[[UIImageView alloc] initWithFrame:imageViewFrame];
		imageView.autoresizingMask =
			UIViewAutoresizingFlexibleLeftMargin  |
			UIViewAutoresizingFlexibleWidth       |
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleTopMargin   |
			UIViewAutoresizingFlexibleHeight      |
			UIViewAutoresizingFlexibleBottomMargin;
//		imageView.delegate = self;
		
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

		// assign to iVars
		switch (i) {
			case 0:
				self.previousScrollView = imageScrollView;
				break;
			case 1:
				self.currentScrollView = imageScrollView;
				break;
			case 2:
				self.nextScrollView = imageScrollView;
				break;				
		}
		
		// release all
		[imageView release];
		[imageScrollView release];
		
		// next image
		imageScrollViewFrame.origin.x += imageScrollViewFrame.size.width;
	}
	
	self.scrollView.pagingEnabled = YES;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
	self.scrollView.scrollsToTop = NO;
	
	[self adjustViews];
	[self scrollToIndex:self.currentIndex animated:NO];	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.imageFiles = nil;

	self.scrollView = nil;
	
	self.previousScrollView = nil;
	self.currentScrollView = nil;
	self.nextScrollView = nil;
	
}

- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark COntrol 

-(void)setupPreviousImage
{
	UIScrollView* tmpView = self.currentScrollView;
	
	self.currentScrollView = self.previousScrollView;
	self.previousScrollView = self.nextScrollView;
	self.nextScrollView = tmpView;
	
	CGRect frame = self.currentScrollView.frame;
	frame.origin.x -= frame.size.width;
	self.previousScrollView.frame = frame;
	[self setImageAtIndex:self.currentIndex-1 toScrollView:self.previousScrollView];
}

-(void)setupNextImage
{
	UIScrollView* tmpView = self.currentScrollView;
	
	self.currentScrollView = self.nextScrollView;
	self.nextScrollView = self.previousScrollView;
	self.previousScrollView = tmpView;
	
	CGRect frame = self.currentScrollView.frame;
	frame.origin.x += frame.size.width;
	self.nextScrollView.frame = frame;
	[self setImageAtIndex:self.currentIndex+1 toScrollView:self.nextScrollView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat position = scrollView.contentOffset.x / scrollView.bounds.size.width;
	CGFloat delta = position - (CGFloat)self.currentIndex;
	
	if (fabs(delta) >= 1.0f) {
		self.currentScrollView.zoomScale = 1.0;
		self.currentScrollView.contentOffset = CGPointZero;
		
		//		NSLog(@"%f (%d=>%d)", delta, self.currentIndex, index);
		
		if (delta > 0) {
			// the current page moved to right
			self.currentIndex = self.currentIndex+1;	// no check (no over case)
			[self setupNextImage];
			
		} else {
			// the current page moved to left
			self.currentIndex = self.currentIndex-1;	// no check (no over case)
			[self setupPreviousImage];
		}
		
	}
	
}


@end
