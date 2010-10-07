//
//  ScrollViewPagingViewController.m
//  ScrollViewPaging
//
//  Created by Hiroshi Hashiguchi on 10/10/06.
//  Copyright 2010 . All rights reserved.
//

#import "ScrollViewPagingViewController.h"
#import "CustomView.h"

@implementation ScrollViewPagingViewController

@synthesize scrollView;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
#define SPACE_WIDTH 20
#define NUMBER_OF_VIEWS 5
- (void)viewDidLoad {
    [super viewDidLoad];

	CGRect scrollViewFrame = self.scrollView.frame;
	CGSize scrollViewSize = scrollViewFrame.size;
	scrollViewFrame.origin.x -= SPACE_WIDTH/2;
	scrollViewFrame.size.width += SPACE_WIDTH;
	self.scrollView.frame = scrollViewFrame;
	self.scrollView.contentSize = CGSizeMake((scrollViewSize.width+SPACE_WIDTH)*NUMBER_OF_VIEWS, scrollViewSize.height);
	self.scrollView.pagingEnabled = YES;
	self.scrollView.clipsToBounds = NO;

	CGFloat x = 0;

	for (int i=0; i < NUMBER_OF_VIEWS; i++) {
		
		// left space
		x += SPACE_WIDTH/2.0;

		// content
		CGRect rect = CGRectMake(x, 0, scrollViewSize.width, scrollViewSize.height);
		CustomView* view = [[[CustomView alloc] initWithFrame:rect] autorelease];
		[self.scrollView addSubview:view];
		x += rect.size.width;

		// right space
		x += SPACE_WIDTH/2.0;
	}
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
}


- (void)dealloc {
    [super dealloc];
}

@end
