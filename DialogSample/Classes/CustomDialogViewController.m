//
//  CustomDialogViewController.m
//  DialogSample
//
//  Created by Hiroshi Hashiguchi on 10/07/23.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "CustomDialogViewController.h"


@implementation CustomDialogViewController
@synthesize buttonTitle = buttonTitle_;
@synthesize labelText = labelText_;
@synthesize delegate = delegate_;
@synthesize label = label_;
@synthesize button = button_;

- (id)init {
    if (self = [super initWithNibName:NSStringFromClass([self class])
							   bundle:nil]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.button setTitle:self.buttonTitle
				 forState:UIControlStateNormal];
	self.label.text = self.labelText;
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.label = nil;
	self.button = nil;
}

- (void) dealloc
{
	self.buttonTitle = nil;
	self.labelText = nil;
	[super dealloc];
}



#pragma mark -
#pragma mark Event handling
-(IBAction)touchedButton:(id)sender
{
	[self.delegate touchedButton:sender];
}

@end
