//
//  RootViewController.m
//  MovieSample
//
//  Created by Hiroshi Hashiguchi on 11/04/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "RootViewController.h"


@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

//
-(void) playMovieAtURL:(NSURL*)url {
    
    MPMoviePlayerController* controller =
    [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    controller.scalingMode = MPMovieScalingModeAspectFit;
    controller.controlStyle = MPMovieControlStyleEmbedded;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:controller];
    
    controller.view.frame = self.view.frame;
    [self.view addSubview:controller.view];
    [controller play];
}

-(void)playbackDidFinish: (NSNotification*) aNotification
{
    MPMoviePlayerController* controller = [aNotification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:controller];
    
    [controller.view removeFromSuperview];
    [controller release];
}

- (IBAction)playLocalMovie:(id)sender
{
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"sample" withExtension:@"mov"];
    [self playMovieAtURL:url];
}



@end
