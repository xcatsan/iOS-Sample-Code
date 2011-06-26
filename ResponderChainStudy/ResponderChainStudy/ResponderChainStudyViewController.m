//
//  ResponderChainStudyViewController.m
//  ResponderChainStudy
//
//  Created by Hiroshi Hashiguchi on 11/06/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResponderChainStudyViewController.h"

@implementation ResponderChainStudyViewController
@synthesize button2;
@synthesize button;

- (void)dealloc
{
    [button release];
    [button2 release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.button2 addTarget:nil 
                 action:@selector(touchMe:)
       forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidUnload
{
    [self setButton:nil];
    [self setButton2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)_displayResponderChain:(UIResponder*)responder
{
    if (responder != nil) {
        NSLog(@"%@", responder);
        [self _displayResponderChain:[responder nextResponder]];
    }
}
- (IBAction)display:(id)sender {
    [self _displayResponderChain:sender];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s|%@", __PRETTY_FUNCTION__, event);
}

- (void)touchMe:(id)sender
{
    NSLog(@"%s|%@", __PRETTY_FUNCTION__, sender);
    
}

@end
