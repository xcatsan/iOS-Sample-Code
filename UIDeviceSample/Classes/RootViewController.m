//
//  RootViewController.m
//  UIDeviceSample
//
//  Created by Hiroshi Hashiguchi on 10/09/12.
//  Copyright Hiroshi Hashiguchi 2010. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"UIDevice Properties";
	
	UIDevice* device = [UIDevice currentDevice];
	device.batteryMonitoringEnabled = YES;
	
	tasks = [[NSArray alloc] initWithObjects:
			 @"Determining the Available Features",
			 @"Identifying the Device and Operating System",
			 @"Getting the Device Orientation",
			 @"Getting the Device Battery State",
			 @"Using the Proximity Sensor",
			 nil
			 ];	

	properties = [[NSArray alloc] initWithObjects:
				  [NSArray arrayWithObjects:
				   @"multitaskingSupported",
				   nil],
				  
				  [NSArray arrayWithObjects:
				   @"uniqueIdentifier",
				   @"name",
				   @"systemName",
				   @"systemVersion",
				   @"model",
				   @"localizedModel",
				   @"userInterfaceIdiom",
				   nil],
				  
				  [NSArray arrayWithObjects:
				   @"orientation",
				   @"isGeneratingDeviceOrientationNotifications",
				   nil],
				  
				  [NSArray arrayWithObjects:
				   @"batteryLevel",
				   @"batteryMonitoringEnabled",
				   @"batteryState",
				   nil],
				  
				  [NSArray arrayWithObjects:
				   @"proximityMonitoringEnabled",
				   @"proximityState",
				   nil],

				  nil];
	
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [tasks count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[properties objectAtIndex:section] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.adjustsFontSizeToFitWidth = YES;
		CGRect rect = cell.frame;
		cell.frame = rect;
    }

    NSArray* props = [properties objectAtIndex:indexPath.section];
	NSString* key = [props objectAtIndex:indexPath.row];
	id value = [[UIDevice currentDevice] valueForKey:key];
	
	cell.textLabel.text = key;
	cell.detailTextLabel.text = [value description];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [tasks objectAtIndex:section];
}

@end

