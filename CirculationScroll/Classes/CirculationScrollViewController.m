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
#define DISPLAY_IMAGE_NUM	4
#define MAX_IMAGE_NUM		(DISPLAY_IMAGE_NUM+2)

@implementation CirculationScrollViewController

@synthesize scrollView = scrollView_;
@synthesize viewList = viewList_;
@synthesize imageList = imageList_;

- (void)viewDidLoad {
    [super viewDidLoad];

	
	NSMutableArray* array = [NSMutableArray array];
	
	CGRect imageViewFrame = CGRectMake(-IMAGE_WIDTH, 0, IMAGE_WIDTH, IMAGE_HEIGHT);

	for (int i=0; i < MAX_IMAGE_NUM; i++) {
		UIImageView* view = [[[UIImageView alloc]
							  initWithFrame:imageViewFrame] autorelease];
		[array addObject:view];
		
		imageViewFrame.origin.x += IMAGE_WIDTH;

		[self.scrollView addSubview:view];
	}
	self.viewList = array;

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
}


- (void)dealloc {
    [super dealloc];
}

- (UIImage*)blankImage
{
	return [UIImage imageNamed:@"blank.jpg"];
}

- (void)setImageList:(NSArray*)list
{
	// store list
	[list retain];
	[imageList_ release];
	imageList_ = list;
	
	// initialize indices
	leftImageIndex_ = 0;
	leftViewIndex_ = 0;
	rightViewIndex_ = MAX_IMAGE_NUM-1;
	
	NSInteger count = [list count];

	// [1]setup scrollView
	CGSize contentSize = CGSizeMake(0, IMAGE_HEIGHT);
	contentSize.width = IMAGE_WIDTH * count;
	self.scrollView.contentSize = contentSize;

	// [1]setup blank
	for (int i=0; i < MAX_IMAGE_NUM; i++) {
		UIImageView* view = [self.viewList objectAtIndex:i];
		view.image = [self blankImage];
	}

	// [2]display area
	NSInteger index = 1;	// skip 0
	for (UIImage* image in list) {
		UIImageView* view = [self.viewList objectAtIndex:index];
		view.image = image;
		index++;
		if (index > DISPLAY_IMAGE_NUM) {
			break;
		}
	}
	
	// [3]outside
	if (count >= DISPLAY_IMAGE_NUM) {

		/*
		// left side
		UIImageView* left = [viewList objectAtIndex:0];
		left.image = [list objectAtIndex:count-1];
		 */

		// right side
		UIImageView* right = [self.viewList objectAtIndex:MAX_IMAGE_NUM-1];
		if (count == DISPLAY_IMAGE_NUM) {
			right.image = [list objectAtIndex:0];
		} else {
			right.image = [list objectAtIndex:DISPLAY_IMAGE_NUM];
		}

	}
}

#pragma mark -
#pragma mark UIScrollViewDelegate

typedef enum {
	kScrollDirectionLeft,
	kScrollDirectionRight
} ScrollDirection;

- (NSInteger)addViewIndex:(NSInteger)index incremental:(NSInteger)incremental
{
	return (index + incremental + MAX_IMAGE_NUM) % MAX_IMAGE_NUM;
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
	UIImageView* view = [self.viewList objectAtIndex:viewIndex];
	CGRect frame = view.frame;
	frame.origin.x += IMAGE_WIDTH * MAX_IMAGE_NUM * incremental;
	view.frame = frame;
	
	// change image
	NSInteger numberOfImages = [self.imageList count];
	leftImageIndex_ = leftImageIndex_ + incremental;

	if (scrollDirection == kScrollDirectionLeft) {
		imageIndex = leftImageIndex_ -1;
	} else if (scrollDirection == kScrollDirectionRight) {
		imageIndex = leftImageIndex_ + DISPLAY_IMAGE_NUM;
	}
	if (0 <= imageIndex && imageIndex < numberOfImages) {
		view.image = [self.imageList objectAtIndex:imageIndex];
	} else {
		view.image = [self blankImage];
	}

	// adjust indicies
	leftViewIndex_ = [self addViewIndex:leftViewIndex_ incremental:incremental];
	rightViewIndex_ = [self addViewIndex:rightViewIndex_ incremental:incremental];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat position = scrollView.contentOffset.x / IMAGE_WIDTH;
	CGFloat delta = position - (CGFloat)leftImageIndex_;
	
	if (fabs(delta) >= 1.0f) {
		if (delta > 0) {
			[self scrollWithDirection:kScrollDirectionRight];
		} else {
			[self scrollWithDirection:kScrollDirectionLeft];			
		}		
	}
}

@end
