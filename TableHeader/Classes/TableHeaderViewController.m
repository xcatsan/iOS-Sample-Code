//
//  TableHeaderViewController.m
//  TableHeader
//
//  Created by Hiroshi Hashiguchi on 10/07/26.
//  Copyright  2010. All rights reserved.
//

#import "TableHeaderViewController.h"

@implementation TableHeaderViewController

@synthesize headerView = headerView_;
@synthesize tableView = tableView_;

-(id)initWithCoder:(NSCoder*)coder
{
	if (self = [super initWithCoder:coder]) {
		array_ = [[NSArray alloc] initWithObjects:
				  @"AAAAA", @"BBBBB", @"CCCCC", @"DDDDD",
				  @"EEEEE", @"FFFFF", @"GGGGG", @"HHHHH",
				  @"IIIII", @"JJJJJ", @"KKKKK", @"LLLLL",
				  nil];
		headerOpened_ = NO;
	}
	return self;
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	CGRect frame = self.headerView.frame;
	frame.size.height = 50.0;
	self.headerView.frame = frame;
	self.tableView.tableHeaderView = self.headerView;
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
	self.headerView = nil;
	self.tableView = nil;
}


- (void)dealloc {
	[array_ release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewDelegate


#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [array_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									   reuseIdentifier:@"CELL"] autorelease];
	}
	
	cell.textLabel.text = [array_ objectAtIndex:indexPath.row];
	return cell;
}


#pragma mark -
#pragma mark Event handling
- (IBAction)changeHeader:(id)sender
{
	CGRect frame = self.headerView.frame;
	if (headerOpened_) {
		frame.size.height = 50.0;
	} else {
		frame.size.height = 100.0;
	}
	[UIView animateWithDuration:0.5
					 animations:^{self.tableView.tableHeaderView.frame = frame;}
					 completion:^(BOOL finished){
						 self.tableView.tableHeaderView = nil;
						 self.tableView.tableHeaderView = self.headerView;
					 }];

	headerOpened_ = !headerOpened_;
	
}

@end
