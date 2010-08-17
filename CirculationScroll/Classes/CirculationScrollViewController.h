//
//  CirculationScrollViewController.h
//  CirculationScroll
//
//  Created by Hiroshi Hashiguchi on 10/08/17.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CirculationScrollViewController : UIViewController {

	UIScrollView* scrollView;
	NSArray* viewList;
	
	NSArray* imageList;
}
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) NSArray* viewList;
@property (nonatomic, retain) NSArray* imageList;
@end

