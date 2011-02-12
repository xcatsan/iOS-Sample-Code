//
//  KeyChainApp_2ViewController.m
//  KeyChainApp-2
//
//  Created by Hiroshi Hashiguchi on 11/02/05.
//  Copyright 2011 . All rights reserved.
//

#import "KeyChainApp_2ViewController.h"

@implementation KeyChainApp_2ViewController
@synthesize account, password;


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
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction)updateItem
{
	NSMutableDictionary* attributes = nil;
	NSMutableDictionary* query = [NSMutableDictionary dictionary];
	NSData* passwordData = [self.password.text dataUsingEncoding:NSUTF8StringEncoding];
	
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:(id)self.account.text forKey:(id)kSecAttrAccount];
	
	OSStatus err = SecItemCopyMatching((CFDictionaryRef)query, NULL);
	
	if (err == noErr) {
		// update item
		NSLog(@"SecItemCopyMatching: noErr");
		
		attributes = [NSMutableDictionary dictionary];
		[attributes setObject:passwordData forKey:(id)kSecValueData];
		
		err = SecItemUpdate((CFDictionaryRef)query, (CFDictionaryRef)attributes);
		if (err == noErr) {
			NSLog(@"SecItemUpdate: noErr");
		} else {
			NSLog(@"SecItemUpdate: error(%d)", err);
		}
		
	} else if (err = errSecItemNotFound) {
		// add new item
		NSLog(@"SecItemCopyMatching: errSecItemNotFound");
		
	} else {
		NSLog(@"SecItemCopyMatching: error(%d)", err);
	}
	
}

- (IBAction)dumpItems
{
	NSMutableDictionary* query = [NSMutableDictionary dictionary];
	
	[query setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
	[query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
	[query setObject:(id)kSecMatchLimitAll forKey:(id)kSecMatchLimit];
	
	CFArrayRef result = nil;
	OSStatus err = SecItemCopyMatching((CFDictionaryRef)query,(CFTypeRef*)&result);
	
	if (err == noErr) {
		NSLog(@"SecItemCopyMatching: noErr");
		NSLog(@"%@", result);
	} else if(err = errSecItemNotFound) {
		NSLog(@"SecItemCopyMatching: errSecItemNotFound");
	} else {
		NSLog(@"SecItemCopyMatching: error(%d)", err);
	}
}


@end
