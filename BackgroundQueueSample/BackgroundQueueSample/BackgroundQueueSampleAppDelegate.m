//
//  BackgroundQueueSampleAppDelegate.m
//  BackgroundQueueSample
//
//  Created by Hiroshi Hashiguchi on 11/04/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BackgroundQueueSampleAppDelegate.h"
#import "RootViewController.h"
#import "Queue.h"

@implementation BackgroundQueueSampleAppDelegate

@synthesize rootViewController;
@synthesize window=_window;

@synthesize navigationController=_navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    Queue* queue = [[Queue alloc] init];
    for (int i=0; i < 60; i++) {
        NSString* str = [NSString stringWithFormat:@"DATA-%02d", i];
        [queue putObject:str];
    }
    self.rootViewController.queue = queue;
    [queue release];
    
    

    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    // start consumer
    dispatch_queue_t gcd_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(gcd_queue, ^{
        
        UIApplication* app = [UIApplication sharedApplication];
        app.applicationIconBadgeNumber = [queue count];
        for(;;) {
            if ([queue count] > 0) {
                id object = [queue getObject];
                NSLog(@"processing: %@", object);
                [NSThread sleepForTimeInterval:1.0];    // dummy wait
                NSLog(@"done: %@", object);
                [queue removeObject];
                app.applicationIconBadgeNumber = [queue count];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.rootViewController.tableView reloadData];
                });
                
                if ([queue count] == 0 && backgroundTaskIdentifer != UIBackgroundTaskInvalid) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"finished!");
                        if (backgroundTaskIdentifer != UIBackgroundTaskInvalid) {
                            [app endBackgroundTask:backgroundTaskIdentifer];
                            backgroundTaskIdentifer = UIBackgroundTaskInvalid;
                        }
                    });
                }
            } else {
                NSLog(@"sleeping....");
                [NSThread sleepForTimeInterval:1.0];
            }
        }
        
    });
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    UIApplication* app = [UIApplication sharedApplication];
    
    NSAssert(backgroundTaskIdentifer == UIBackgroundTaskInvalid, nil);
    
    backgroundTaskIdentifer = [app beginBackgroundTaskWithExpirationHandler:^{
        
        NSLog(@"expired!");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (backgroundTaskIdentifer != UIBackgroundTaskInvalid) {
                [app endBackgroundTask:backgroundTaskIdentifer];
                backgroundTaskIdentifer = UIBackgroundTaskInvalid;
            }
        });
    }];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    UIApplication* app = [UIApplication sharedApplication];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (backgroundTaskIdentifer != UIBackgroundTaskInvalid) {
            [app endBackgroundTask:backgroundTaskIdentifer];
            backgroundTaskIdentifer = UIBackgroundTaskInvalid;
        }
    });    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
