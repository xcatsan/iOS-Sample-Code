//
//  PrettyFunctionViewController.m
//  PrettyFunction
//
//  Created by Hiroshi Hashiguchi on 10/10/22.
//  Copyright 2010 . All rights reserved.
//

#import "ViewController.h"

@implementation ViewController



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
    // Override point for customization after application launch.

	NSLog(@"1: %s", __PRETTY_FUNCTION__);
	
	[UIView animateWithDuration:1.0
					 animations:^{
						 NSLog(@"2: %s", __PRETTY_FUNCTION__);
					 }];
	
	[UIView animateWithDuration:1.0
					 animations:^{
						 NSLog(@"3: %s", __PRETTY_FUNCTION__);
					 }];


	[UIView animateWithDuration:1.0
					 animations:^{
						 [UIView animateWithDuration:1.0
										  animations:^{
											  NSLog(@"4: %s", __PRETTY_FUNCTION__);
										  }];
					 }];
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
