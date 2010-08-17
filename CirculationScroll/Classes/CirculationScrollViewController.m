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

@synthesize scrollView, viewList, imageList;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder]) {
		
		NSMutableArray* array = [NSMutableArray array];
		CGRect imageViewFrame = CGRectMake(-IMAGE_WIDTH, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
		for (int i=0; i < MAX_IMAGE_NUM; i++) {
			UIImageView* view = [[[UIImageView alloc] initWithFrame:imageViewFrame] autorelease];
			[array addObject:view];
			
			imageViewFrame.origin.x += IMAGE_WIDTH;
		}
		self.viewList = array;
	}
	return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	
	CGSize contentSize = CGSizeMake(0, IMAGE_HEIGHT);
	for (UIImageView* view in viewList) {
		[self.scrollView addSubview:view];
		contentSize.width += view.bounds.size.width;
	}
	self.scrollView.contentSize = contentSize;

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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.scrollView = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)setImageList:(NSArray*)list
{
	[list retain];
	[imageList release];
	imageList = list;
	
	NSInteger count = [list count];

	// [0]setup blank
	UIImage* blank = [UIImage imageNamed:@"blank"];
	for (int i=0; i < MAX_IMAGE_NUM; i++) {
		UIImageView* view = [self.viewList objectAtIndex:i];
		view.image = blank;
	}
	
	// [1]display area
	NSInteger index = 1;	// skip 0
	for (UIImage* image in list) {
		UIImageView* view = [viewList objectAtIndex:index];
		view.image = image;
		index++;
		if (index > DISPLAY_IMAGE_NUM) {
			break;
		}
	}
	
	// [2]outside
	if (count >= DISPLAY_IMAGE_NUM) {

		// left side
		UIImageView* left = [viewList objectAtIndex:0];
		left.image = [list objectAtIndex:count-1];

		// right side
		UIImageView* right = [viewList objectAtIndex:MAX_IMAGE_NUM-1];
		if (count == DISPLAY_IMAGE_NUM) {
			right.image = [list objectAtIndex:0];
		} else {
			right.image = [list objectAtIndex:DISPLAY_IMAGE_NUM];
		}

	}
		
}

@end
