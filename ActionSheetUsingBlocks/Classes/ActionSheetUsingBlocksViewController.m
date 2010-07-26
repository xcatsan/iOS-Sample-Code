//
//  ActionSheetUsingBlocksViewController.m
//  ActionSheetUsingBlocks
//
//  Created by Hiroshi Hashiguchi on 10/07/26.
//  Copyright  2010. All rights reserved.
//

#import "ActionSheetUsingBlocksViewController.h"
#import "ActionSheetBlocksExtension.h"

@implementation ActionSheetUsingBlocksViewController



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

- (IBAction)openSheet1:(id)sender
{
	ActionSheetBlocksExtension*  sheet = [[ActionSheetBlocksExtension alloc] 
										  initWithTitle:@"Action sheet sample" 
										  didClick:^(UIActionSheet* actionSheet, NSInteger buttonIndex) {
											  NSLog(@"[1] index %d: %@", buttonIndex, actionSheet);
										  }
										  cancelButtonTitle:@"Cancel"
										  destructiveButtonTitle:@"Destructive" 
										  otherButtonTitles:@"Other-11", @"Other-12", @"Other-13", nil];
    [sheet autorelease];	
    [sheet showInView:self.view];
}

- (IBAction)openSheet2:(id)sender
{
	ActionSheetBlocksExtension*  sheet = [[ActionSheetBlocksExtension alloc] 
										  initWithTitle:@"Action sheet sample" 
										  didClick:^(UIActionSheet* actionSheet, NSInteger buttonIndex) {
											  NSLog(@"[2] index %d: %@", buttonIndex, actionSheet);
										  }
										  cancelButtonTitle:@"Cancel"
										  destructiveButtonTitle:@"Destructive" 
										  otherButtonTitles:@"Other-21", @"Other-22", @"Other-23", nil];
    [sheet autorelease];	
    [sheet showInView:self.view];
}

- (IBAction)openSheet3:(id)sender
{
	ActionSheetBlocksExtension*  sheet = [[ActionSheetBlocksExtension alloc] 
										  initWithTitle:@"Action sheet sample" 
										  didClick:^(UIActionSheet* actionSheet, NSInteger buttonIndex) {
											  NSLog(@"[3] index %d: %@", buttonIndex, actionSheet);
										  }
										  cancelButtonTitle:@"Cancel"
										  destructiveButtonTitle:@"Destructive" 
										  otherButtonTitles:@"Other-31", @"Other-32", @"Other-33", nil];
    [sheet autorelease];	
    [sheet showInView:self.view];
}

@end
