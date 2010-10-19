//
//  SubViewController.h
//  ViewControllerMemorySample
//
//  Created by Hiroshi Hashiguchi on 10/10/19.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;
@interface SubViewController : UIViewController {
	
	UIImageView* imageView;
	RootViewController* rootViewController;

}

@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) RootViewController* rootViewController;

-(IBAction)next:(id)sender;

@end
