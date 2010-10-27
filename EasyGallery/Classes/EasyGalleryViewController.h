//
//  EasyGalleryViewController.h
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/09/28.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCGalleryView.h"

@interface EasyGalleryViewController : UIViewController <XCGalleryViewDelegate> {

	NSMutableArray* imageFiles_;
	
	XCGalleryView* galleryView;
}

@property (nonatomic, retain) NSMutableArray* imageFiles;
@property (nonatomic, retain) IBOutlet XCGalleryView* galleryView;
- (IBAction)playSlideShow:(id)sender;
- (IBAction)changeMode:(id)sender;
- (IBAction)movePage:(id)sender;
- (IBAction)refresh:(id)sender;
- (IBAction)deletePage:(id)sender;
- (IBAction)movePrevious:(id)sender;
- (IBAction)moveNext:(id)sender;
@end

