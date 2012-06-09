//
//  ViewController.m
//  PopupTableSample
//
//  Created by Hiroshi Hashiguchi on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "LKPopupMenuController.h"

@interface ViewController ()

@end

#define CELL_NUM    100

@implementation ViewController
@synthesize tableView = tableView_;
@synthesize popupMenuController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.popupMenuController = [LKPopupMenuController popupMenuControllerOnView:self.tableView];
    self.popupMenuController = [LKPopupMenuController popupMenuControllerOnView:self.view];
    self.popupMenuController.textList = [NSArray arrayWithObjects:
                                         @"menu1", @"menu2", @"menu3", @"menu4", @"menu5", nil];
    self.popupMenuController.arrangementMode = LKPopupMenuControllerArrangementModeLeft;
}

- (void)viewDidUnload
{
    self.tableView = nil;
    self.popupMenuController = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc {
    self.tableView = nil;
    self.popupMenuController = nil;
    [super dealloc];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return CELL_NUM;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"cell %02d", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
    

    [tableView scrollRectToVisible:rect animated:YES];

    CGPoint p = [self.view convertPoint:rect.origin fromView:tableView];
    p.x = 300.0;
    p.y = p.y + rect.size.height/2.0;

    CGFloat margin = rect.size.height/4.0;

    if (p.y <= rect.size.height/2.0) {
        p.y = rect.size.height/2.0 + margin;
    }
    if (p.y >= self.view.bounds.size.height - rect.size.height/2.0) {
        p.y = self.view.bounds.size.height - rect.size.height/2.0 - margin;
    }
    
    [self.popupMenuController presentPopupMenuFromLocation:p];
}

@end
