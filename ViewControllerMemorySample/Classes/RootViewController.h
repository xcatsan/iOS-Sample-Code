//
//  RootViewController.h
//  ViewControllerMemorySample
//
//  Created by Hiroshi Hashiguchi on 10/10/19.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
	UIImageView* childImageView;
}

@property (nonatomic, assign) UIImageView* childImageView;

- (IBAction)next:(id)sender;

@end

