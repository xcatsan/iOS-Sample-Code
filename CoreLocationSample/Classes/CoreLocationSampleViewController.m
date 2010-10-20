//
//  CoreLocationSampleViewController.m
//  CoreLocationSample
//
//  Created by Hiroshi Hashiguchi on 10/10/20.
//  Copyright 2010 . All rights reserved.
//

#import "CoreLocationSampleViewController.h"
#import "SimpleAnnotation.h"

@implementation CoreLocationSampleViewController

@synthesize locationManager = locationManager_;
@synthesize mapView = mapView_;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	if ([CLLocationManager locationServicesEnabled]) {
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self;
		[self.locationManager startUpdatingLocation];
		NSLog(@"Start updating location.");
		
	} else {
		NSLog(@"The location services is disabled.");
	}
	
	/* for iPad (iOS 3.2)
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	[self.locationManager startUpdatingLocation];
	NSLog(@"Start updating location.");
	 */
}


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
	self.locationManager = nil;
	self.mapView = nil;
	
}


- (void)dealloc {
	self.locationManager = nil;
	self.mapView = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate
- (void)logLocation:(CLLocation*)location
{
	CLLocationCoordinate2D coordinate = location.coordinate;
	NSLog(@"----------------------------------------------------");
	NSLog(@"latitude,logitude : %f, %f", coordinate.latitude, coordinate.longitude);
	NSLog(@"altitude          : %f", location.altitude);
	NSLog(@"cource            : %f", location.course);
	NSLog(@"horizontalAccuracy: %f", location.horizontalAccuracy);
	NSLog(@"verticalAccuracy  : %f", location.verticalAccuracy);
	NSLog(@"speed             : %f", location.speed);
	NSLog(@"timestamp         : %@", location.timestamp);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

//	[self logLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	NSLog(@"Error: %@", error);
}

#pragma mark -
#pragma mark Event
- (IBAction)reload:(id)sender
{
	SimpleAnnotation* annotation = [[[SimpleAnnotation alloc] init] autorelease];
	annotation.location = self.locationManager.location;	
	[self.mapView addAnnotation:annotation];
}

@end
