//
//  ImageView.m
//  ImageViewTap
//
//  Created by Hiroshi Hashiguchi on 11/06/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThumbnailView.h"
#import "ImageViewTapViewController.h"

@implementation ThumbnailView
@synthesize viewController;
@synthesize imageList;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGPoint p = CGPointZero;
    for (UIImage* image in self.imageList) {
        [image drawAtPoint:p];
        p.x += image.size.width;
    }
    [[UIColor greenColor] set];
    CGRect frame = CGRectMake(selectedIndex_*100, 0, 100, 75);
    UIRectFrame(frame);
}

- (void)dealloc
{
    [super dealloc];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{      
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];

    selectedIndex_ = location.x / 100;
    [self setNeedsDisplay];
    [self.viewController touchedAtIndex:selectedIndex_];
}
@end
