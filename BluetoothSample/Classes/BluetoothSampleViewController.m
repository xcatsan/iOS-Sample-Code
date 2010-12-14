//
//  BluetoothSampleViewController.m
//  BluetoothSample
//
//  Created by Hiroshi Hashiguchi on 10/12/14.
//  Copyright 2010 . All rights reserved.
//

#import "BluetoothSampleViewController.h"

@implementation BluetoothSampleViewController
@synthesize session = session_;
@synthesize peerID = peerID_;
@synthesize message = message_;
@synthesize textView = textView_;
@synthesize sendText = sendText_;


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
	self.session = nil;
    [super dealloc];
}

- (IBAction)connect:(id)sender
{
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, sender);
	
	GKPeerPickerController* picker = [[GKPeerPickerController alloc] init];
	picker.delegate = self;
	picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
	[picker show];
}
- (IBAction)sendPhoto:(id)sender
{
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, sender);
}

- (IBAction)sendText:(id)sender
{
	if (self.session == nil) {
		NSLog(@"no connection");
		return;
	}
	NSString* msg = self.sendText.text;
	
	NSData* data = [msg dataUsingEncoding:NSUTF8StringEncoding];
	
	NSError* error = nil;
	[self.session sendData:data
				   toPeers:[NSArray arrayWithObject:self.peerID]
			  withDataMode:GKSendDataReliable
					 error:&error];
	if (error) {
		NSLog(@"%@", error);
	}
	self.sendText.text = @"";
}


#pragma mark -
#pragma mark GKPeerPickerControllerDelegate
- (void)peerPickerController:(GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type
{
	NSLog(@"%s|type=%d", __PRETTY_FUNCTION__, type);
}

/*
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type
{
	NSLog(@"%s|type=%d", __PRETTY_FUNCTION__, type);
}
*/

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
	NSLog(@"%s|peerID=%@", __PRETTY_FUNCTION__, peerID);
	
	self.session = session;
	session.delegate = self;
	[session setDataReceiveHandler:self withContext:nil];
	picker.delegate = nil;
	[picker dismiss];
	[picker autorelease];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, nil);
	
	picker.delegate = nil;
	[picker autorelease];
}

#pragma mark -
#pragma mark GKSessionDelegate
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
	NSString* stateDesc;
	if (state == GKPeerStateAvailable) stateDesc = @"GKPeerStateAvailable";
	else if (state == GKPeerStateUnavailable) stateDesc = @"GKPeerStateUnavailable";
	else if (state == GKPeerStateConnected) stateDesc =	@"GKPeerStateConnected";
	else if (state == GKPeerStateDisconnected) stateDesc = @"GKPeerStateDisconnected";
	else if (state == GKPeerStateConnecting) stateDesc = @"GKPeerStateConnecting"; 
	NSLog(@"%s|%@|%@", __PRETTY_FUNCTION__, peerID, stateDesc);
	
	switch (state) {
		case GKPeerStateConnected:
			self.message.text = @"connected";
			self.peerID = peerID;
			break;
		case GKPeerStateDisconnected:
			self.message.text = @"disconnected";
			self.session = nil;			
		default:
			break;
	}
}

/* Indicates a connection request was received from another peer. 
 
 Accept by calling -acceptConnectionFromPeer:
 Deny by calling -denyConnectionFromPeer:
 */
- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, peerID);
	NSError* error = nil;
	[session acceptConnectionFromPeer:peerID error:&error];
	if (error) {		
		NSLog(@"%@", error);
	}
}

/* Indicates a connection error occurred with a peer, which includes connection request failures, or disconnects due to timeouts.
 */
- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
	NSLog(@"%s|%@|%@", __PRETTY_FUNCTION__, peerID, error);
}

/* Indicates an error occurred with the session such as failing to make available.
 */
- (void)session:(GKSession *)session didFailWithError:(NSError *)error
{
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, error);
}

#pragma mark -
#pragma mark -
- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
	NSString* msg = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSString* text = [self.textView.text stringByAppendingFormat:@"%@\n", msg];
	self.textView.text = text;
	NSRange range = NSMakeRange([text length]-1, 1);
	[self.textView scrollRangeToVisible:range];
}

@end
