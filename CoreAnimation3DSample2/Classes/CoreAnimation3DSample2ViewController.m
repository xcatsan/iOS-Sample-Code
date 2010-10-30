//
//  CoreAnimation3DSample2ViewController.m
//  CoreAnimation3DSample2
//
//  Created by Hiroshi Hashiguchi on 10/10/30.
//  Copyright 2010 . All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CATransform3D.h>
#import "CoreAnimation3DSample2ViewController.h"

@implementation CoreAnimation3DSample2ViewController

@synthesize baseView;

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


#define IMAGE_WIDTH		100
#define IMAGE_HEIGHT	75
#define PADDING_X			10
#define PADDING_Y			10

CGFloat x[9] = {
	0, IMAGE_WIDTH+PADDING_X, (IMAGE_WIDTH+PADDING_X)*2,
	0, IMAGE_WIDTH+PADDING_X, (IMAGE_WIDTH+PADDING_X)*2,
	0, IMAGE_WIDTH+PADDING_X, (IMAGE_WIDTH+PADDING_X)*2
};

CGFloat y[9] = {
	100, 100, 100,
	100+IMAGE_HEIGHT+PADDING_Y, 100+IMAGE_HEIGHT+PADDING_Y, 100+IMAGE_HEIGHT+PADDING_Y,
	100+(IMAGE_HEIGHT+PADDING_Y)*2, 100+(IMAGE_HEIGHT+PADDING_Y)*2, 100+(IMAGE_HEIGHT+PADDING_Y)*2
};

#define DURATION 0.5
- (void)animateFadeInOut:(BOOL)flag
{
	CGFloat zPositionFrom = flag ? -1000 : 0;
	CGFloat zPositionTo = flag ? 0 : -1000;
	CGFloat opacityFrom = flag ? 0.25 : 1.0;
	CGFloat opacityTo = flag ? 1.0 : 0.25;

	CALayer* baseLayer = [self.baseView.layer.sublayers objectAtIndex:0];
	
	CABasicAnimation *animation;
	animation=[CABasicAnimation animationWithKeyPath:@"zPosition"];
	animation.fromValue=[NSNumber numberWithFloat:zPositionFrom];
	animation.toValue=[NSNumber numberWithFloat:zPositionTo];
	animation.duration=DURATION;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	animation.repeatCount = 1;
	animation.delegate = self;
	animation.removedOnCompletion = NO;
	[baseLayer addAnimation:animation forKey:@"zPosition"];

	animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
	animation.fromValue=[NSNumber numberWithFloat:opacityFrom];
	animation.toValue=[NSNumber numberWithFloat:opacityTo];
	animation.duration=DURATION;
	animation.repeatCount = 1;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	[baseLayer addAnimation:animation forKey:@"opacity"];		
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	NSLog(@"%s|%d", __PRETTY_FUNCTION__, flag);
	if (!fadeIn) {
		self.baseView.hidden = YES;
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.baseView.layer.backgroundColor = [[UIColor blackColor] CGColor];
	
	CATransform3D transform = CATransform3DMakeRotation(0, 0, 0, 0); 
	float zDistance = 1000; 
	transform.m34 = 1.0 / zDistance;
	self.baseView.layer.sublayerTransform = transform;
	
	CALayer* baseLayer = [CALayer layer];
	[self.baseView.layer addSublayer:baseLayer];
	
	for (int i=0; i < 9; i++) {
		UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"image%02ds.jpg", i+1]];
		CALayer* layer = [CALayer layer];
		layer.contents = (id)[image CGImage];
		layer.frame = CGRectMake(x[i], y[i], IMAGE_WIDTH, IMAGE_HEIGHT);
		[baseLayer addSublayer:layer];
	}

	fadeIn = NO;
	[self animateFadeInOut:fadeIn];
}

- (IBAction)fadeOut:(id)sender
{
	fadeIn = !fadeIn;
	baseView.hidden = NO;
	[self animateFadeInOut:fadeIn];
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
