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
@synthesize imageView = imageView_;

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
	//	picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
	picker.connectionTypesMask = GKPeerPickerConnectionTypeOnline|GKPeerPickerConnectionTypeNearby;
	[picker show];
}
- (IBAction)sendPhoto:(id)sender
{
	NSLog(@"%s|%@", __PRETTY_FUNCTION__, sender);
	
	UIActionSheet* sheet = [[[UIActionSheet alloc] 
							 initWithTitle:nil
							 delegate:self 
							 cancelButtonTitle:@"キャンセル" 
							 destructiveButtonTitle:nil 
							 otherButtonTitles:@"ライブラリからのイメージ", nil] autorelease];
	[sheet showInView:self.view];
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
	
	if (type == GKPeerPickerConnectionTypeOnline) {
		picker.delegate = nil;
		[picker dismiss];
		[picker autorelease];
		
		self.session = [[[GKSession alloc] initWithSessionID:nil
												 displayName:nil
												 sessionMode:GKSessionModePeer] autorelease];
		self.session.delegate = self;
		self.session.available = YES;
		[self.session setDataReceiveHandler:self withContext:nil];
		NSLog(@"self.session: %x", self.session);

	}
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
	NSLog(@"---------------");
	NSLog(@"session: %x", session);
	NSLog(@"displayName: %@", [session displayNameForPeer:peerID]);
	
	
	NSString* stateDesc;
	if (state == GKPeerStateAvailable) stateDesc = @"GKPeerStateAvailable";
	else if (state == GKPeerStateUnavailable) stateDesc = @"GKPeerStateUnavailable";
	else if (state == GKPeerStateConnected) stateDesc =	@"GKPeerStateConnected";
	else if (state == GKPeerStateDisconnected) stateDesc = @"GKPeerStateDisconnected";
	else if (state == GKPeerStateConnecting) stateDesc = @"GKPeerStateConnecting"; 
	NSLog(@"%s|%@|%@", __PRETTY_FUNCTION__, peerID, stateDesc);
	
	switch (state) {
		case GKPeerStateAvailable:
			NSLog(@"connecting to %@ ...", [session displayNameForPeer:peerID]);
			[session connectToPeer:peerID withTimeout:10];
			break;
			
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
	NSLog(@"---------------");
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
	if ([data length] < 1024) {
		// text
		NSLog(@"received text");
		NSString* msg = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
		NSString* text = [self.textView.text stringByAppendingFormat:@"%@\n", msg];
		self.textView.text = text;
		NSRange range = NSMakeRange([text length]-1, 1);
		[self.textView scrollRangeToVisible:range];
		
	} else {
		// image
		NSLog(@"received image");
		self.imageView.image = [UIImage imageWithData:data];
	}
}


#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1) {
			// canceld
		return;
	}
	
	UIImagePickerController* picker = [[UIImagePickerController alloc] init];
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	
	picker.delegate = self;
	picker.allowsEditing = YES;
	picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:picker animated:YES];
	[picker release];
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
	
	UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
	
	NSError* error = nil;
	NSData* data = UIImageJPEGRepresentation(image, 0.5);
	NSLog(@"%s|size=%d, pixel=%@", __PRETTY_FUNCTION__, [data length], NSStringFromCGSize(image.size));
	NSLog(@"data length=%d", [data length]);
	[self.session sendData:data
				   toPeers:[NSArray arrayWithObject:self.peerID]
			  withDataMode:GKSendDataReliable
					 error:&error];
	if (error) {
		NSLog(@"%@", error);
	}
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

@end
