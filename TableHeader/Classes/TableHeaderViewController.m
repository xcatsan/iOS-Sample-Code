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
		zeroSizeView_ = [[UIView alloc] initWithFrame:CGRectZero];
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
	[zeroSizeView_ release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		return spaceCellHeight_;
	} else {
		return tableView.rowHeight;
	}
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 1;
	} else {
		return [array_ count];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		return zeroSizeView_;
	} else {
		return nil;
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	if (section == 0) {
		return zeroSizeView_;
	} else {
		return nil;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		return 0.1;
	} else {
		return tableView.sectionHeaderHeight;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	if (section == 0) {
		return 0.1;
	} else {
		return tableView.sectionFooterHeight;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CELL1"];
		
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
										   reuseIdentifier:@"CELL1"] autorelease];
			UIView* view = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
			cell.backgroundView = view;
		}
		return cell;

	} else {
		UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CELL2"];
		
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
										   reuseIdentifier:@"CELL2"] autorelease];
		}
		
		cell.textLabel.text = [array_ objectAtIndex:indexPath.row];
		return cell;
	}
}


#pragma mark -
#pragma mark Event handling
- (IBAction)changeHeader:(id)sender
{
	CGRect frame = self.headerView.frame;

	if (headerOpened_) {
		frame.size.height = 50.0;
		spaceCellHeight_ = 0.0;
	} else {
		frame.size.height = 100.0;
		spaceCellHeight_ = 50.0;
	}
	NSIndexPath* path = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path]
						  withRowAnimation:YES];
	[UIView animateWithDuration:0.25
					 animations:^{
						 self.tableView.tableHeaderView.frame = frame;
					 }
					 completion:^(BOOL finished){
//						 self.tableView.tableHeaderView = nil;
//						 self.tableView.tableHeaderView = self.headerView;
					 }];

	headerOpened_ = !headerOpened_;
	
}

@end
