//
//  CustomView.m
//  ScrollViewPaging
//
//  Created by Hiroshi Hashiguchi on 10/10/06.
//  Copyright 2010 . All rights reserved.
//

#import "CustomView.h"


@implementation CustomView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		CGFloat red = (rand()%255) / 255.0;
		CGFloat green = (rand()%255) / 255.0;
		CGFloat blue = (rand()%255) / 255.0;
		color = [UIColor colorWithRed:red
								green:green
								 blue:blue
								alpha:1.0];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	
	CGRect rect1 = CGRectMake(0, 0, 320, 460);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	[color set];
	CGContextFillRect(context, rect1);
	[[UIColor whiteColor] set];
	CGContextSetLineWidth(context, 5);
	CGContextStrokeRect(context, rect1);
}

- (void)dealloc {
    [super dealloc];
}


@end
