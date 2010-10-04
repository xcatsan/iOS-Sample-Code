//
//  ScrollViewZoomingViewController.m
//  ScrollViewZooming
//
//  Created by Hiroshi Hashiguchi on 10/10/04.
//  Copyright 2010 . All rights reserved.
//

#import "ScrollViewZoomingViewController.h"

@implementation ScrollViewZoomingViewController

@synthesize imageView;
@synthesize contentOffsetLabel;
@synthesize scrollView;
@synthesize contentSizeLabel;

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return imageView;
}


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
	self.contentOffsetLabel.text = NSStringFromCGPoint(self.scrollView.contentOffset);
	self.contentSizeLabel.text = NSStringFromCGSize(self.scrollView.contentSize);

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

-(void)setZoomScale:(CGFloat)scale
{
    CGRect zoomRect;
    zoomRect.size.height = self.scrollView.frame.size.height / scale;
    zoomRect.size.width  = self.scrollView.frame.size.width  / scale;
	zoomRect.origin.x = 100.0;
    zoomRect.origin.y = 100.0;
	[self.scrollView zoomToRect:zoomRect animated:YES];
	
	self.contentOffsetLabel.text = NSStringFromCGPoint(self.scrollView.contentOffset);
	self.contentSizeLabel.text = NSStringFromCGSize(self.scrollView.contentSize);
}

- (IBAction)x1:(id)sender
{
	[self.scrollView setZoomScale:1.0 animated:YES];
	self.scrollView.contentOffset = CGPointMake(100, 100);
	self.contentOffsetLabel.text = NSStringFromCGPoint(self.scrollView.contentOffset);
	self.contentSizeLabel.text = NSStringFromCGSize(self.scrollView.contentSize);
}

- (IBAction)x2:(id)sender
{
	[self setZoomScale:2.0];
}

- (IBAction)x3:(id)sender
{
	[self setZoomScale:3.0];

}

@end
