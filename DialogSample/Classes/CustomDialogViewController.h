//
//  CustomDialogViewController.h
//  DialogSample
//
//  Created by Hiroshi Hashiguchi on 10/07/23.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomDialogViewDelegate.h"

@interface CustomDialogViewController : UIViewController {

	NSString* labelText_;
	NSString* buttonTitle_;
	id <CustomDialogViewDelegate> delegate_;
	
	UILabel* label_;
	UIButton* button_;

	BOOL enabled_;
}

@property (nonatomic, copy) NSString* labelText;
@property (nonatomic, copy) NSString* buttonTitle;
@property (nonatomic, assign) id <CustomDialogViewDelegate> delegate;

@property (nonatomic, retain) IBOutlet UILabel* label;
@property (nonatomic, retain) IBOutlet UIButton* button;

-(IBAction)touchedButton:(id)sender;

- (void)setEnabled:(BOOL)enabled;

@end
