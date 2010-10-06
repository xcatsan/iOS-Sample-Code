//
//  ScrollViewPagingViewController.h
//  ScrollViewPaging
//
//  Created by Hiroshi Hashiguchi on 10/10/06.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewPagingViewController : UIViewController <UIScrollViewDelegate> {

	UIScrollView* scrollView;
}
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;

@end

