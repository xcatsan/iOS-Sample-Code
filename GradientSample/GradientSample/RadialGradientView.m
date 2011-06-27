//
//  RadialGradientView.m
//  GradientSample
//
//  Created by Hiroshi Hashiguchi on 11/06/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RadialGradientView.h"


@implementation RadialGradientView

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
    
    CGContextAddEllipseInRect(context, self.frame);
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {
        1.0f, 1.0f, 1.0f, 1.0f,
        0.5f, 0.5f, 0.5f, 1.0f,
        0.25f, 0.25f, 0.25f, 1.0f,
    };    
    CGFloat locations[] = { 0.0, 0.5, 1.0 };
    
    size_t count = sizeof(components)/ (sizeof(CGFloat)* 4);
    CGGradientRef gradientRef =
        CGGradientCreateWithColorComponents(colorSpaceRef, components, locations, count);
        
    CGRect frame = self.bounds;
    CGFloat radius = frame.size.height/2.0*0.8;

    CGFloat shadowWidth = radius * 0.1;
    CGContextSetShadow(context,CGSizeMake(shadowWidth, shadowWidth), 5.0);

    
    CGPoint startCenter = frame.origin;
    startCenter.x += frame.size.width/2.0;
    startCenter.y += frame.size.height/2.0;
    CGPoint endCenter = startCenter;
    
    startCenter.x -= radius/2.0;
    startCenter.y -= radius/2.0;

    CGFloat startRadius = 0;
    CGFloat endRadius = radius;
    
    CGContextDrawRadialGradient(context,
                                gradientRef,
                                startCenter,
                                startRadius,
                                endCenter,
                                endRadius,
                                kCGGradientDrawsBeforeStartLocation);
    
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpaceRef);
    
    CGContextRestoreGState(context);
}

- (void)dealloc
{
    [super dealloc];
}

@end
