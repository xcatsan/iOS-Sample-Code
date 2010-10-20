//
//  HorizontalScrollableUITableViewViewController.m
//  HorizontalScrollableUITableView
//
//  Created by Hiroshi Hashiguchi on 10/10/19.
//  Copyright 2010 . All rights reserved.
//

#import "HorizontalScrollableUITableViewViewController.h"
#import "InnerView.h"


#define SPACE_WIDTH 40

@implementation HorizontalScrollableUITableViewViewController

@synthesize scrollView = scrollView_;
@synthesize currentViewIndex = currentViewIndex_;
@synthesize contentOffsetIndex = contentOffsetIndex_;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// setup scrollview
	self.scrollView.delegate = self;
	self.scrollView.pagingEnabled = YES;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.showsVerticalScrollIndicator = NO;
	self.scrollView.scrollsToTop = NO;

	CGRect innerViewFrame = self.scrollView.bounds;

	CGRect scrollViewFrame = self.scrollView.frame;
	scrollViewFrame.origin.x -= SPACE_WIDTH/2;
	scrollViewFrame.size.width += SPACE_WIDTH;
	self.scrollView.frame = scrollViewFrame;
		
	for (int i=0; i < 3; i++) {
		innerViewFrame.origin.x += SPACE_WIDTH/2;
		
		InnerView* innerView = [[InnerView alloc] initWithFrame:innerViewFrame];
		innerView.dataSource = self;
		[self.scrollView addSubview:innerView];
		[innerView release];
		
		innerViewFrame.origin.x += innerViewFrame.size.width;
		innerViewFrame.origin.x += SPACE_WIDTH/2;
	}
	
	self.scrollView.contentSize = CGSizeMake(scrollViewFrame.size.width*3, scrollViewFrame.size.height);
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



#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	NSLog(@"scrollViewDidScroll:");
	return;

	CGFloat position = scrollView.contentOffset.x / scrollView.bounds.size.width;
	CGFloat delta = position - (CGFloat)self.currentViewIndex;
	
	if (fabs(delta) >= 1.0f) {
		//		NSLog(@"%f (%d=>%d)", delta, self.currentViewIndex, index);
		
		if (delta > 0) {
			// the current page moved to right
			self.currentViewIndex = self.currentViewIndex+1;
			self.contentOffsetIndex = self.contentOffsetIndex+1;
			
		} else {
			// the current page moved to left
			self.currentViewIndex = self.currentViewIndex-1;
			self.contentOffsetIndex = self.contentOffsetIndex-1;
		}
		
		InnerView* innerView = [self.scrollView.subviews objectAtIndex:self.currentViewIndex];
		[innerView reloadData];
	}
	
}



#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									   reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [NSString stringWithFormat:@"currentIndex:%d", self.currentViewIndex];

    return cell;
}



#pragma mark -
#pragma mark UITableViewDelegate


#pragma mark -
#pragma mark Event
- (void)scroll
{
	CGPoint offset = 
	CGPointMake(self.scrollView.bounds.size.width * self.currentViewIndex, 0);
	self.scrollView.contentOffset = offset;
	InnerView* innerView = [self.scrollView.subviews objectAtIndex:self.currentViewIndex];
	[innerView reloadData];
}

- (IBAction)movePrevious:(id)sender
{
	if (self.currentViewIndex == 0) {
		return;
	}
	self.currentViewIndex -= 1;
	[self scroll];
}

- (IBAction)moveNext:(id)sender
{
	if (self.currentViewIndex >= 2) {
		return;
	}
	self.currentViewIndex += 1;
	
	[self scroll];
}

@end
