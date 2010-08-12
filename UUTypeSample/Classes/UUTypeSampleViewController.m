//
//  UUTypeSampleViewController.m
//  UUTypeSample
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright  2010. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>

#import "UUTypeSampleViewController.h"
#import "UTTypeUtility.h"

@implementation UUTypeSampleViewController

@synthesize mimeType;
@synthesize extension;
@synthesize uti;


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
	
	self.mimeType = nil;
	self.extension = nil;
	self.uti = nil;
	
}


- (void)dealloc {
    [super dealloc];
}

-(IBAction)mimeToExtension:(id)sender
{
	self.uti.text = [UTTypeUtility UTIfromMimeType:self.mimeType.text];
	self.extension.text = [UTTypeUtility filenameExtensionFromMimeType:self.mimeType.text];
}

-(IBAction)extensionToMime:(id)sender
{
	self.uti.text = [UTTypeUtility UTIfromFilename:self.extension.text];
	self.mimeType.text = [UTTypeUtility mimeTypeFromFilename:self.extension.text];
}


@end
