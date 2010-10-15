//
//  AutoreleasePoolTestAppDelegate.m
//  AutoreleasePoolTest
//
//  Created by Hiroshi Hashiguchi on 10/10/15.
//  Copyright 2010 . All rights reserved.
//

#import "AutoreleasePoolTestAppDelegate.h"
#import "AutoreleasePoolTestViewController.h"
#include <mach/mach.h>


@implementation AutoreleasePoolTestAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

#define BUFF_SIZE	(1024*1024)
static char buff[BUFF_SIZE];

//#define USE_POOL
//#define USE_DRAIN
#define USE_CACHE


- (u_int)currentRegidentSize
{
	struct task_basic_info t_info;
	mach_msg_type_number_t t_info_count = TASK_BASIC_INFO_COUNT;
	
	if (task_info(current_task(), TASK_BASIC_INFO,
				  (task_info_t)&t_info, &t_info_count)!= KERN_SUCCESS) {
		NSLog(@"%s(): Error in task_info(): %s",
			  __FUNCTION__, strerror(errno));
	}
	
	u_int rss = t_info.resident_size;		
	
	return rss;
}

- (void)test
{
    // Override point for customization after application launch.
	for (int i=0; i < 100; i++) {
		
#ifdef USE_POOL
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
#endif
		[NSData dataWithBytes:buff length:BUFF_SIZE];
		u_int rss = [self currentRegidentSize];
		NSLog(@"RSS: %0.1f MB", rss/1024.0/1024.0);
		
#ifdef USE_POOL
#ifdef USE_DRAIN
		[pool drain];
#else
		[pool release];
#endif
#endif
	}
	NSLog(@"end");
//	NSLog(@"%@", [NSAutoreleasePool showPools]);
}

- (void)test2
{	
	u_int prev_rss = [self currentRegidentSize];
	for (int i=1; i <= 16; i++) {
		
		NSString* filename = [NSString stringWithFormat:@"image%02d.jpg", i];


#ifdef USE_POOL
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
#endif
		
#ifdef USE_CACHE
		[UIImage imageNamed:filename];
#else
		NSString* filepath = [NSString stringWithFormat:@"%@/%@",
					[[NSBundle mainBundle] resourcePath], filename];
		UIImage* image = [UIImage imageWithContentsOfFile:filepath];
		
#endif
		
#ifdef USE_POOL
#ifdef USE_DRAIN
		[pool drain];
#else
		[pool release];
#endif
#endif
		u_int rss = [self currentRegidentSize];
		NSLog(@"%@ | RSS: %0.1f KB => %0.1f KB [%+0.1fKB]", filename, prev_rss/1024.0,rss/1024.0, (int)(rss-prev_rss)/1024.0);
		prev_rss = rss;
	}
	NSLog(@"end");
	//	NSLog(@"%@", [NSAutoreleasePool showPools]);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	[self test2];

    // Add the view controller's view to the window and display.
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

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


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
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
    [viewController release];
    [window release];
    [super dealloc];
}


@end
