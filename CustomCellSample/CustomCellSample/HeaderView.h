//
//  HeaderView.h
//  CustomCellSample
//
//  Created by Hiroshi Hashiguchi on 11/07/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HeaderViewStateHidden = 0,
    HeaderViewStatePullingDown,
    HeaderViewStateOveredThreshold,
    HeaderViewStateStopping
} HeaderViewState;

@interface HeaderView : UIView {
    
}

@property (nonatomic, retain) IBOutlet UILabel* textLabel;
@property (nonatomic, retain) IBOutlet UILabel* detailTextLabel;
@property (nonatomic, retain) IBOutlet UIImageView* imageView; 
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* activityIndicatorView;

@property (nonatomic, assign) HeaderViewState state;

- (void)setUpdatedDate:(NSDate*)date;

@end
