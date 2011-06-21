//
//  ImageView.h
//  ImageViewTap
//
//  Created by Hiroshi Hashiguchi on 11/06/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageViewTapViewController;
@interface ThumbnailView : UIView {
    
    ImageViewTapViewController* viewController_;
    
    NSMutableArray* imageList_;
    
    NSInteger selectedIndex_;
    
}

@property (nonatomic, assign) IBOutlet ImageViewTapViewController* viewController;
@property (nonatomic, retain) NSMutableArray* imageList;
@end
