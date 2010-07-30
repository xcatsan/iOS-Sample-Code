//
//  SubViewController.h
//  NSFetchedResultControllerDelegateSample
//

#import <UIKit/UIKit.h>


@interface SubViewController : UIViewController {

    NSManagedObject* object;
    NSManagedObjectContext* context;
    IBOutlet UILabel* label;
}

@property (nonatomic, retain) NSManagedObject* object;
@property (nonatomic, retain) NSManagedObjectContext* context;

-(IBAction)delete:(id)sender;
-(IBAction)back:(id)sender;

@end
