//
//  XCGalleryView.h
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/10/07.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCGalleryInnerScrollView.h"

@class XCGalleryView;
@protocol XCGalleryViewDelegate

-(NSInteger)numberImagesInGallery:(XCGalleryView*)galleryView;
-(UIImage*)galleryImage:(XCGalleryView*)galleryView filenameAtIndex:(NSUInteger)index;
-(void)galleryDidStopSlideShow:(XCGalleryView*)galleryView;

@end

@class XCGalleryInnerScrollView;
@interface XCGalleryView : UIView <UIScrollViewDelegate, XCGalleryInnerScrollViewDelegate> {

	NSInteger currentImageIndex_;
	
	UIScrollView* scrollView_;
	NSInteger contentOffsetIndex_;
	
	NSMutableArray* innerScrollViews_;
	
	CGSize previousScrollSize_;
	
	
	id <XCGalleryViewDelegate> delegate_;
	

	BOOL showcaseModeEnabled_;
	BOOL showcaseModeEnabledBeforeSlideshow_;
	
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
	
	BOOL scrollingAnimation_;
	
}

// public properties
@property (nonatomic, assign) IBOutlet id <XCGalleryViewDelegate> delegate;
@property (nonatomic, assign) BOOL showcaseModeEnabled;
@property (nonatomic, assign) BOOL pageControlEnabled;
@property (nonatomic, assign) BOOL isRunningSlideShow;
@property (nonatomic, assign) NSTimeInterval slideShowDuration;
@property (nonatomic, assign) NSInteger currentPage;	// start with 0

// public methods
- (void)startSlideShow;
- (void)stopSlideShow;
- (void)setCurrentPage:(NSInteger)page animated:(BOOL)animated;
- (void)movePreviousPage;
- (void)moveNextPage;
- (void)movePreviousPageAnimated:(BOOL)animated;
- (void)moveNextPageAnimated:(BOOL)animated;
- (void)removeCurrentPage;

@end
