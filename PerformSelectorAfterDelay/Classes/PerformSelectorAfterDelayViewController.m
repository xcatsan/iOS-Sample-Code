//
//  PerformSelectorAfterDelayViewController.m
//  PerformSelectorAfterDelay
//
//  Created by Hiroshi Hashiguchi on 10/07/30.
//  Copyright Hiroshi Hashiguchi 2010. All rights reserved.
//

#import "PerformSelectorAfterDelayViewController.h"
#import "NSObject_Extension.h"

@implementation PerformSelectorAfterDelayViewController

@synthesize label = label_;


- (void)doneWithObject:(id)object
{
	self.label.text = object;
}

- (void)viewWillAppear:(BOOL)animated {

	/*
	[self performSelector:@selector(doneWithObject:)
			   withObject:@"DONE!"
			   afterDelay:5];
	 */

	/*
	[self performBlock:^(id selfObject) {
				((PerformSelectorAfterDelayViewController*)selfObject).label.text = @"DONE-2";
			}
			afterDelay:4];
	 */
	[self performBlock:^(void) {self.label.text = @"DONE-1";}
			afterDelay:1];

	[self performBlock:^(void) {self.label.text = @"DONE-2";}
			afterDelay:2];

	[self performBlock:^(void) {self.label.text = @"DONE-3";}
			afterDelay:3];

	[self performBlock:^(void) {self.label.text = @"DONE-4";}
			afterDelay:4];

	NSLog(@"waiting");
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

@end
