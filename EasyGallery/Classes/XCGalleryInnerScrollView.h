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

- (void)didTouched:(XCGalleryInnerScrollView*)innerScrollView;
- (void)didDoubleTouched:(XCGalleryInnerScrollView*)innerScrollView;
- (BOOL)canZoom;

@end

@interface XCGalleryInnerScrollView : UIScrollView <UIScrollViewDelegate> {

	UIImageView* imageView_;
	NSObject <XCGalleryInnerScrollViewDelegate> *eventDelegate_;
}

@property (nonatomic, retain) UIImageView* imageView;
@property (nonatomic, assign) NSObject <XCGalleryInnerScrollViewDelegate> *eventDelegate;

+ (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView
					  withScale:(float)scale withCenter:(CGPoint)center;

@end
