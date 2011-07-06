//
//  RootViewController.h
//  CustomCellSample
//
//  Created by Hiroshi Hashiguchi on 11/05/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomCell;
@class HeaderView;
@class FooterView;
@interface RootViewController : UITableViewController {

    CGFloat cellHeight_;
    NSIndexPath* openedIndexPath_;
}
@property (nonatomic, retain) IBOutlet HeaderView* headerView;
@property (nonatomic, retain) IBOutlet FooterView* footerView;
@property (nonatomic, retain) NSIndexPath* openedIndexPath;

// cell events
- (IBAction)didTouchDoitButton:(id)sender event:(UIEvent*)event;

- (IBAction)didTouchDeleteButton:(id)sender event:(UIEvent*)event;
- (IBAction)didTouchPostButton:(id)sender event:(UIEvent*)event;


@end
