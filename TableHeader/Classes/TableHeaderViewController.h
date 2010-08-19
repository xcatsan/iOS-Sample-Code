//
//  TableHeaderViewController.h
//  TableHeader
//
//  Created by Hiroshi Hashiguchi on 10/07/26.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeaderViewController : UIViewController {

	NSArray* array_;
	UIView* headerView_;
	UITableView* tableView_;
	
	BOOL headerOpened_;

	CGFloat spaceCellHeight_;
	UIView* zeroSizeView_;
}

@property (nonatomic, retain) IBOutlet UIView* headerView;
@property (nonatomic, retain) IBOutlet UITableView* tableView;

- (IBAction)changeHeader:(id)sender;
@end

