//
//  FileManagerDateSampleAppDelegate.m
//  FileManagerDateSample
//
//  Created by Hiroshi Hashiguchi on 11/04/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FileManagerDateSampleAppDelegate.h"

@implementation FileManagerDateSampleAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
   
    NSString* path = @"/tmp/test.dat";
    NSData* data = [NSData data];
    [data writeToFile:path atomically:YES];
    
    NSError* error = nil;

    NSCalendar *gregorian =
        [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents* c = [[[NSDateComponents alloc] init] autorelease];
    [c setYear:2009];
    [c setMonth:10];
    [c setDay:1];
    [c setHour:12];
    [c setMonth:5];
    [c setSecond:1];
    
    NSDate* modified = [gregorian dateFromComponents:c];

    NSLog(@"update to: %@", modified);
    [[NSFileManager defaultManager] setAttributes:
        [NSDictionary dictionaryWithObject:modified forKey:NSFileModificationDate]
                                     ofItemAtPath:path
                                            error:&error];

    NSDictionary* attr = [[NSFileManager defaultManager]
                          attributesOfItemAtPath:path error:&error];
    modified = [attr objectForKey:NSFileModificationDate];
    NSLog(@"updated: %@", modified);

    
    NSDateComponents* components = [gregorian components:
                            NSYearCalendarUnit  |
                            NSMonthCalendarUnit |
                            NSDayCalendarUnit   |
                            NSHourCalendarUnit  |
                            NSMinuteCalendarUnit|
                            NSSecondCalendarUnit
                 fromDate:modified];
    NSLog(@"modified2's components: %d-%02d-%02d %02d:%02d:%02d",
          [components year],
          [components month],
          [components day],
          [components hour],
          [components minute],
          [components second]);

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

@end
