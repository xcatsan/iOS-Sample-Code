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

-(NSInteger)numberViewsInGallery:(XCGalleryView*)galleryView;
-(UIImage*)galleryImage:(XCGalleryView*)galleryView filenameAtIndex:(NSUInteger)index;

@end


@interface XCGalleryView : UIView <UIScrollViewDelegate> {

	NSInteger currentImageIndex_;
	
	UIScrollView* scrollView_;
	NSInteger contentOffsetIndex_;
	
	NSMutableArray* imageScrollViews_;
	
	CGSize previousScrollSize_;
	
	
	id <XCGalleryViewDelegate> delegate_;
	

	BOOL showcaseModeEnabled_;
	CGSize showcaseMargin_;
	CGSize viewSpacing_;

	CGSize spacing_;
	CGSize margin_;
	
	BOOL didSetup_;
}

@property (nonatomic, assign) NSInteger currentImageIndex;

@property (nonatomic, retain) UIScrollView* scrollView;
@property (nonatomic, assign) NSInteger contentOffsetIndex;

@property (nonatomic, retain) NSMutableArray* imageScrollViews;

@property (nonatomic, assign) IBOutlet id <XCGalleryViewDelegate> delegate;

@property (nonatomic, assign) BOOL showcaseModeEnabled;
@property (nonatomic, assign) CGSize showcaseMargin;
@property (nonatomic, assign) CGSize viewSpacing;
@end
