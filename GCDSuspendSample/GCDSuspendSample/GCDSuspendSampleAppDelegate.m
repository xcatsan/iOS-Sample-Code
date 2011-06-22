//
//  GCDSuspendSampleAppDelegate.m
//  GCDSuspendSample
//
//  Created by Hiroshi Hashiguchi on 11/05/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GCDSuspendSampleAppDelegate.h"

@implementation GCDSuspendSampleAppDelegate


@synthesize window=_window;
@synthesize countLabel;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    backgroundQueue_ = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    backgroundQueue_ = dispatch_queue_create("backgroundQueue", NULL);
    dispatch_suspend(backgroundQueue_);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
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
    [super dealloc];
}

- (IBAction)addTask:(id)sedner
{
    @synchronized (self) {
        count_++;
        NSLog(@"added task: %d", count_);
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d", count_];
    int c = count_;

    dispatch_async(backgroundQueue_, ^{
        int wait = rand() % 5;

        NSLog(@"processing task: %d (wait: %d)", c, wait);
        
        [NSThread sleepForTimeInterval:wait];
        
        @synchronized (self) {
            count_--;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.countLabel.text = [NSString stringWithFormat:@"%d", count_];
        });
    });
}

- (IBAction)executeBlock:(id)sender
{
    dispatch_resume(backgroundQueue_);
}


@end
