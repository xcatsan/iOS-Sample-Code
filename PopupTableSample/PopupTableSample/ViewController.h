//
//  ViewController.h
//  PopupTableSample
//
//  Created by Hiroshi Hashiguchi on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LKPopupMenuController;
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet LKPopupMenuController* popupMenuController;
@end
