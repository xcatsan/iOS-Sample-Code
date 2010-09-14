//
//  WaitScreenSampleViewController.m
//  WaitScreenSample
//
//  Created by Hiroshi Hashiguchi on 10/09/13.
//  Copyright  2010. All rights reserved.
//

#import "WaitScreenSampleViewController.h"

@implementation WaitScreenSampleViewController

@synthesize label;
@synthesize label2;

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


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


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

- (IBAction)start:(id)sender
{
	NSLog(@"setup");

	NSLog(@"1: %@", [NSThread currentThread]);
	NSBlockOperation* operation = [NSBlockOperation blockOperationWithBlock: ^{
		NSLog(@"2: %@", [NSThread currentThread]);
		for (int i=0; i < 10; i++) {
			[label performSelectorInBackground:@selector(setText:)
									withObject:[NSString stringWithFormat:@"running: %d", i+1]];
			[NSThread sleepForTimeInterval:1.0];
		}
	}];

	[operation addExecutionBlock:^{
		NSLog(@"3: %@", [NSThread currentThread]);
		for (int i=0; i < 5; i++) {
			[label2 performSelectorInBackground:@selector(setText:)
									withObject:[NSString stringWithFormat:@"running: %d", i+1]];
			[NSThread sleepForTimeInterval:2.0];
		}
	}];

	[operation setCompletionBlock:^{
		NSLog(@"4: %@", [NSThread currentThread]);
		label.text = @"completion";
		label2.text = @"completion";
	}];

	NSLog(@"start");
	[operation start];
	
	NSLog(@"end");
}

@end
