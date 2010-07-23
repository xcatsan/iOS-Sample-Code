//
//  RootViewController.h
//  FetchedResultsControllerSample
//
//  Created by Hiroshi Hashiguchi on 10/07/24.
//  Copyright Hiroshi Hashiguchi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
	
	NSMutableArray* selectedIndexPahts_;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSMutableArray* selectedIndexPahts;

@end
