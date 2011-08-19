//
//  HeaderView.m
//  CustomCellSample
//
//  Created by Hiroshi Hashiguchi on 11/07/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HeaderView.h"


@implementation HeaderView
@synthesize textLabel, detailTextLabel, imageView, activityIndicatorView;
@synthesize state = state_;

- (void)awakeFromNib
{
    self.state = HeaderViewStateHidden;
    [self setUpdatedDate:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    self.textLabel = nil;
    self.detailTextLabel = nil;
    self.activityIndicatorView = nil;

    [super dealloc];
}


#pragma mark -
#pragma mark Properties

//
// arrow_up.png
// http://www.iconfinder.com/icondetails/22742/48/arrow_up_icon
//
// author: Kyo Tux
// url   :http://kyo-tux.deviantart.com/
//

- (void)_animateImageForHeadingUp:(BOOL)headingUp
{
    CGFloat startAngle = headingUp ? 0 : M_PI + 0.00001;
    CGFloat endAngle = headingUp ? M_PI + 0.00001 : 0;

    self.imageView.transform = CGAffineTransformMakeRotation(startAngle);           
    
     // (A) no blocks
    /*
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.imageView.transform =
    CGAffineTransformMakeRotation(endAngle);
    NSLog(@"%s|%@", __PRETTY_FUNCTION__, [NSThread callStackSymbols]);
    [UIView commitAnimations];
    
    // (B) blocks
    [UIView animateWithDuration:0.2
         animations:^{
             NSLog(@"%s|%@", __PRETTY_FUNCTION__, [NSThread callStackSymbols]);
             self.imageView.transform =
                CGAffineTransformMakeRotation(endAngle);
         }];
     */
    // (B') blocks with UIViewAnimationOptionAllowUserInteraction
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.imageView.transform =
                         CGAffineTransformMakeRotation(endAngle);
                         
                     }
                     completion:NULL
     ];
}

- (void)setState:(HeaderViewState)state
{
    switch (state) {
        case HeaderViewStateHidden:
            [self.activityIndicatorView stopAnimating];
            self.imageView.hidden = YES;
            break;

        case HeaderViewStatePullingDown:
            [self.activityIndicatorView stopAnimating];
            self.imageView.hidden = NO;
            self.textLabel.text = @"引き下げて...";
            if (state_ != HeaderViewStatePullingDown) {
                [self _animateImageForHeadingUp:NO];
            }
            break;
            
        case HeaderViewStateOveredThreshold:
            [self.activityIndicatorView stopAnimating];
            self.imageView.hidden = NO;
            self.textLabel.text = @"指をはなすと更新";
            if (state_ == HeaderViewStatePullingDown) {
                [self _animateImageForHeadingUp:YES];
            }
            break;

        case HeaderViewStateStopping:
            [self.activityIndicatorView startAnimating];
            self.textLabel.text = @"更新中...";
            self.imageView.hidden = YES;
            break;
    }

    state_ = state;
}


#pragma mark -
#pragma mark API


- (void)setUpdatedDate:(NSDate*)date
{
    NSString* dateString = [date description];
    if (date == nil) {
        dateString = @"-";
    }
    self.detailTextLabel.text = [NSString stringWithFormat:
                                 @"最後の更新: %@", dateString];
}

@end
