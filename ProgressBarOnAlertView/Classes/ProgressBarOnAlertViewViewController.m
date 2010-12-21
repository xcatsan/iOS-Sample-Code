//
//  ProgressBarOnAlertViewViewController.m
//  ProgressBarOnAlertView
//
//  Created by Hiroshi Hashiguchi on 10/12/21.
//  Copyright 2010 . All rights reserved.
//

#import "ProgressBarOnAlertViewViewController.h"

@implementation ProgressBarOnAlertViewViewController


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


#define kProgressViewKey	@"ProgressViewKey"
#define kAlertViewKey		@"AlertViewKey"

static float progressValue = 0.0f; 

- (IBAction)start:(id)sender
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Information"
															message: @"Please wait..."
														   delegate: self
												  cancelButtonTitle: nil
												  otherButtonTitles: nil];
	
	UIProgressView* progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(30.0f, 80.0f, 225.0f, 90.0f)];
	[alertView addSubview:progressView];
	[progressView setProgressViewStyle: UIProgressViewStyleBar];
	[progressView release];

	[alertView show];
	[alertView release];
	
	progressValue = 0.0f;
	
	NSDictionary* userInfo =
	[NSDictionary dictionaryWithObjectsAndKeys:
	 progressView	, kProgressViewKey,
	 alertView		, kAlertViewKey,
	 nil];

	[NSTimer scheduledTimerWithTimeInterval:0.1f
									 target:self
								   selector:@selector(updateInformation:)
								   userInfo:userInfo
									repeats:YES];
}

- (void)updateInformation:(NSTimer*)timer
{
	NSDictionary* userInfo = [timer userInfo];
	UIProgressView* progressView = [userInfo objectForKey:kProgressViewKey];

	if (progressValue >= 1.0f) {
		[timer invalidate];
		NSLog(@"finished");
		UIAlertView* alertView = [userInfo objectForKey:kAlertViewKey];
		[alertView dismissWithClickedButtonIndex:0
										animated:YES];
		return;
	}
	progressValue += 0.01f;
	progressView.progress = progressValue;
	NSLog(@"value=%f", progressValue);
}
@end
