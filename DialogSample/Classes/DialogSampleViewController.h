//
//  DialogSampleViewController.h
//  DialogSample
//
//  Created by Hiroshi Hashiguchi on 10/07/23.
//  Copyright Hiroshi Hashiguchi 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomDialogViewDelegate.h"

@class CustomDialogViewController;

@interface DialogSampleViewController : UIViewController <CustomDialogViewDelegate> {
	
	CustomDialogViewController* dialogViewController;
	
	UIButton *button;
	
	BOOL opened;
}
@property (nonatomic, retain) CustomDialogViewController* dialogViewController;
@property (nonatomic, retain) IBOutlet UIButton *button;

- (IBAction)openDialog:(id)sender;
- (IBAction)openLabel:(id)sender;

@end

