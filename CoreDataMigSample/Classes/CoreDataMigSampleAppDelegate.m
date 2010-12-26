//
//  CoreDataMigSampleAppDelegate.m
//  CoreDataMigSample
//
//  Created by Hiroshi Hashiguchi on 10/12/10.
//  Copyright 2010 . All rights reserved.
//

#import "CoreDataMigSampleAppDelegate.h"
#import "RootViewController.h"


@implementation CoreDataMigSampleAppDelegate

@synthesize window;
@synthesize navigationController;

#define SAMPLE_DATA_NUM		10000

#pragma mark -
#pragma mark Show migration status
#define kProgressViewKey		@"ProgressViewKey"
#define kMigrationManagerKey	@"MigrationManagerKey"

- (void)updateInformation:(NSTimer*)timer
{
	NSDictionary* userInfo = [timer userInfo];
	UIProgressView* progressView = [userInfo objectForKey:kProgressViewKey];
	NSMigrationManager* manager = [userInfo objectForKey:kMigrationManagerKey];
	
	progressView.progress = [manager migrationProgress];
}

- (void)startMigrationWithMigrationManager:(NSMigrationManager*)manager
{
	alertView_ = [[UIAlertView alloc] initWithTitle:@"Migration"
											message: @"now migrating..."
										   delegate: self
								  cancelButtonTitle: nil
								  otherButtonTitles: nil];
	
	UIProgressView* progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(30.0f, 80.0f, 225.0f, 90.0f)];
	[alertView_ addSubview:progressView];
	[progressView setProgressViewStyle: UIProgressViewStyleBar];
	[progressView release];
	
	[alertView_ show];
	[alertView_ release];
	
	NSDictionary* userInfo =
	[NSDictionary dictionaryWithObjectsAndKeys:
	 progressView	, kProgressViewKey,
	 manager		, kMigrationManagerKey,
	 nil];
	
	timer_ = [NSTimer scheduledTimerWithTimeInterval:0.1f
											  target:self
											selector:@selector(updateInformation:)
											userInfo:userInfo
											 repeats:YES];
	
	
}

#pragma mark -
#pragma mark Application lifecycle

- (void)awakeFromNib {    
    
    RootViewController *rootViewController = (RootViewController *)[navigationController topViewController];
    rootViewController.managedObjectContext = self.managedObjectContext;
}


- (NSUInteger)countForEntityName:(NSString*)entitylName
{
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:entitylName
								   inManagedObjectContext:managedObjectContext_]];
	[request setIncludesSubentities:NO];
	
	NSError* error = nil;
	NSUInteger count =
		[managedObjectContext_ countForFetchRequest:request error:&error];
	if (count == NSNotFound) {
		count = 0;
	}
	[request release];
	
	return count;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	
	
	
	// insert sample data
	NSInteger count = [self countForEntityName:@"Event"];
	if (count == 0) {
		
		int i;
		NSError* error = nil;
		NSDate* date = [NSDate date];
		
		for (i=0; i < SAMPLE_DATA_NUM; i++) {
			
			NSManagedObject* object = [NSEntityDescription insertNewObjectForEntityForName:@"Event"
																	inManagedObjectContext:managedObjectContext_];
			[object setValue:date forKey:@"timeStamp"];
			
			if ((i+1) % 20 == 0) {
				[managedObjectContext_ save:&error];
				NSLog(@"commit: %d", i+1);
			}
		}
		[managedObjectContext_ save:&error];
	} else {
		
		NSLog(@"not added");
	}

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [self saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


- (void)saveContext {
    
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"CoreDataMigSample" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataMigSample.sqlite"];
    
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];

    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
    [navigationController release];
    [window release];
    [super dealloc];
}


@end

