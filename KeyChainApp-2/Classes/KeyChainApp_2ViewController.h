//
//  KeyChainApp_2ViewController.h
//  KeyChainApp-2
//
//  Created by Hiroshi Hashiguchi on 11/02/05.
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyChainApp_2ViewController : UIViewController {

}
@property (nonatomic, retain) IBOutlet UITextField* account;
@property (nonatomic, retain) IBOutlet UITextField* password;

- (IBAction)updateItem;
- (IBAction)dumpItems;

@end

