//
//  RootViewController.h
//  SplitViewBaseSample
//
//  Created by Hiroshi Hashiguchi on 11/01/07.
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UITableViewController {
    DetailViewController *detailViewController;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@end
