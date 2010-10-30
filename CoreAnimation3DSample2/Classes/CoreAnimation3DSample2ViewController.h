//
//  CoreAnimation3DSample2ViewController.h
//  CoreAnimation3DSample2
//
//  Created by Hiroshi Hashiguchi on 10/10/30.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoreAnimation3DSample2ViewController : UIViewController {

	BOOL fadeIn;
	UIView* baseView;
}

- (IBAction)fadeOut:(id)sender;
@property (nonatomic, retain) IBOutlet 	UIView* baseView;

@end

