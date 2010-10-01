//
//  EasyGalleryViewController.h
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/09/28.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EasyGalleryViewController : UIViewController {

	NSMutableArray* imageFiles_;
	NSInteger currentImageIndex_;

	UIScrollView* scrollView_;
	NSInteger contentOffsetIndex_;

	NSMutableArray* imageScrollViews_;
	
}

@property (nonatomic, retain) IBOutlet 	NSMutableArray* imageFiles;
@property (nonatomic, assign) NSInteger currentImageIndex;

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, assign) NSInteger contentOffsetIndex;

@property (nonatomic, retain) NSMutableArray* imageScrollViews;


@end

