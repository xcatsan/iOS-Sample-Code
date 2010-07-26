//
//  ActionSheetBlocksExtension.m
//  ActionSheetUsingBlocks
//
//  Created by Hiroshi Hashiguchi on 10/07/26.
//  Copyright 2010 . All rights reserved.
//

#import "ActionSheetBlocksExtension.h"


@implementation ActionSheetBlocksExtension

#pragma mark -
#pragma mark Initialization & deallocation
- (id)initWithTitle:(NSString *)title
		   didClick:(void (^)(UIActionSheet*, NSInteger))block
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
	otherButtonTitles:(NSString *)firstOtherTitle,...
{
	self = [super initWithTitle:title
					   delegate:self
			  cancelButtonTitle:nil
		 destructiveButtonTitle:nil
			  otherButtonTitles:nil];


	if (self) {
		didClickBlock_ = [block retain];

		int index = 0;
		
		if (destructiveButtonTitle) {
			[self addButtonWithTitle:destructiveButtonTitle];
			self.destructiveButtonIndex = index;
			index++;
		}
		
		if (firstOtherTitle) {
			[self addButtonWithTitle:firstOtherTitle];
			index++;
	
			va_list args;
			va_start(args, firstOtherTitle);
			NSString* title;
			while (title = va_arg(args, NSString*)) {
				[self addButtonWithTitle:title];
				index++;
			}
			va_end(args);
		}
		
		[self addButtonWithTitle:cancelButtonTitle];
		self.cancelButtonIndex = index;
	}
	return self;
}


- (void) dealloc
{
	[didClickBlock_ release];
	[super dealloc];
}


#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	didClickBlock_(actionSheet, buttonIndex);
}

@end
