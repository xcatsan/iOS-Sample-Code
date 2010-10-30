//
//  CoreAnimation3DSampleViewController.m
//  CoreAnimation3DSample
//
//  Created by Hiroshi Hashiguchi on 10/10/29.
//  Copyright 2010 . All rights reserved.
//

#import "CoreAnimation3DSampleViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CATransform3D.h>

@implementation CoreAnimation3DSampleViewController



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

#define IMAGE_WIDTH		320
#define IMAGE_HEIGHT	240
#define PADDING			20

CGFloat x[9] = {
	-(IMAGE_WIDTH+PADDING), 0, IMAGE_WIDTH+PADDING,
	-(IMAGE_WIDTH+PADDING), 0, IMAGE_WIDTH+PADDING,
	-(IMAGE_WIDTH+PADDING), 0, IMAGE_WIDTH+PADDING
};

CGFloat y[9] = {
	-(IMAGE_HEIGHT+PADDING), -(IMAGE_HEIGHT+PADDING), -(IMAGE_HEIGHT+PADDING),
	0, 0, 0,
	IMAGE_HEIGHT+PADDING, IMAGE_HEIGHT+PADDING, IMAGE_HEIGHT+PADDING 
};

- (void)viewDidLoad {
    [super viewDidLoad];

	self.view.layer.backgroundColor = [[UIColor blackColor] CGColor];
	
	CATransform3D transform = CATransform3DMakeRotation(0, 0, 0, 0); 
	float zDistance = 2000; 
	transform.m34 = 1.0 / -zDistance;
	self.view.layer.sublayerTransform = transform;
	
	CALayer* baseLayer = [CALayer layer];
	[self.view.layer addSublayer:baseLayer];


	for (int i=0; i < 9; i++) {
		UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"image%02ds.jpg", i+1]];
		CALayer* layer = [CALayer layer];
		layer.contents = (id)[image CGImage];
		layer.frame = CGRectMake(x[i], y[i], IMAGE_WIDTH, IMAGE_HEIGHT);
		CGPoint p = layer.frame.origin;
		p.x += 320/2;
		p.y += (480-2)/2;
		layer.position = p;
		[baseLayer addSublayer:layer];
/*
		CABasicAnimation *theAnimation;
		theAnimation=[CABasicAnimation animationWithKeyPath:@"zPosition"];
		theAnimation.fromValue=[NSNumber numberWithFloat:-4000];
		theAnimation.toValue=[NSNumber numberWithFloat:1000];
		theAnimation.duration=10;
		theAnimation.repeatCount = 1e100;
		[layer addAnimation:theAnimation forKey:@"zPosition"];
		
		theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
		theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
		theAnimation.toValue=[NSNumber numberWithFloat:0.0];
		theAnimation.duration=10;
		theAnimation.repeatCount = 1e100;
		[layer addAnimation:theAnimation forKey:@"opacity"];
*/
	}
	
	CABasicAnimation *theAnimation;
	theAnimation=[CABasicAnimation animationWithKeyPath:@"zPosition"];
	theAnimation.fromValue=[NSNumber numberWithFloat:-4000];
	theAnimation.toValue=[NSNumber numberWithFloat:1000];
	theAnimation.duration=10;
	theAnimation.repeatCount = 1e100;
	[baseLayer addAnimation:theAnimation forKey:@"zPosition"];
	
	theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
	theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
	theAnimation.toValue=[NSNumber numberWithFloat:0.0];
	theAnimation.duration=10;
	theAnimation.repeatCount = 1e100;
	[baseLayer addAnimation:theAnimation forKey:@"opacity"];
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
