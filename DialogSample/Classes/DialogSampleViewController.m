//
//  DialogSampleViewController.m
//  DialogSample
//
//  Created by Hiroshi Hashiguchi on 10/07/23.
//  Copyright Hiroshi Hashiguchi 2010. All rights reserved.
//

#import "DialogSampleViewController.h"
#import "CustomDialogViewController.h"
#import "UIViewController_Extension.h"

@implementation DialogSampleViewController
@synthesize dialogViewController;
@synthesize button;

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
	
	CustomDialogViewController* controller =
		[[CustomDialogViewController alloc] init];
	
	controller.delegate = self;
	controller.buttonTitle = @"close dilaog";
	controller.labelText = @"Custom Dialog Opened!";
	
	self.dialogViewController = controller;
	
	[controller release];
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
	self.dialogViewController = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Event handling
- (IBAction)openDialog:(id)sender
{
	
	if (opened) {
		[self.dialogViewController setEnabled:NO];
		[self dismissDialogViewController:self.dialogViewController
								 animated:YES];
	} else {
		[self presentDialogViewController:self.dialogViewController
								 animated:YES];
	}
	opened = !opened;
}


#pragma mark -
#pragma mark CustomDialogDelegate
-(void)touchedButton:(id)sender
{
	UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Message"
													 message:@"Touched dialog button"
													delegate:nil
										   cancelButtonTitle:nil
										   otherButtonTitles:@"OK", nil] autorelease];
	[alert show];
}

- (IBAction)openLabel:(id)sender
{
	[self.dialogViewController setEnabled:YES];
}


@end
