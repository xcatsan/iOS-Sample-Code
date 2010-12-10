//
//  XcodeMacroViewController.m
//  XcodeMacro
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

- (void)InstanceFooMethodWith:(NSString*)arg1 and:(NSString*)arg2
{
	NSLog(@"----------------------------------");
	NSLog(@"__FILE__: %s", __FILE__);
	NSLog(@"__LINE__: %d", __LINE__);
	NSLog(@"__FUNCTION__: %s", __FUNCTION__);
	NSLog(@"__PRETTY_FUNCTION__: %s", __PRETTY_FUNCTION__);
}

+ (void)ClassFooMethodWith:(NSString*)arg1 and:(NSString*)arg2
{
	NSLog(@"----------------------------------");
	NSLog(@"__FILE__: %s", __FILE__);
	NSLog(@"__LINE__: %d", __LINE__);
	NSLog(@"__FUNCTION__: %s", __FUNCTION__);
	NSLog(@"__PRETTY_FUNCTION__: %s", __PRETTY_FUNCTION__);
}

void Function(NSString* arg1)
{
	NSLog(@"----------------------------------");
	NSLog(@"__FILE__: %s", __FILE__);
	NSLog(@"__LINE__: %d", __LINE__);
	NSLog(@"__FUNCTION__: %s", __FUNCTION__);
	NSLog(@"__PRETTY_FUNCTION__: %s", __PRETTY_FUNCTION__);
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[[self class] ClassFooMethodWith:nil and:nil];
	[self InstanceFooMethodWith:nil and:nil];
	Function(@"a");
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
