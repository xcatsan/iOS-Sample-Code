//
//  CustomTextField.m
//  MenuSample
//
//  Created by Hiroshi Hashiguchi on 10/10/01.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "CustomTextField.h"


@implementation CustomTextField

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UIMenuController* menuController = [UIMenuController sharedMenuController];
	[menuController setTargetRect:CGRectZero inView:self];
	menuController.arrowDirection = UIMenuControllerArrowDown;
	
	NSMutableArray* menuItems = [NSMutableArray array];
	
	[menuItems addObject:
	 [[[UIMenuItem alloc] initWithTitle:@"メニュー1"
								 action:@selector(menu1:)] autorelease]];
	[menuItems addObject:
	 [[[UIMenuItem alloc] initWithTitle:@"メニュー2"
								 action:@selector(menu2:)] autorelease]];
	[menuItems addObject:
	 [[[UIMenuItem alloc] initWithTitle:@"メニュー3"
								 action:@selector(menu3:)] autorelease]];
	menuController.menuItems = menuItems;
	[menuController setMenuVisible:YES animated:YES];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {

	if (
//		action == @selector(paste:) ||
		action == @selector(menu1:) ||
		action == @selector(menu2:) ||
		action == @selector(menu3:)
		) {
		return YES;
	}
	return NO;
}

- (void)menu1:(id)sender
{
	NSLog(@"menu1: %@", sender);
}

- (void)menu2:(id)sender
{
	NSLog(@"menu2: %@", sender);
}

- (void)menu3:(id)sender
{
	NSLog(@"menu3: %@", sender);
}

@end
