//
//  ImageViewTapViewController.m
//  ImageViewTap
//
//  Created by Hiroshi Hashiguchi on 11/06/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageViewTapViewController.h"
#import "ThumbnailView.h"

@implementation ImageViewTapViewController
@synthesize scrollView;
@synthesize thumnailView;
@synthesize imageView;

- (void)dealloc
{
    [scrollView release];
    [thumnailView release];
    [imageView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray* imageList = [NSMutableArray array];
    for (int i=0; i < 8; i++) {
        UIImage* image = [UIImage imageNamed:
                          [NSString stringWithFormat:@"image%02ds.jpg", i+1]];
        [imageList addObject:image];
    }
    self.thumnailView.imageList = imageList;
    CGRect rect = CGRectMake(0, 0, 100*8, 75);
    self.thumnailView.frame = rect;
    self.scrollView.contentSize = rect.size;
    
    [self touchedAtIndex:0];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setThumnailView:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)touchedAtIndex:(NSInteger)index
{
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image%02d.jpg", index+1]];
}

@end
