//
//  ModelController.h
//  MultiNavigatorButtons
//
//  Created by 橋口 湖 on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>
- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;
@end
