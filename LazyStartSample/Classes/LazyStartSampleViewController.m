//
//  LazyStartSampleViewController.m
//  LazyStartSample
//
//  Created by Hiroshi Hashiguchi on 11/02/11.
//  Copyright 2011 . All rights reserved.
//

#import "LazyStartSampleViewController.h"
#import "SubViewController.h"

@implementation LazyStartSampleViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
/*
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, @"sleeping...");
	[NSThread sleepForTimeInterval:25.0];
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, @"finished");	
 */
}

- (void)viewWillAppear:(BOOL)animated
{
//	NSLog(@"%s|%@", __PRETTY_FUNCTION__, @"sleeping...");
//	[NSThread sleepForTimeInterval:25.0];
//	NSLog(@"%s|%@", __PRETTY_FUNCTION__, @"finished");
	
}
-(IBAction)doit
{
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, @"sleeping...");
	[NSThread sleepForTimeInterval:25.0];
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, @"finished");
}


- (void)viewDidAppear:(BOOL)animated
{
//	NSLog(@"%s|%@", __PRETTY_FUNCTION__, @"sleeping...");
//	[NSThread sleepForTimeInterval:25.0];
//	NSLog(@"%s|%@", __PRETTY_FUNCTION__, @"finished");
	

	SubViewController* viewController = [[SubViewController alloc] init];
	[self presentModalViewController:viewController
							animated:YES];
	[viewController release];
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
