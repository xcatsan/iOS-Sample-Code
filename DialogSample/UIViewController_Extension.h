//
//  UIViewController_Extension.h
//  HairConcierge
//
//  Created by Hiroshi Hashiguchi on 10/07/10.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIViewController (CustomDialog)

- (void)presentDialogViewController:(UIViewController*)controller animated:(BOOL)animated;
- (void)dismissDialogViewController:(UIViewController*)controller animated:(BOOL)animated;

@end
