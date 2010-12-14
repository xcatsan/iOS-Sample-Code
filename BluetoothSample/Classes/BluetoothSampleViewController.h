//
//  BluetoothSampleViewController.h
//  BluetoothSample
//
//  Created by Hiroshi Hashiguchi on 10/12/14.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface BluetoothSampleViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate, UINavigationControllerDelegate>{

	GKSession* session_;
	NSString* peearID_;
	
	UILabel* message_;

	UITextView* textView_;
	UITextField* sendText_;
	
	UIImageView* imageView_;
	
}

@property (nonatomic, retain) GKSession* session;
@property (nonatomic, retain) NSString* peerID;

@property (nonatomic, retain) IBOutlet UILabel* message;

@property (nonatomic, retain) IBOutlet UITextView* textView;
@property (nonatomic, retain) IBOutlet UITextField* sendText;
@property (nonatomic, retain) IBOutlet UIImageView* imageView;


- (IBAction)connect:(id)sender;
- (IBAction)sendText:(id)sender;
- (IBAction)sendPhoto:(id)sender;



@end

