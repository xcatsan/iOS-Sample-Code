//
//  HorizontalScrollableUITableViewViewController.h
//  HorizontalScrollableUITableView
//
//  Created by Hiroshi Hashiguchi on 10/10/19.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalScrollableUITableViewViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource> {

	
	UIScrollView* scrollView_;

	NSInteger contentOffsetIndex_;
	NSInteger currentViewIndex_;
	
}
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, assign) NSInteger contentOffsetIndex;
@property (nonatomic, assign) NSInteger currentViewIndex;

- (IBAction)movePrevious:(id)sender;
- (IBAction)moveNext:(id)sender;

@end

