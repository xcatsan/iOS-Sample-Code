//
//  CustomCell.m
//  CustomCellSample
//
//  Created by Hiroshi Hashiguchi on 11/05/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell
@synthesize nameLabel;
@synthesize dateLabel;
@synthesize descLabel;
@synthesize imageView;

- (void)dealloc
{
    self.nameLabel = nil;
    self.dateLabel = nil;
    self.descLabel = nil;
    self.imageView = nil;
    [super dealloc];
}

@end
