//
//  RootViewController.m
//  CustomCellSample
//
//  Created by Hiroshi Hashiguchi on 11/05/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "CustomCell.h"
#import "HeaderView.h"
#import "FooterView.h"

#define CUSTOM_CELL_NIB @"CustomCell"

@implementation RootViewController
@synthesize headerView;
@synthesize footerView;
@synthesize openedIndexPath;


- (void)_setHeaderViewHidden:(BOOL)hidden animated:(BOOL)animated
{
    CGFloat topOffset = 0.0;
    if (hidden) {
        topOffset = -self.headerView.frame.size.height;
    }
    if (animated) {
        [UIView animateWithDuration:0.2
                         animations:^{
                                self.tableView.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);
                         }];
    } else {
        self.tableView.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);        
    }
}



- (void)_releaseOutlets
{
    self.headerView = nil;
    self.footerView = nil;
}

- (void)dealloc {
    [self _releaseOutlets];
    self.openedIndexPath = nil;
    [super dealloc];
}
- (void)viewDidUnload
{
    [self _releaseOutlets];
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    self.title = @"Custom Cell Sample";
    
    // calc height of custom cell
    UINib* nib = [UINib nibWithNibName:CUSTOM_CELL_NIB bundle:nil];
    NSArray* array = [nib instantiateWithOwner:nil options:nil];
    CustomCell* cell = [array objectAtIndex:0];
    cellHeight_ = cell.frame.size.height;
    [super viewDidLoad];
    
    UISwipeGestureRecognizer* swipeGesture =
        [[UISwipeGestureRecognizer alloc]
         initWithTarget:self action:@selector(didSwipeCell:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;  
    [self.tableView addGestureRecognizer:swipeGesture];  
    [swipeGesture release];

    swipeGesture =
        [[UISwipeGestureRecognizer alloc]
            initWithTarget:self action:@selector(didSwipeCell:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;  
    [self.tableView addGestureRecognizer:swipeGesture];  
    [swipeGesture release];

    self.tableView.separatorColor = [UIColor lightGrayColor];

    self.tableView.tableHeaderView = self.headerView;
    [self _setHeaderViewHidden:YES animated:NO];
    self.tableView.tableFooterView = self.footerView;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.openedIndexPath = nil; // close all cells
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell* cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:CUSTOM_CELL_NIB];
    if (cell == nil) {
        UINib* nib = [UINib nibWithNibName:CUSTOM_CELL_NIB bundle:nil];
        NSArray* array = [nib instantiateWithOwner:self options:nil];
        cell = [array objectAtIndex:0];
    }

    // Configure the cell.
    int r = rand();
    cell.nameLabel.text = [NSString stringWithFormat:@"NAME-%d", r];
    cell.dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:r] description];
    cell.descLabel.text = @"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files ....";
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%02ds.jpg", (r%8)+1]];
//    NSLog(@"%@", [NSString stringWithFormat:@"image%02ds.jpg", (r%8)+1]);
    
    if ([self.openedIndexPath isEqual:indexPath]) {
        [cell setSlideOpened:YES animated:NO];
    } else {
        [cell setSlideOpened:NO animated:NO];
    }

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight_;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s|%@", __PRETTY_FUNCTION__, indexPath);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark Event handler
- (void)didSwipeCell:(UISwipeGestureRecognizer*)swipeRecognizer
{
    CGPoint loc = [swipeRecognizer locationInView:self.tableView];
    NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:loc];
    CustomCell* cell = (CustomCell*)[self.tableView cellForRowAtIndexPath:indexPath];

    if ([self.openedIndexPath isEqual:indexPath]) {
        if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
            // close cell
            [cell setSlideOpened:NO animated:YES];
            self.openedIndexPath = nil;
        }
    } else if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.openedIndexPath) {
            // close previous opened cell
            NSArray* visibleIndexPaths = [self.tableView indexPathsForVisibleRows];
            if ([visibleIndexPaths containsObject:self.openedIndexPath]) {
                CustomCell* openedCell = (CustomCell*)[self.tableView cellForRowAtIndexPath:self.openedIndexPath];
                [openedCell setSlideOpened:NO animated:YES];
            }
        }
        // open new cell
        [cell setSlideOpened:YES animated:YES];
        self.openedIndexPath = indexPath;
    }
         
}

- (NSIndexPath*)_indexPathForEvent:(UIEvent*)event
{
    UITouch* touch = [[event allTouches] anyObject];
    CGPoint p = [touch locationInView:self.tableView];
    return [self.tableView indexPathForRowAtPoint:p];
}

- (IBAction)didTouchDoitButton:(id)sender event:(UIEvent*)event
{
    NSIndexPath* indexPath = [self _indexPathForEvent:event];
    NSLog(@"%s|%@", __PRETTY_FUNCTION__, indexPath);
}

- (IBAction)didTouchDeleteButton:(id)sender event:(UIEvent*)event
{
    NSIndexPath* indexPath = [self _indexPathForEvent:event];
    NSLog(@"%s|%@", __PRETTY_FUNCTION__, indexPath);
}

- (IBAction)didTouchPostButton:(id)sender event:(UIEvent*)event
{
    NSIndexPath* indexPath = [self _indexPathForEvent:event];
    NSLog(@"%s|%@", __PRETTY_FUNCTION__, indexPath);
}


#pragma mark -
#pragma mark UIScrollViewDelegate

#define PULLDOWN_MARGIN -15.0f

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.headerView.state == HeaderViewStateStopping) {
        return;
    }

    CGFloat threshold = self.headerView.frame.size.height;

    if (PULLDOWN_MARGIN <= scrollView.contentOffset.y &&
        scrollView.contentOffset.y < threshold) {
        self.headerView.state = HeaderViewStatePullingDown;

    } else if (scrollView.contentOffset.y < PULLDOWN_MARGIN) {
        self.headerView.state = HeaderViewStateOveredThreshold;
        
    } else {
        self.headerView.state = HeaderViewStateHidden;
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    if (self.tableView.contentOffset.y < PULLDOWN_MARGIN) {
    if (self.headerView.state == HeaderViewStateOveredThreshold) {
        self.headerView.state = HeaderViewStateStopping;
        [self _setHeaderViewHidden:NO animated:YES];
        
        [self performSelector:@selector(_taskFinished) withObject:nil afterDelay:2.0];
    }
}

- (void)_taskFinished
{
    self.headerView.state = HeaderViewStateHidden;
    [self.headerView setUpdatedDate:[NSDate date]];
    [self _setHeaderViewHidden:YES animated:YES];
}


@end
