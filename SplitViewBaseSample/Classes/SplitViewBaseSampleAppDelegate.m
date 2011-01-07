//
//  SplitViewBaseSampleAppDelegate.m
//  SplitViewBaseSample
//
//  Created by Hiroshi Hashiguchi on 11/01/07.
//  Copyright 2011 . All rights reserved.
//

#import "SplitViewBaseSampleAppDelegate.h"


#import "RootViewController.h"
#import "DetailViewController.h"


@implementation SplitViewBaseSampleAppDelegate

@synthesize window, splitViewController, rootViewController, detailViewController;


#pragma mark -
#pragma mark Application lifecycle

- (void)displayHierarchyOfView:(UIView*)view level:(NSUInteger)level
{
	NSMutableString* spaces = [NSMutableString string];
	int i;
	for (i=0; i < level; i++) {
		[spaces appendString:@"  "];
	}
	if (level) {
		[spaces appendString:@"|-"];
	}
	for (UIView* subView in view.subviews) {
		NSLog(@"%@%@", spaces, [subView class]);
		[self displayHierarchyOfView:subView level:level+1];
	}
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch.
    
    // Add the split view controller's view to the window and display.
    [self.window addSubview:splitViewController.view];
    [self.window makeKeyAndVisible];
	
	NSLog(@"%@", splitViewController.viewControllers);
	[self displayHierarchyOfView:splitViewController.view level:0];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [splitViewController release];
    [window release];
    [super dealloc];
}


@end

