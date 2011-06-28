//
//  FooterView.m
//  CustomCellSample
//
//  Created by Hiroshi Hashiguchi on 11/06/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FooterView.h"


@implementation FooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#define FOOTER_OBJECT_LENGTH    10
#define FOOTER_SHADOW_OFFSET    5.0
#define FOOTER_SHADOW_BLUR      5.0

- (void)drawRect:(CGRect)rect
{
    CGRect frame = self.bounds;
    frame.origin.x -= FOOTER_OBJECT_LENGTH;
    frame.origin.y -= FOOTER_OBJECT_LENGTH;
    frame.size.width += FOOTER_OBJECT_LENGTH;
    frame.size.height = FOOTER_OBJECT_LENGTH;
    
    CGContextRef context = UIGraphicsGetCurrentContext();    
    
    CGContextSetShadow(context,CGSizeMake(FOOTER_SHADOW_OFFSET, FOOTER_SHADOW_OFFSET), FOOTER_SHADOW_BLUR);
    
    [[UIColor whiteColor] setFill];
    CGContextFillRect(context, frame);
    
}

- (void)dealloc
{
    [super dealloc];
}

@end
