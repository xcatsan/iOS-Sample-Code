//
//  NSTimerBlocksViewController.m
//  NSTimerBlocks
//
//  Created by Hiroshi Hashiguchi on 10/08/05.
//  Copyright  2010. All rights reserved.
//

#import "NSTimerBlocksViewController.h"
#import "NSTimer_Extension.h"

@implementation NSTimerBlocksViewController

@synthesize counterLabel1;
@synthesize counterLabel2;
@synthesize counterLabel3;

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
	
	NSArray* array = [NSArray arrayWithObjects:@"DOG", @"CAT", @"MONKEY", nil];

	timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0
			   block:^(NSTimer* timer) {
				   self.counterLabel1.text =
					[NSString stringWithFormat:@"%d", counter1++];
				   NSLog(@"%@", array);
			   }
			 repeats:YES];

	timer2 = [NSTimer scheduledTimerWithTimeInterval:2.0
			   block:^(NSTimer* timer) {
				   self.counterLabel2.text =
					[NSString stringWithFormat:@"%d", counter2];
				   counter2 += 10;
				   NSLog(@"%@", array);
			   }
			 repeats:YES];

	timer3 = [NSTimer scheduledTimerWithTimeInterval:3.0
			   block:^(NSTimer* timer) {
				   self.counterLabel3.text =
					[NSString stringWithFormat:@"%d", counter3];
				   counter3 += 100;
				   NSLog(@"%@", array);
			   }
			 repeats:YES];

	/* old version
	timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0
		  block:^(NSTimer* timer, id userInfo) {
			  self.counterLabel1.text =
				[NSString stringWithFormat:@"%d", counter1++];
		  }
		userInfo:nil
		repeats:YES];

	timer2 = [NSTimer scheduledTimerWithTimeInterval:2.0
		  block:^(NSTimer* timer, id userInfo) {
			  self.counterLabel2.text =
			  [NSString stringWithFormat:@"%d", counter2];
			  counter2 += 10;
		  }
	   userInfo:nil
		repeats:YES];

	timer3 = [NSTimer scheduledTimerWithTimeInterval:3.0
		  block:^(NSTimer* timer, id userInfo) {
			  self.counterLabel3.text =
			  [NSString stringWithFormat:@"%d", counter3];
			  counter3 += 100;
		  }
	   userInfo:nil
		repeats:YES];
	 */
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
	self.counterLabel1 = nil;
	self.counterLabel2 = nil;
	self.counterLabel3 = nil;
}


- (void)dealloc {
    [super dealloc];
}

-(IBAction)stopTimer:(id)sender
{
	[timer1 invalidate];
	[timer2 invalidate];
	[timer3 invalidate];
}

@end
