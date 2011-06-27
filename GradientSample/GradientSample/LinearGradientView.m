//
//  LinearGradientView.m
//  GradientSample
//
//  Created by Hiroshi Hashiguchi on 11/06/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LinearGradientView.h"


@implementation LinearGradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();    
    CGContextSaveGState(context);
    
    CGContextAddRect(context, self.frame);
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {
        1.0f, 1.0f, 1.0f, 0.5f,
        0.0f, 0.0f, 0.0f, 0.5f
    };
    CGFloat locations[] = { 0.0f, 1.0f };

    size_t count = sizeof(components)/ (sizeof(CGFloat)* 4);
    
    CGRect frame = self.bounds;
    CGPoint startPoint = frame.origin;
    CGPoint endPoint = frame.origin;
//    endPoint.x = frame.origin.x + frame.size.width;
    endPoint.y = frame.origin.y + frame.size.height;
    
    CGGradientRef gradientRef =
        CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, count);
    
    CGContextDrawLinearGradient(context,
                                gradientRef,
                                startPoint,
                                endPoint,
                                kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);
    
    CGContextRestoreGState(context);
}

- (void)dealloc
{
    [super dealloc];
}

@end
