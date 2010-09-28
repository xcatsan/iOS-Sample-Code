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

	UIScrollView* scrollView_;

	UIScrollView* previousScrollView_;
	UIScrollView* currentScrollView_;
	UIScrollView* nextScrollView_;
	
	NSInteger currentIndex_;
}

@property (nonatomic, retain) IBOutlet 	NSMutableArray* imageFiles;

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;

@property (nonatomic, retain) UIScrollView* previousScrollView;
@property (nonatomic, retain) UIScrollView* currentScrollView;
@property (nonatomic, retain) UIScrollView* nextScrollView;

@property (nonatomic, assign) NSInteger currentIndex;

@end

