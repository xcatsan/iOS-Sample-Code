//
//  KeyChainApp_1ViewController.m
//  KeyChainApp-1
//
//  Created by Hiroshi Hashiguchi on 11/02/05.
//  Copyright 2011 . All rights reserved.
//

#import <Security/Security.h>
#import "KeyChainApp_1ViewController.h"

@implementation KeyChainApp_1ViewController
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

- (IBAction)addNewItem
{
	NSData* passwordData = [self.password.text dataUsingEncoding:NSUTF8StringEncoding];

	NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
	[attributes setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
	[attributes setObject:(id)self.account.text forKey:(id)kSecAttrAccount];
	[attributes setObject:passwordData forKey:(id)kSecValueData];
	[attributes setObject:@"GFDZH8PCUM.share" forKey:(id)kSecAttrAccessGroup];

	OSStatus err = SecItemAdd((CFDictionaryRef)attributes, NULL);
	if (err == noErr) {
		NSLog(@"SecItemAdd: noErr");
	} else {
		NSLog(@"SecItemAdd: error(%d)", err);
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
