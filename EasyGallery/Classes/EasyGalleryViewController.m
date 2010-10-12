//
//  EasyGalleryViewController.m
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/09/28.
//  Copyright 2010 . All rights reserved.
//

#import "EasyGalleryViewController.h"
#import "XCGalleryInnerScrollView.h"

enum {
	kIndexOfPreviousScrollView = 0,
	kIndexOfCurrentScrollView,
	kIndexOfNextScrollView,
	kMaxOfScrollView
};

@implementation EasyGalleryViewController

@synthesize imageFiles = imageFiles_;
@synthesize galleryView = galleryView_;

#pragma mark -
#pragma mark UIViewController
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.galleryView.showcaseModeEnabled = YES;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.imageFiles = nil;
}


#pragma mark -
#pragma mark XCGalleryViewDelegate
-(NSInteger)numberViewsInGallery:(XCGalleryView*)galleryView
{
	return [self.imageFiles count];
}

-(UIImage*)galleryImage:(XCGalleryView*)galleryView filenameAtIndex:(NSUInteger)index
{
	return [UIImage imageWithContentsOfFile:[self.imageFiles objectAtIndex:index]];
}

@end
