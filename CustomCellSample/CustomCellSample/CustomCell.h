//
//  CustomCell.h
//  CustomCellSample
//
//  Created by Hiroshi Hashiguchi on 11/05/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BaseView, SlideView;
@interface CustomCell : UITableViewCell {
    
    BOOL slideOpened_;
}
@property (nonatomic, retain) IBOutlet BaseView* baseView;
@property (nonatomic, retain) SlideView* slideView;

@property (nonatomic, retain) IBOutlet UILabel* nameLabel;
@property (nonatomic, retain) IBOutlet UILabel* dateLabel;
@property (nonatomic, retain) IBOutlet UILabel* descLabel;
@property (nonatomic, retain) IBOutlet UIImageView* imageView;

@property (nonatomic, retain) IBOutlet UIViewController* viewController; 

@property (nonatomic, retain) IBOutlet UIButton* button;


- (void)setSlideOpened:(BOOL)slideOpened animated:(BOOL)animated;

@end
