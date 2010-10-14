//
//  ImageScrollView.h
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/10/04.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XCGalleryInnerScrollView : UIScrollView <UIScrollViewDelegate> {

	UIImageView* imageView_;
}

@property (nonatomic, retain) UIImageView* imageView;

+ (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView
					  withScale:(float)scale withCenter:(CGPoint)center;

@end
