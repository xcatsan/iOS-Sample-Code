//
//  SubViewController.m
//  ViewControllerMemorySample
//
//  Created by Hiroshi Hashiguchi on 10/10/19.
//  Copyright 2010 . All rights reserved.
//

#import "RootViewController.h"
#import "SubViewController.h"
#import "SubSubViewController.h"


@implementation SubViewController
@synthesize imageView;
@synthesize rootViewController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];

	// for debug
	[self.imageView retain];

	NSLog(@"[Sub ] viewDidLoad|retainCount=%d", [self.imageView retainCount]-1);
	
	rootViewController.childImageView = self.imageView;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewWillDisappear:(BOOL)animated
{
	NSLog(@"[Sub ] viewWillDisappear|retainCount=%d", [self.imageView retainCount]-1);
}
- (void)viewDidDisappear:(BOOL)animated
{
	NSLog(@"[Sub ] viewDidDisappear|retainCount=%d", [self.imageView retainCount]-1);
}

- (void)didReceiveMemoryWarning {
	NSLog(@"[Sub ] didReceiveMemoryWarning|retainCount=%d", [self.imageView retainCount]-1);
    [super didReceiveMemoryWarning];
    

    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	NSLog(@"[Sub ] viewDidUnload[1]|retainCount=%d", [self.imageView retainCount]-1);
//	self.imageView = nil;
	NSLog(@"[Sub ] viewDidUnload[2]|retainCount=%d", [self.imageView retainCount]-1);
}


- (void)dealloc {
	NSLog(@"[Sub ] dealloc|retainCount=%d", [self.imageView retainCount]-1);
	
	self.imageView = nil;
    [super dealloc];
}

- (IBAction)next:(id)sender
{
	SubSubViewController* vc = [[SubSubViewController alloc] initWithNibName:@"SubSubViewController" bundle:nil];
	vc.parentImageView = self.imageView;
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}

@end
