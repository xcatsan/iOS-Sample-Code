//
//  SubSubViewController.m
//  ViewControllerMemorySample
//
//  Created by Hiroshi Hashiguchi on 10/10/19.
//  Copyright 2010 . All rights reserved.
//

#import "SubSubViewController.h"


@implementation SubSubViewController
@synthesize parentImageView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"[SubSub] viewDidLoad|retainCount=%d", [self.parentImageView retainCount]-1);
		
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"[SubSub] viewWillAppear|retainCount=%d", [self.parentImageView retainCount]-1);
	
}
- (void)viewDidAppear:(BOOL)animated {
	NSLog(@"[SubSub] viewDidAppear|retainCount=%d", [self.parentImageView retainCount]-1);
	
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
