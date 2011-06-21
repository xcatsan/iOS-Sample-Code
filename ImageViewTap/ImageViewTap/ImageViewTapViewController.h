//
//  ImageViewTapViewController.h
//  ImageViewTap
//
//  Created by Hiroshi Hashiguchi on 11/06/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThumbnailView;
@interface ImageViewTapViewController : UIViewController {
    
    UIScrollView *scrollView;
    ThumbnailView *thumnailView;
    UIImageView *imageView;
}
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet ThumbnailView *thumnailView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

- (void)touchedAtIndex:(NSInteger)index;
@end
