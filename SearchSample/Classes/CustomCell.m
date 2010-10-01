//
//  CustomCell.m
//  SearchSample
//
//  Created by Hiroshi Hashiguchi on 10/08/02.
//  Copyright 2010 . All rights reserved.
//

#import "CustomCell.h"


@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	NSLog(@"editing: %d", editing);
}

- (void)dealloc {
    [super dealloc];
}


@end
