//
//  KeyChainsSampeAppDelegate.m
//  KeyChainsSampe
//
//  Created by Hiroshi Hashiguchi on 11/02/02.
//  Copyright 2011 . All rights reserved.
//

#import "KeyChainsSampeAppDelegate.h"
#import "KeyChainsSampeViewController.h"

@implementation KeyChainsSampeAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (void)listAttrStrings
{
	NSLog(@"kSecAttrAccessible: %@", (id)kSecAttrAccessible);
	NSLog(@"kSecAttrCreationDate: %@", (id)kSecAttrCreationDate);
	NSLog(@"kSecAttrModificationDate: %@", (id)kSecAttrModificationDate);
	NSLog(@"kSecAttrDescription: %@", (id)kSecAttrDescription);
	NSLog(@"kSecAttrComment: %@", (id)kSecAttrComment);
	NSLog(@"kSecAttrCreator: %@", (id)kSecAttrCreator);
	NSLog(@"kSecAttrType: %@", (id)kSecAttrType);
	NSLog(@"kSecAttrLabel: %@", (id)kSecAttrLabel);
	NSLog(@"kSecAttrIsInvisible: %@", (id)kSecAttrIsInvisible);
	NSLog(@"kSecAttrIsNegative: %@", (id)kSecAttrIsNegative);
	NSLog(@"kSecAttrAccount: %@", (id)kSecAttrAccount);
	NSLog(@"kSecAttrService: %@", (id)kSecAttrService);
	NSLog(@"kSecAttrGeneric: %@", (id)kSecAttrGeneric);
	NSLog(@"kSecAttrSecurityDomain: %@", (id)kSecAttrSecurityDomain);
	NSLog(@"kSecAttrServer: %@", (id)kSecAttrServer);
	NSLog(@"kSecAttrProtocol: %@", (id)kSecAttrProtocol);
	NSLog(@"kSecAttrAuthenticationType: %@", (id)kSecAttrAuthenticationType);
	NSLog(@"kSecAttrPort: %@", (id)kSecAttrPort);
	NSLog(@"kSecAttrPath: %@", (id)kSecAttrPath);
	NSLog(@"kSecAttrSubject: %@", (id)kSecAttrSubject);
	NSLog(@"kSecAttrIssuer: %@", (id)kSecAttrIssuer);
	NSLog(@"kSecAttrSerialNumber: %@", (id)kSecAttrSerialNumber);
	NSLog(@"kSecAttrSubjectKeyID: %@", (id)kSecAttrSubjectKeyID);
	NSLog(@"kSecAttrPublicKeyHash: %@", (id)kSecAttrPublicKeyHash);
	NSLog(@"kSecAttrCertificateType: %@", (id)kSecAttrCertificateType);
	NSLog(@"kSecAttrCertificateEncoding: %@", (id)kSecAttrCertificateEncoding);
	NSLog(@"kSecAttrKeyClass: %@", (id)kSecAttrKeyClass);
	NSLog(@"kSecAttrApplicationLabel: %@", (id)kSecAttrApplicationLabel);
	NSLog(@"kSecAttrIsPermanent: %@", (id)kSecAttrIsPermanent);
	NSLog(@"kSecAttrApplicationTag: %@", (id)kSecAttrApplicationTag);
	NSLog(@"kSecAttrKeyType: %@", (id)kSecAttrKeyType);
	NSLog(@"kSecAttrKeySizeInBits: %@", (id)kSecAttrKeySizeInBits);
	NSLog(@"kSecAttrEffectiveKeySize: %@", (id)kSecAttrEffectiveKeySize);
	NSLog(@"kSecAttrCanEncrypt: %@", (id)kSecAttrCanEncrypt);
	NSLog(@"kSecAttrCanDecrypt: %@", (id)kSecAttrCanDecrypt);
	NSLog(@"kSecAttrCanDerive: %@", (id)kSecAttrCanDerive);
	NSLog(@"kSecAttrCanSign: %@", (id)kSecAttrCanSign);
	NSLog(@"kSecAttrCanVerify: %@", (id)kSecAttrCanVerify);
	NSLog(@"kSecAttrCanWrap: %@", (id)kSecAttrCanWrap);
	NSLog(@"kSecAttrCanUnwrap: %@", (id)kSecAttrCanUnwrap);
	NSLog(@"kSecAttrAccessGroup: %@", (id)kSecAttrAccessGroup);	
}

- (void)listSecAttrAccessible
{
	NSLog(@"kSecAttrAccessibleAfterFirstUnlock: %@", (id)kSecAttrAccessibleAfterFirstUnlock);
	NSLog(@"kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly: %@", (id)kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly);
	NSLog(@"kSecAttrAccessibleAlways: %@", (id)kSecAttrAccessibleAlways);
	NSLog(@"kSecAttrAccessibleAlwaysThisDeviceOnly: %@", (id)kSecAttrAccessibleAlwaysThisDeviceOnly);
	NSLog(@"kSecAttrAccessibleWhenUnlocked: %@", (id)kSecAttrAccessibleWhenUnlocked);
	NSLog(@"kSecAttrAccessibleWhenUnlockedThisDeviceOnly: %@", (id)kSecAttrAccessibleWhenUnlockedThisDeviceOnly);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

//	[self listAttrStrings];
//	[self listSecAttrAccessible];
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
