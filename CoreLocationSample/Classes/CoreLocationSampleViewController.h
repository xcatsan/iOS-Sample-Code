//
//  CoreLocationSampleViewController.h
//  CoreLocationSample
//
//  Created by Hiroshi Hashiguchi on 10/10/20.
//  Copyright 2010 . All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CoreLocationSampleViewController : UIViewController <CLLocationManagerDelegate> {

	CLLocationManager* locationManager_;
}

@property (nonatomic, retain) CLLocationManager* locationManager;
@end

