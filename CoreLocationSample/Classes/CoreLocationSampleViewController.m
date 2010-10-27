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
@synthesize label = label_;
@synthesize annotationDictionary = annotationDictionary_;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	if ([CLLocationManager locationServicesEnabled]) {
		self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.delegate = self;
		[self.locationManager startUpdatingLocation];
		NSLog(@"Start updating location.");
		
		self.annotationDictionary = [NSMutableDictionary dictionary];
		
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
	self.annotationDictionary = nil;
	
}


- (void)dealloc {
	self.locationManager = nil;
	self.mapView = nil;
	self.annotationDictionary = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark Management for annotationDictionary
- (void)setAnnotation:(SimpleAnnotation*)annotation forCoordinate:(CLLocationCoordinate2D)coordinate
{
	NSValue* coordinateValue = [NSValue value:&coordinate
								 withObjCType:@encode(CLLocationCoordinate2D)];
	[self.annotationDictionary setObject:annotation
								  forKey:coordinateValue];
}

- (SimpleAnnotation*)annotationForCoordinate:(CLLocationCoordinate2D)coordinate
{
	NSValue* coordinateValue = [NSValue value:&coordinate
								 withObjCType:@encode(CLLocationCoordinate2D)];
	SimpleAnnotation* annotation = [self.annotationDictionary objectForKey:coordinateValue];
	[self.annotationDictionary removeObjectForKey:coordinateValue];
	
	return annotation;
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

- (void)logPlacemark:(MKPlacemark*)placemark
{
//	NSLog(@"addressDictionary : %@", placemark.addressDictionary );
	NSLog(@"");
	for (NSString* key in [placemark.addressDictionary allKeys]) {
		if ([key isEqualToString:@"FormattedAddressLines"]) {
			int i=0;
			for (NSString* str in [placemark.addressDictionary objectForKey:key]) {
				NSLog(@"addressDictionary['FormattedAddressLines'][%d]: %@", i++, str);
			}
		} else {
			NSLog(@"addressDictionary['%@']: %@", key, [placemark.addressDictionary objectForKey:key]);
		}
	}

	NSLog(@"thoroughfare : %@", placemark.thoroughfare );
	NSLog(@"subThoroughfare : %@", placemark.subThoroughfare );
	NSLog(@"locality : %@", placemark.locality );
	NSLog(@"subLocality : %@", placemark.subLocality);
	NSLog(@"administrativeArea : %@", placemark.administrativeArea );NSLog(@"subAdministrativeArea : %@", placemark.subAdministrativeArea );
	NSLog(@"postalCode : %@", placemark.postalCode );NSLog(@"country : %@", placemark.country );
	NSLog(@"countryCode : %@", placemark.countryCode );
}	

- (void)setPinToCoordinate:(CLLocation*)location
{
	/*
	// add annotation
	SimpleAnnotation* annotation = [[[SimpleAnnotation alloc] init] autorelease];
	annotation.location = location;
	[self.mapView addAnnotation:annotation];

	[self setAnnotation:annotation
		   forCoordinate:location.coordinate];

	 */
	
	// setup default span
	MKCoordinateSpan span;
	if (self.mapView.region.span.latitudeDelta > 100) {
		span = MKCoordinateSpanMake(0.005, 0.005);
	} else {
		span = self.mapView.region.span;
	}
		


	// set the map view to location
	CLLocationCoordinate2D centerCoordinate = location.coordinate;
	MKCoordinateRegion coordinateRegion =
		MKCoordinateRegionMake(centerCoordinate, span);
	[self.mapView setRegion:coordinateRegion animated:YES];	
	
	MKReverseGeocoder* reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:location.coordinate];
	reverseGeocoder.delegate = self;
	[reverseGeocoder start];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {

//	[self logLocation:newLocation];

	static BOOL first = YES;
	
	if (first) {
		first = NO;
		[self setPinToCoordinate:self.locationManager.location];
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	NSLog(@"Error: %@", error);
}

#pragma mark -
#pragma mark Event
- (IBAction)reload:(id)sender
{

	[self setPinToCoordinate:self.locationManager.location];
}


#pragma mark -
#pragma mark MKReverseGeocoderDelegate
- (void)reverseGeocoder:(MKReverseGeocoder*)geocoder didFindPlacemark:(MKPlacemark*)placemark {

	[self.mapView addAnnotation:placemark];
	[self logPlacemark:placemark];

	/*
	self.label.text = placemark.title;
	[self logPlacemark:placemark];

	SimpleAnnotation* annotation =
		[self annotationForCoordinate:geocoder.coordinate];
	annotation.title = placemark.title;
	 */

}  

- (void) reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError*) error {  

	self.label.text = [error description];

	SimpleAnnotation* annotation =
	[self annotationForCoordinate:geocoder.coordinate];
	annotation.title = [error description];
}  

@end
