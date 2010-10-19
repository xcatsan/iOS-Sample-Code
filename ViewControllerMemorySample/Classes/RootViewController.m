//
//  RootViewController.m
//  ViewControllerMemorySample
//
//  Created by Hiroshi Hashiguchi on 10/10/19.
//  Copyright 2010 . All rights reserved.
//

#import "RootViewController.h"
#import "SubViewController.h"

@implementation RootViewController
@synthesize childImageView;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Root";
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
- (void)printRetainCount
{
	NSLog(@"[Root] retainCount=%d", [self.childImageView retainCount]-1);
}

- (void)viewDidAppear:(BOOL)animated {
	
	if (self.childImageView) {
		[self performSelector:@selector(printRetainCount)
				   withObject:nil
				   afterDelay:1.0];
	}
}

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction)next:(id)sender
{
	SubViewController* vc = [[SubViewController alloc] initWithNibName:@"SubViewController" bundle:nil];
	vc.rootViewController = self;
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}

@end

