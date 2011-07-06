//
//  RotateImageSampleViewController.m
//  RotateImageSample
//
//  Created by Hiroshi Hashiguchi on 11/07/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RotateImageSampleViewController.h"

@implementation RotateImageSampleViewController
@synthesize button, imageView;

- (void)dealloc
{
    [imageView release];
    [button release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [imageView release];
    imageView = nil;
    [self setButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)fire:(NSTimer*)timer
{
    angle_ += 30.0;
    self.imageView.transform = CGAffineTransformMakeRotation(2*M_PI*angle_/360.0);

    if (angle_ >= 180.0) {
        angle_ = 0;
        self.button.enabled = YES;
        [timer invalidate];
    }
}

- (IBAction)start:(id)sender {
    
    /*
    [NSTimer scheduledTimerWithTimeInterval:0.05
                                     target:self
                                   selector:@selector(fire:)
                                   userInfo:nil
                                    repeats:YES];
    self.button.enabled = NO;
     */
    self.imageView.transform = CGAffineTransformMakeRotation(0);
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.imageView.transform = CGAffineTransformMakeRotation(2*M_PI*180/360.0-0.000001);                         
                     }];
}
@end
