//
//  CoreLocationSampleViewController.h
//  CoreLocationSample
//
//  Created by Hiroshi Hashiguchi on 10/10/20.
//  Copyright 2010 . All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CoreLocationSampleViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, MKReverseGeocoderDelegate> {

	CLLocationManager* locationManager_;
	
	MKMapView* mapView_;
	
	UILabel* label_;
	
	NSMutableDictionary* annotationDictionary_;
}

@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, retain) IBOutlet 	MKMapView* mapView;
@property (nonatomic, retain) IBOutlet UILabel* label;
@property (nonatomic, retain) NSMutableDictionary* annotationDictionary;

- (IBAction)reload:(id)sender;

@end

