//
//  LargestManagedObjectAppDelegate.h
//  LargestManagedObject
//


#import <UIKit/UIKit.h>

@interface LargestManagedObjectAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;

    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;


@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@end

