//
//  ViewController.m
//  GradientButton
//
//  Created by Hiroshi Hashiguchi on 11/10/21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "GradientButton.h"

@implementation ViewController
@synthesize buttonX;
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize button5;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.button1.text = @"Select All";
    self.button2.text = @"Select All";
    self.button2.backgroundColor = [UIColor redColor];
    self.button3.text = @"Select All";
    self.button3.backgroundColor = [UIColor blueColor];
    self.button4.text = @"Select All";
    self.button4.backgroundColor = [UIColor orangeColor];
    self.button5.text = @"Select All";
    self.button5.backgroundColor = [UIColor purpleColor];
    self.buttonX.text = @"Disabled";
    self.buttonX.enabled = NO;

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setButton1:nil];
    [self setButton2:nil];
    [self setButton3:nil];
    [self setButton4:nil];
    [self setButton5:nil];
    [self setButtonX:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [button1 release];
    [button2 release];
    [button3 release];
    [button4 release];
    [button5 release];
    [buttonX release];
    [super dealloc];
}
- (IBAction)touched:(id)sender {
    NSLog(@"%s|%@", __PRETTY_FUNCTION__, sender);
}
@end
