//
//  XCGalleryView.h
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/10/07.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCGalleryView;
@protocol XCGalleryViewDelegate

-(NSInteger)numberImagesInGallery:(XCGalleryView*)galleryView;
-(UIImage*)galleryImage:(XCGalleryView*)galleryView filenameAtIndex:(NSUInteger)index;
-(void)galleryDidStopSlideShow:(XCGalleryView*)galleryView;

@end

@class XCGalleryInnerScrollView;
@interface XCGalleryView : UIView <UIScrollViewDelegate> {

	NSInteger currentImageIndex_;
	
	UIScrollView* scrollView_;
	NSInteger contentOffsetIndex_;
	
	NSMutableArray* innerScrollViews_;
	
	CGSize previousScrollSize_;
	
	
	id <XCGalleryViewDelegate> delegate_;
	

	BOOL showcaseModeEnabled_;
	CGSize showcaseMargin_;
	CGSize viewSpacing_;

	CGSize spacing_;
	CGSize margin_;
	
	BOOL didSetup_;
	
	BOOL pageControlEnabled_;
	UIPageControl* pageControl_;
	
	// slide show status
	BOOL isRunningSlideShow_;
	NSTimeInterval slideShowDuration_;
	NSTimer* timer_;
	XCGalleryInnerScrollView* transitionInnerScrollView_;
}

// public properties
@property (nonatomic, assign) IBOutlet id <XCGalleryViewDelegate> delegate;
@property (nonatomic, assign) BOOL showcaseModeEnabled;
@property (nonatomic, assign) BOOL pageControlEnabled;
@property (nonatomic, assign) BOOL isRunningSlideShow;
@property (nonatomic, assign) NSTimeInterval slideShowDuration;

// public methods
- (void)startSlideShow;

@end
