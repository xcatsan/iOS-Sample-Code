//
//  KeyChainsSampeViewController.h
//  KeyChainsSampe
//
//  Created by Hiroshi Hashiguchi on 11/02/02.
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyChainsSampeViewController : UIViewController {

	UITextField* loginId_;
	UITextField* password_;
}
@property (nonatomic, retain) IBOutlet UITextField* loginId;
@property (nonatomic, retain) IBOutlet UITextField* password;

- (IBAction)getPassword:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)delete:(id)sender;
- (IBAction)dump:(id)sender;
- (IBAction)convert:(id)sender;

@end

