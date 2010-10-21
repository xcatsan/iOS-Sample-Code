//
//  TransitionSample2ViewController.m
//  TransitionSample2
//
//  Created by Hiroshi Hashiguchi on 10/10/14.
//  Copyright 2010 . All rights reserved.
//

#import "TransitionSample2ViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation TransitionSample2ViewController

@synthesize baseView;
@synthesize imageView1, imageView2, slider,duration;
@synthesize images;
@synthesize mainType, subType;

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
	self.imageView1.image = [self.images objectAtIndex:imageIndex];
	self.imageView2.hidden = YES;
	duration.text = [NSString stringWithFormat:@"%.1f", self.slider.value];
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

-(IBAction)doTransition:(id)sender;
{
	
	
	// setup next image
	imageIndex = (imageIndex+1)%8;
	imageView2.image = [images objectAtIndex:imageIndex];
	
	// transition
	CATransition* transition = [CATransition animation];
	transition.duration = self.slider.value;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	NSString *maintypes[4] = {kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
	NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom};

	transition.type = maintypes[mainType.selectedSegmentIndex];
	if (mainType.selectedSegmentIndex < 3) {
		transition.subtype = subtypes[subType.selectedSegmentIndex];
	}
	
	[self.baseView.layer addAnimation:transition forKey:nil];
	
	imageView1.hidden = YES;
	imageView2.hidden = NO;
	
	UIImageView* tmp = imageView2;
	imageView2 = imageView1;
	imageView1 = tmp;
}

-(IBAction)didChangeDuration:(id)sender
{
	duration.text = [NSString stringWithFormat:@"%.1f", self.slider.value];
	
}


@end
