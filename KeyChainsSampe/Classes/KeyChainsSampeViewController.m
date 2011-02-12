//
//  KeyChainsSampeViewController.m
//  KeyChainsSampe
//
//  Created by Hiroshi Hashiguchi on 11/02/02.
//  Copyright 2011 . All rights reserved.
//

#import <Security/Security.h>


#import "KeyChainsSampeViewController.h"

#define SERVICE_NAME	@"SampleService"
#define IDENTIFIER		@"password"

@implementation KeyChainsSampeViewController

@synthesize loginId = loginId_;
@synthesize password = password_;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.loginId = nil;
	self.password = nil;
}


- (void)dealloc {
	self.loginId = nil;
	self.password = nil;
    [super dealloc];
}


- (IBAction)getPassword:(id)sender
{
	NSMutableDictionary* query = [NSMutableDictionary dictionary];
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:(id)self.loginId.text forKey:(id)kSecAttrAccount];
	[query setObject:SERVICE_NAME forKey:(id)kSecAttrService];
	[query setObject:[IDENTIFIER dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecAttrGeneric];
	[query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
	
	NSData* passwordData = nil;
	OSStatus err = SecItemCopyMatching((CFDictionaryRef)query,
									   (CFTypeRef*)&passwordData);
	
	if (err == noErr) {
		NSLog(@"SecItemCopyMatching: noErr");
		self.password.text = [[[NSString alloc] initWithData:passwordData
								encoding:NSUTF8StringEncoding] autorelease];
	} else if(err = errSecItemNotFound) {
		NSLog(@"SecItemCopyMatching: errSecItemNotFound");
	} else {
		NSLog(@"SecItemCopyMatching: error(%d)", err);
	}

}


- (IBAction)update:(id)sender
{
	NSMutableDictionary* attributes = nil;
	NSMutableDictionary* query = [NSMutableDictionary dictionary];
	NSData* passwordData = [self.password.text dataUsingEncoding:NSUTF8StringEncoding];
	
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:(id)self.loginId.text forKey:(id)kSecAttrAccount];
	[query setObject:SERVICE_NAME forKey:(id)kSecAttrService];
	[query setObject:[IDENTIFIER dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecAttrGeneric];

	OSStatus err = SecItemCopyMatching((CFDictionaryRef)query, NULL);
	
	if (err == noErr) {
		// update item
		NSLog(@"SecItemCopyMatching: noErr");

		attributes = [NSMutableDictionary dictionary];
		[attributes setObject:passwordData forKey:(id)kSecValueData];
		[attributes setObject:[NSDate date] forKey:(id)kSecAttrModificationDate];

		err = SecItemUpdate((CFDictionaryRef)query, (CFDictionaryRef)attributes);
		if (err == noErr) {
			NSLog(@"SecItemUpdate: noErr");
		} else {
			NSLog(@"SecItemUpdate: error(%d)", err);
		}
		
	} else if (err = errSecItemNotFound) {
		// add new item
		NSLog(@"SecItemCopyMatching: errSecItemNotFound");
		
		attributes = [NSMutableDictionary dictionary];
		[attributes setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
		[attributes setObject:(id)self.loginId.text forKey:(id)kSecAttrAccount];
		[attributes setObject:passwordData forKey:(id)kSecValueData];
		[attributes setObject:SERVICE_NAME forKey:(id)kSecAttrService];
		[attributes setObject:[IDENTIFIER dataUsingEncoding:NSUTF8StringEncoding] forKey:(id)kSecAttrGeneric];
		[attributes setObject:[NSDate date] forKey:(id)kSecAttrCreationDate];
		[attributes setObject:[NSDate date] forKey:(id)kSecAttrModificationDate];
		[attributes setObject:@"This is a password" forKey:(id)kSecAttrDescription];
		err = SecItemAdd((CFDictionaryRef)attributes, NULL);
		if (err == noErr) {
			NSLog(@"SecItemAdd: noErr");
		} else {
			NSLog(@"SecItemAdd: error(%d)", err);
		}
		
	} else {
		NSLog(@"SecItemCopyMatching: error(%d)", err);
	}
}

- (IBAction)delete:(id)sender
{
	NSMutableDictionary* query = [NSMutableDictionary dictionary];
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:(id)self.loginId.text forKey:(id)kSecAttrAccount];
	
	OSStatus err = SecItemDelete((CFDictionaryRef)query);
	
	if (err == noErr) {
		NSLog(@"SecItemDelete: noErr");
	} else {
		NSLog(@"SecItemDelete: error(%d)", err);
	}
}

- (IBAction)dump:(id)sender
{
	NSMutableDictionary* query = [NSMutableDictionary dictionary];
	
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
	[query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
	[query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnRef];
	[query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnPersistentRef];
	[query setObject:(id)kSecMatchLimitAll forKey:(id)kSecMatchLimit];
//	[query setObject:(id)kCFBooleanTrue forKey:(id)kSecMatchSearchList];

	CFArrayRef result = nil;
	OSStatus err = SecItemCopyMatching((CFDictionaryRef)query,(CFTypeRef*)&result);
	
	if (err == noErr) {
		NSLog(@"SecItemCopyMatching: noErr");
		NSLog(@"%@", result);
/*		for (id object in (NSArray*)result) {
			NSLog(@"%@", [object class]);
		}
 */
	} else if(err = errSecItemNotFound) {
		NSLog(@"SecItemCopyMatching: errSecItemNotFound");
	} else {
		NSLog(@"SecItemCopyMatching: error(%d)", err);
	}
	
}

- (IBAction)convert:(id)sender
{
	
	NSMutableDictionary* query = [NSMutableDictionary dictionary];
	
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnPersistentRef];
	
	CFArrayRef result = nil;
	OSStatus err = SecItemCopyMatching((CFDictionaryRef)query,(CFTypeRef*)&result);
	
	if (err == noErr) {
		NSLog(@"[1]SecItemCopyMatching: noErr");
		NSLog(@"[1] %@", result);
	
		NSMutableDictionary* query2 = [NSMutableDictionary dictionary];
		
		[query2 setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
		[query2 setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnRef];
		
		NSArray* array = [NSArray arrayWithObject:(id)result];
		[query2 setObject:array forKey:(id)kSecMatchItemList];
		
		CFArrayRef result2 = nil;
		OSStatus err = SecItemCopyMatching((CFDictionaryRef)query2,(CFTypeRef*)&result2);
		
		if (err == noErr) {
			NSLog(@"[2]SecItemCopyMatching: noErr");
			NSLog(@"[2] %@", result);
		} else if(err = errSecItemNotFound) {
			NSLog(@"[2]SecItemCopyMatching: errSecItemNotFound");
		} else {
			NSLog(@"[2]SecItemCopyMatching: error(%d)", err);
		}
		
	} else if(err = errSecItemNotFound) {
		NSLog(@"[1]SecItemCopyMatching: errSecItemNotFound");
	} else {
		NSLog(@"[1]SecItemCopyMatching: error(%d)", err);
	}
	
}

@end
