//
//  GradientButton.m
//  GradientButton
//
//  Created by Hiroshi Hashiguchi on 11/10/21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "GradientButton.h"
#import <QuartzCore/QuartzCore.h>

#define CORNER_RADIUS   5.0

@interface HighlightEdgeLayer : CALayer
@end
    
@implementation HighlightEdgeLayer
- (void)drawInContext:(CGContextRef)context
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint p = CGPointMake(CORNER_RADIUS, CORNER_RADIUS);

    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 CORNER_RADIUS,
                 2.0*M_PI/2.0,
                 3.0*M_PI/2.0,
                 false);

    p.x = self.bounds.size.width - CORNER_RADIUS;
    CGPathAddArc(path, NULL,
                 p.x, p.y,
                 CORNER_RADIUS,
                 3.0*M_PI/2.0,
                 4.0*M_PI/2.0,
                 false);

    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.0 alpha:0.5].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextDrawPath(context, kCGPathStroke);

}
@end

@interface GradientButton()
@property (nonatomic, assign) CAGradientLayer* gradientLayer;
@property (nonatomic, assign) CATextLayer* textLayer;
@end

#define PADDING_X     10.0

typedef enum {
    GradientButtonStateNormal = 0,
    GradientButtonStateHighlighted,
    GradientButtonStateDisabled
} GradientButtonState;

@implementation GradientButton

@synthesize gradientLayer = gradientLayer_;
@synthesize textLayer = textLayer_;
@synthesize textColor = textColor_;
@synthesize text = text_;

- (UIFont*)_font
{
    return [UIFont boldSystemFontOfSize:14.0];
}

- (void)_setState:(GradientButtonState)state
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    {
        switch (state) {
            case GradientButtonStateNormal:
                self.gradientLayer.colors =
                [NSArray arrayWithObjects:
                 (id)[UIColor colorWithWhite:1.0 alpha:0.7].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.4].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.3].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor,
                 nil];
                self.textLayer.foregroundColor = self.textColor.CGColor;
                break;
                
            case GradientButtonStateHighlighted:
                self.gradientLayer.colors =
                [NSArray arrayWithObjects:
                 (id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.2].CGColor,
                 (id)[UIColor colorWithWhite:0.0 alpha:0.05].CGColor,
                 (id)[UIColor colorWithWhite:0.0 alpha:0.1].CGColor,
                 nil];
                self.textLayer.foregroundColor = self.textColor.CGColor;
                break;
                
            case GradientButtonStateDisabled:
                self.gradientLayer.colors =
                [NSArray arrayWithObjects:
                 (id)[UIColor colorWithWhite:1.0 alpha:0.7].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.4].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.3].CGColor,
                 (id)[UIColor colorWithWhite:1.0 alpha:0.0].CGColor,
                 nil];
                self.textLayer.foregroundColor = [UIColor lightGrayColor].CGColor;
                break;
        }
    }
    [CATransaction commit];
}
- (void)_setup
{
    // get scale
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    // setup basics
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor blackColor];

    // setup base layer
    self.layer.cornerRadius = CORNER_RADIUS;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.75].CGColor;
    self.layer.borderWidth = 1.0;

    // setup gradient layer
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.contentsScale = scale;
    self.gradientLayer.frame = self.bounds;
    self.gradientLayer.locations = [NSArray arrayWithObjects:
                                    [NSNumber numberWithFloat:0.0],
                                    [NSNumber numberWithFloat:0.5],
                                    [NSNumber numberWithFloat:0.5],
                                    [NSNumber numberWithFloat:1.0],
                                    nil];

    [self.layer addSublayer:self.gradientLayer];

    // setup text layer
    self.textLayer = [CATextLayer layer];
    self.textLayer.contentsScale = scale;
    self.textLayer.string = self.text;
    self.textLayer.font = CGFontCreateWithFontName((CFStringRef)[self _font].fontName);
    self.textLayer.fontSize = [self _font].pointSize;
    self.textLayer.truncationMode = kCATruncationEnd;
    self.textLayer.alignmentMode = kCAAlignmentCenter;
    self.textLayer.shadowColor = [UIColor blackColor].CGColor;
    self.textLayer.shadowRadius = 0.5;
    self.textLayer.shadowOffset =CGSizeMake(-0.5, -0.5);
    self.textLayer.shadowOpacity = 0.5;
    [self.layer addSublayer:self.textLayer];
    
    // setup highlight edge
    HighlightEdgeLayer* heLayer = [HighlightEdgeLayer layer];
    heLayer.frame = CGRectInset(self.bounds, 0.5, 1.0);
    [self.layer addSublayer:heLayer];
    [heLayer setNeedsDisplay];
    
    // set state
    [self _setState:GradientButtonStateNormal];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self _setup];        
    }
    return self;
}

- (void)dealloc {
    self.textColor = nil;
    self.text = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark Properties
- (void)setText:(NSString *)text
{
    NSString* tmp = [[text copy] autorelease];
    [text_ release];
    text_ = tmp;
    self.textLayer.string = text_;
    
    CGSize textSize = [text_ sizeWithFont:[self _font]];
    self.textLayer.frame = CGRectMake(PADDING_X,
                                      (self.frame.size.height - textSize.height)/2.0 + 2,
                                      self.frame.size.width - PADDING_X*2,
                                      textSize.height);

}


#pragma mark -
#pragma mark UIControl

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self _setState:enabled ? GradientButtonStateNormal : GradientButtonStateDisabled];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self _setState:highlighted ? GradientButtonStateHighlighted : GradientButtonStateNormal];
}

@end
