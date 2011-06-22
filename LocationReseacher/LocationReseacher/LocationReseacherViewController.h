//
//  LocationReseacherViewController.h
//  LocationReseacher
//
//  Created by Hiroshi Hashiguchi on 11/06/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define TIMEOUT_SEC 30
#define FILENAME    @"record.log"

//------------------------------------------------------------------------
#define SEND_LOG

#ifdef SEND_LOG
#define SEND_URL    @"https://dev11.anshin-kun.jp/__mikeneko__/record.php"
#endif
//------------------------------------------------------------------------


@interface LocationReseacherViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MKMapViewDelegate> {
 
}
@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) IBOutlet MKMapView* mapView;
@property (nonatomic, retain) IBOutlet UIButton* startButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* indicatorView;
@property (nonatomic, retain) IBOutlet UIView* backView;
@property (nonatomic, retain) IBOutlet UITextField* textField;
@property (nonatomic, retain) IBOutlet UILabel* statusLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl *accuracySelector;
@property (nonatomic, retain) IBOutlet UILabel *timerCount;
@property (nonatomic, retain) IBOutlet UIView *elapseView;
@property (nonatomic, retain) IBOutlet UILabel *timeoutLabel;
@property (nonatomic, retain) IBOutlet UISlider *timeoutSlider;

- (IBAction)onClickStartStopButton:(id)sender;
- (IBAction)didChangeAccuracySelector:(id)sender;
- (IBAction)didChangeTimtoutSlider:(id)sender;

@end
