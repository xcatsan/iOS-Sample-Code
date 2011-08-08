//
//  LayerShadowSampleViewController.m
//  LayerShadowSample
//
//  Created by Hashiguchi Hiroshi on 11/08/08.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LayerShadowSampleViewController.h"

@implementation LayerShadowSampleViewController
@synthesize imageView1;
@synthesize imageView2;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)_addDropShadowToView1:(UIView*)toView
{
    CALayer* subLayer = [CALayer layer];
    subLayer.frame = toView.bounds;
    [toView.layer addSublayer:subLayer];
    subLayer.masksToBounds = YES;
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:
            CGRectMake(-10.0, -10.0, subLayer.bounds.size.width+10.0, 10.0)];
    subLayer.shadowOffset = CGSizeMake(2.5, 2.5);
    subLayer.shadowColor = [[UIColor blackColor] CGColor];
    subLayer.shadowOpacity = 0.5;
    subLayer.shadowPath = [path CGPath];
}



- (void)_addDropShadowToView2:(UIView*)toView
{
    CALayer* subLayer = [CALayer layer];
    subLayer.frame = toView.bounds;
    [toView.layer addSublayer:subLayer];
    subLayer.masksToBounds = YES;

    CGSize size = subLayer.bounds.size;
    CGFloat x = -10.0;
    CGFloat y = -10.0;
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, x, y);
    x += size.width + 10.0;
    CGPathAddLineToPoint(pathRef, NULL, x, y);
    y += 10.0;
    CGPathAddLineToPoint(pathRef, NULL, x, y);
    x -= size.width;
    CGPathAddLineToPoint(pathRef, NULL, x, y);
    y += size.height;
    CGPathAddLineToPoint(pathRef, NULL, x, y);
    x -= 5.0;   // -10
    CGPathAddLineToPoint(pathRef, NULL, x, y);
    y -= size.height;   // +10
    CGPathAddLineToPoint(pathRef, NULL, x, y);
    CGPathCloseSubpath(pathRef);
    
    subLayer.shadowOffset = CGSizeMake(2.5, 2.5);
    subLayer.shadowColor = [[UIColor blackColor] CGColor];
    subLayer.shadowOpacity = 0.5;
    subLayer.shadowPath = pathRef;
    
    CGPathRelease(pathRef);
    
}


- (void)viewDidLoad
{   
    CALayer* layer1 = self.imageView1.layer;
    layer1.masksToBounds = YES;
    [self _addDropShadowToView1:self.imageView1];

    CALayer* layer2 = self.imageView2.layer;
    layer2.masksToBounds = YES;
    layer2.cornerRadius = 5.0f;
    [self _addDropShadowToView2:self.imageView2];

    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setImageView2:nil];
    [self setImageView1:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [imageView2 release];
    [imageView1 release];
    [super dealloc];
}
@end
