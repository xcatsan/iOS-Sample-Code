//
//  DisplayingExcelFileViewController.m
//  DisplayingExcelFile
//
//  Created by Hiroshi Hashiguchi on 10/12/31.
//  Copyright 2010 . All rights reserved.
//

#import "DisplayingExcelFileViewController.h"

@implementation DisplayingExcelFileViewController

@synthesize webView = webView_;

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

- (IBAction)load:(id)sender
{
	/*
	NSURL* url = [[NSBundle mainBundle] URLForResource:@"sample"
										 withExtension:@"xls"];
	*/
	NSURL* url = [NSURL URLWithString:@"https://github.com/xcatsan/iOS-Sample-Code/raw/master/DisplayingExcelFile/sample.xls"];

	NSURLRequest* req = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReturnCacheDataElseLoad
									 timeoutInterval:10.0];
	
	[self.webView loadRequest:req];
}

- (IBAction)load2:(id)sender
{
	/*
	NSURL* url = [[NSBundle mainBundle] URLForResource:@"sample2"
										 withExtension:@"ppt"];
	*/
	NSURL* url = [NSURL URLWithString:@"https://github.com/xcatsan/iOS-Sample-Code/raw/master/DisplayingExcelFile/sample2.ppt"];
	NSURLRequest* req = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReturnCacheDataElseLoad
									 timeoutInterval:10.0];
	
	[self.webView loadRequest:req];	
}

- (IBAction)load3:(id)sender
{
	/*
	NSURL* url = [[NSBundle mainBundle] URLForResource:@"sample3"
										 withExtension:@"doc"];
	 */
	NSURL* url = [NSURL URLWithString:@"https://github.com/xcatsan/iOS-Sample-Code/raw/master/DisplayingExcelFile/sample3.doc"];
	NSURLRequest* req = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReturnCacheDataElseLoad
									 timeoutInterval:10.0];
	
	[self.webView loadRequest:req];	
	
}

- (IBAction)load4:(id)sender
{
	/*
	NSURL* url = [[NSBundle mainBundle] URLForResource:@"sample4"
										 withExtension:@"rtfd.zip"];
	*/
	NSURL* url = [NSURL URLWithString:@"https://github.com/xcatsan/iOS-Sample-Code/raw/master/DisplayingExcelFile/sample4.rtfd.zip"];
	NSURLRequest* req = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReturnCacheDataElseLoad
									 timeoutInterval:10.0];
	
	[self.webView loadRequest:req];	
	
}
- (IBAction)load5:(id)sender
{
	/*
	NSURL* url = [[NSBundle mainBundle] URLForResource:@"sample"
										 withExtension:@"pdf"];
	*/
	NSURL* url = [NSURL URLWithString:@"https://github.com/xcatsan/iOS-Sample-Code/raw/master/DisplayingExcelFile/sample.pdf"];
	NSURLRequest* req = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReturnCacheDataElseLoad
									 timeoutInterval:10.0];
	
	[self.webView loadRequest:req];	
}

- (IBAction)load6:(id)sender
{
	/*
	NSURL* url = [[NSBundle mainBundle] URLForResource:@"sample"
										 withExtension:@"mov"];
	*/
	NSURL* url = [NSURL URLWithString:@"https://github.com/xcatsan/iOS-Sample-Code/raw/master/DisplayingExcelFile/sample.mov"];
	NSURLRequest* req = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReturnCacheDataElseLoad
									 timeoutInterval:10.0];
	
	[self.webView loadRequest:req];	
	
}

- (IBAction)load7:(id)sender
{
	/*
	NSURL* url = [[NSBundle mainBundle] URLForResource:@"sample"
										 withExtension:@"jpg"];
	*/
	NSURL* url = [NSURL URLWithString:@"https://github.com/xcatsan/iOS-Sample-Code/raw/master/DisplayingExcelFile/sample.jpg"];
	NSURLRequest* req = [NSURLRequest requestWithURL:url
										 cachePolicy:NSURLRequestReturnCacheDataElseLoad
									 timeoutInterval:10000.0];
	
	[self.webView loadRequest:req];	
	
}
- (IBAction)dumpCache:(id)sender
{
	NSURLCache* cache = [NSURLCache sharedURLCache];
	NSLog(@"currentDiskUsage: %d", [cache currentDiskUsage]);
	NSLog(@"diskCapacity: %d", [cache diskCapacity]);
	NSLog(@"currentMemoryUsage: %d", [cache currentMemoryUsage]);
	NSLog(@"memoryCapacity: %d", [cache memoryCapacity]);
}
@end
