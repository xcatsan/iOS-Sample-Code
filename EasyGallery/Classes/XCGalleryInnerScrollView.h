//
//  ImageScrollView.h
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/10/04.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCGalleryInnerScrollView;
@protocol XCGalleryInnerScrollViewDelegate

- (void)innerScrollView:(XCGalleryInnerScrollView*)innerScrollView
		   touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface XCGalleryInnerScrollView : UIScrollView <UIScrollViewDelegate> {

	UIImageView* imageView_;
	id <XCGalleryInnerScrollViewDelegate> eventDelegate_;
}

@property (nonatomic, retain) UIImageView* imageView;
@property (nonatomic, assign) id <XCGalleryInnerScrollViewDelegate> eventDelegate;

+ (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView
					  withScale:(float)scale withCenter:(CGPoint)center;

@end
