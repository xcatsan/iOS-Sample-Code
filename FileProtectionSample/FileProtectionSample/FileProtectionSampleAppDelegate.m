//
//  FileProtectionSampleAppDelegate.m
//  FileProtectionSample
//
//  Created by Hiroshi Hashiguchi on 11/04/20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FileProtectionSampleAppDelegate.h"

@implementation FileProtectionSampleAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    // definitions
    NSString* basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager* fileManager = [NSFileManager defaultManager];

    NSString* src1 = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"jpg"];
    NSString* src2 = [[NSBundle mainBundle] pathForResource:@"sample_encrypted" ofType:@"jpg"];

    NSString* dst1 = [basePath stringByAppendingPathComponent:@"sample.jpg"];
    NSString* dst2 = [basePath stringByAppendingPathComponent:@"sample_encrypted.jpg"];
    NSString* dst3 = [basePath stringByAppendingPathComponent:@"sample_encrypted2.jpg"];
    NSString* dst4 = [basePath stringByAppendingPathComponent:@"sample_encrypted3.jpg"];

    NSLog(@"dst1: %@", dst1);
    NSLog(@"dst2: %@", dst2);
    NSLog(@"dst3: %@", dst3);
    NSLog(@"dst4: %@", dst4);
    
    NSError* error = nil;
    
    // cleanup
    if ([fileManager fileExistsAtPath:dst1]) {
        if (![fileManager removeItemAtPath:dst1 error:&error]) {
            NSLog(@"%@", error);
        }
    }
    if ([fileManager fileExistsAtPath:dst2]) {
        if (![fileManager removeItemAtPath:dst2 error:&error]) {
            NSLog(@"%@", error);
        }
    }
    if ([fileManager fileExistsAtPath:dst3]) {
        if (![fileManager removeItemAtPath:dst3 error:&error]) {
            NSLog(@"%@", error);
        }
    }
    if ([fileManager fileExistsAtPath:dst3]) {
        if (![fileManager removeItemAtPath:dst3 error:&error]) {
            NSLog(@"%@", error);
        }
    }

    // copy files
    if (![fileManager copyItemAtPath:src1 toPath:dst1 error:&error]) {
        NSLog(@"%@", error);        
    }
    if (![fileManager copyItemAtPath:src2 toPath:dst2 error:&error]) {
        NSLog(@"%@", error);        
    }

    // set attributes
    NSDictionary* attributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                           forKey:NSFileProtectionKey];
    if (![fileManager setAttributes:attributes
                       ofItemAtPath:dst2
                              error:&error]) {
        NSLog(@"%@", error);
    }
    
    // create dst3
    NSData* data = [NSData dataWithContentsOfFile:src1];
    if (![data writeToFile:dst3
                   options:NSDataWritingFileProtectionComplete
                     error:&error]) {
        NSLog(@"%@", error);
    }

    // copy files
    if (![fileManager copyItemAtPath:dst3 toPath:dst4 error:&error]) {
        NSLog(@"%@", error);        
    }

    NSLog(@"dst1: %@", [fileManager attributesOfItemAtPath:dst1 error:&error]);
    NSLog(@"dst2: %@", [fileManager attributesOfItemAtPath:dst2 error:&error]);
    NSLog(@"dst3: %@", [fileManager attributesOfItemAtPath:dst3 error:&error]);
    NSLog(@"dst4: %@", [fileManager attributesOfItemAtPath:dst4 error:&error]);

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
