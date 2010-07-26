//
//  ActionSheetBlocksExtension.h
//  ActionSheetUsingBlocks
//
//  Created by Hiroshi Hashiguchi on 10/07/26.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActionSheetBlocksExtension : UIActionSheet <UIActionSheetDelegate> {

	void (^didClickBlock_)(UIActionSheet*, NSInteger);
}

- (id)initWithTitle:(NSString *)title
		   didClick:(void (^)(UIActionSheet*, NSInteger))block
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)firstOtherTitle,...;

@end
