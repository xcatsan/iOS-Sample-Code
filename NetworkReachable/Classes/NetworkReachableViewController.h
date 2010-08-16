//
//  NetworkReachableViewController.h
//  NetworkReachable
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NetworkReachability;
@interface NetworkReachableViewController : UIViewController {

	UILabel* label;
	
	NetworkReachability* networkReachability_;
}
@property (nonatomic, retain) IBOutlet UILabel* label;

@end

