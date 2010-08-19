//
//  NetworkReachableViewController.m
//  NetworkReachable
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright  2010. All rights reserved.
//
#import "NetworkReachableViewController.h"
#import "NetworkReachability.h"

@implementation NetworkReachableViewController
@synthesize label;


-(void)updateStatus
{
	int mode = [networkReachability_ getConnectionMode];
	NSString* message = nil;
	
	switch (mode) {
		case kNetworkReachableNon:
			message = @"no connection";
			break;
		case kNetworkReachableWWAN:
			message = @"Celluar connection";
			break;
		case kNetworkReachableWiFi:
			message = @"WiFi connection";
			break;
	}
	self.label.text = message;
	NSLog(@"%@", message);
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

- (void) reachabilityChanged: (NSNotification* )note
{
	NSLog(@"changed:%@", note);
	[self updateStatus];
}

- (void)viewDidLoad {
    [super viewDidLoad];

	networkReachability_ =
		[[NetworkReachability alloc] initWithHostname:@"www.google.com"];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(reachabilityChanged:)
												 name:NetworkReachabilityChangedNotification
											   object: nil];
	BOOL ret = [networkReachability_ startNotifier];
	NSLog(@"startNodifier: %d", ret);
	
	[self updateStatus];
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
	[networkReachability_ release];
}


- (void)dealloc {
    [super dealloc];
}



@end
