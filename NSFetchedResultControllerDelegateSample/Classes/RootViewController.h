//
//  RootViewController.h
//  NSFetchedResultControllerDelegateSample
//


#import <CoreData/CoreData.h>

//@interface RootViewController : UIViewController <NSFetchedResultsControllerDelegate> {
@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

//    UITableView* tableView_;
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

//@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

