//
//  SoundSamplesViewController.m
//  SoundSamples
//
//  Created by Hiroshi Hashiguchi on 10/09/07.
//  Copyright  2010. All rights reserved.
//

#import "SoundSamplesViewController.h"
#include <AudioToolbox/AudioToolbox.h>

@implementation SoundSamplesViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (void)playSoundID:(NSString*)soundName
{
	SystemSoundID   soundID;
	NSURL* soundURL = [[NSBundle mainBundle] URLForResource:[soundName stringByDeletingPathExtension]
											  withExtension:[soundName pathExtension]];
    AudioServicesCreateSystemSoundID ((CFURLRef)soundURL, &soundID);
	[soundURL release];
	AudioServicesPlaySystemSound (soundID);
}


-(IBAction)AIFF_BEI16
{
	[self playSoundID:@"AIFF_BEI16.aif"];
}

-(IBAction)AIFF_BEI16_22050
{
	[self playSoundID:@"AIFF_BEI16@22050.aif"];
}

-(IBAction)AIFF_itunes
{
	[self playSoundID:@"AIFF_itunes.aif"];
}

-(IBAction)CAFF_LEI16
{
	[self playSoundID:@"CAFF_LEI16.caf"];
}

-(IBAction)CAFF_LEI16_22050
{
	[self playSoundID:@"CAFF_LEI16@22050.caf"];
}

-(IBAction)MP3_original
{
	[self playSoundID:@"MP3_original.mp3"];
}

@end
