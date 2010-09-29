//
//  CustomImageView.m
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/09/29.
//  Copyright 2010 . All rights reserved.
//

#import "CustomImageView.h"


@implementation CustomImageView

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self;
}

@end
