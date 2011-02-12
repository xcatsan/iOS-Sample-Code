//
//  KeyChainApp_1ViewController.h
//  KeyChainApp-1
//
//  Created by Hiroshi Hashiguchi on 11/02/05.
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyChainApp_1ViewController : UIViewController {

	UITextField* account;
	UITextField* password;
}
@property (nonatomic, retain) IBOutlet UITextField* account;
@property (nonatomic, retain) IBOutlet UITextField* password;

- (IBAction)addNewItem;
- (IBAction)dumpItems;

@end

