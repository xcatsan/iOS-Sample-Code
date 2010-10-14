//
//  TransitionSampleViewController.m
//  TransitionSample
//
//  Created by Hiroshi Hashiguchi on 10/10/14.
//  Copyright 2010 . All rights reserved.
//

#import "TransitionSampleViewController.h"

@implementation TransitionSampleViewController
@synthesize imageView;
@synthesize images;
@synthesize slider;
@synthesize duration;

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
	
	self.images = [NSMutableArray array];
	
	for (int i=1; i <= 8; i++) {
		NSString* filename = [NSString stringWithFormat:@"image%02d.jpg", i];
		UIImage* image = [UIImage imageNamed:filename];
		[self.images addObject:image];
	}
	imageIndex = 0;
	self.imageView.image = [self.images objectAtIndex:imageIndex];
	duration.text = [NSString stringWithFormat:@"%.1f", self.slider.value];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

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


- (void)doTransition:(UIViewAnimationTransition)transition
{
	[UIView beginAnimations:nil context:nil];
	
	[UIView setAnimationTransition:transition
						   forView:self.imageView
							 cache:NO];
	[UIView setAnimationDuration:self.slider.value];
	imageIndex = (imageIndex+1)%8;
	self.imageView.image = [self.images objectAtIndex:imageIndex];
	
	
	[UIView commitAnimations];
}

-(IBAction)none:(id)sender
{
	[self doTransition:UIViewAnimationTransitionNone];
}


-(IBAction)flipFromLeft:(id)sender
{
	[self doTransition:UIViewAnimationTransitionFlipFromLeft];
}

-(IBAction)flipFromRight:(id)sender
{
	[self doTransition:UIViewAnimationTransitionFlipFromRight];
}

-(IBAction)curlUp:(id)sender
{
	[self doTransition:UIViewAnimationTransitionCurlUp];
}

-(IBAction)curlDown:(id)sender
{
	[self doTransition:UIViewAnimationTransitionCurlDown];
}

-(IBAction)didChangeDuration:(id)sender
{
	NSLog(@"%f", self.slider.value);
	duration.text = [NSString stringWithFormat:@"%.1f", self.slider.value];

}

@end
