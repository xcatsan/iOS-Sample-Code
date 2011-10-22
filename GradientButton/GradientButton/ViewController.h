//
//  ViewController.h
//  GradientButton
//
//  Created by Hiroshi Hashiguchi on 11/10/21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GradientButton;
@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet GradientButton *button1;
@property (retain, nonatomic) IBOutlet GradientButton *button2;
@property (retain, nonatomic) IBOutlet GradientButton *button3;
@property (retain, nonatomic) IBOutlet GradientButton *button4;
@property (retain, nonatomic) IBOutlet GradientButton *button5;
- (IBAction)touched:(id)sender;
@property (retain, nonatomic) IBOutlet GradientButton *buttonX;

@end
