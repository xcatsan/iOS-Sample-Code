//
//  LocationReseacherViewController.m
//  LocationReseacher
//
//  Created by Hiroshi Hashiguchi on 11/06/07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LocationReseacherViewController.h"
#import "FBNetworkReachability.h"


//------------------------------------------------------------------------------
@interface LocationEntry : NSObject <MKAnnotation> {
}
@property (nonatomic, retain) CLLocation* location;
@property (nonatomic, assign) NSTimeInterval elapse;
@property (nonatomic, assign) NSInteger order;
@end

@implementation LocationEntry
@synthesize location = location_;
@synthesize elapse = elapse_;
@synthesize order = order_;

static NSDateFormatter* dateFormatter_ = nil;
+ (LocationEntry*)locationEntryWithLocation:(CLLocation*)location order:(NSInteger)order startDate:(NSDate*)startDate
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter_ =  [[NSDateFormatter alloc] init];
        [dateFormatter_ setDateFormat:@"MM/dd HH:mm:ss.SSS"];
    });
    
    LocationEntry* entry =[[[LocationEntry alloc] init] autorelease];
    entry.location = location;
    entry.elapse = -[startDate timeIntervalSinceNow];
    entry.order = order;
    return entry;
}
- (void)dealloc {
    self.location = nil;
    [super dealloc];
}
- (NSString *)title
{
    return [NSString stringWithFormat:@"[%d] +0.1fsec %fm", self.order, self.elapse, self.location.horizontalAccuracy];
}

- (NSString*)subtitleString
{
    return [NSString stringWithFormat:@"%@(%f,%f)",
            [dateFormatter_ stringFromDate:self.location.timestamp],
            self.location.coordinate.latitude,
            self.location.coordinate.longitude
            ];
}

- (NSString*)logString
{
    return [NSString stringWithFormat:@"%d,%f,%f,%f,%f",
            self.order,
            self.elapse,
            self.location.horizontalAccuracy,
            self.location.coordinate.latitude,
            self.location.coordinate.longitude];
}

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

@end

//------------------------------------------------------------------------------

@interface LocationReseacherViewController()
@property (nonatomic, retain) NSMutableArray* histories;
@property (nonatomic, retain) NSMutableArray* circles;
@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, retain) NSDateFormatter* dateFormatter;
@property (nonatomic, retain) NSDate* startDate;
@property (nonatomic, retain) NSMutableString* log;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, retain) FBNetworkReachability* reachability;
@property (nonatomic, assign) NSInteger elapseSec;
@property (nonatomic, assign) BOOL updating;
@property (nonatomic, assign) NSInteger timeoutSec;
@end


@implementation LocationReseacherViewController
@synthesize accuracySelector;
@synthesize timerCount;
@synthesize elapseView;
@synthesize timeoutLabel;
@synthesize timeoutSlider;
@synthesize tableView = tableView_;
@synthesize mapView, startButton, indicatorView, backView;
@synthesize histories, circles;
@synthesize locationManager = locationManager_;
@synthesize dateFormatter = dateFormatter_;
@synthesize startDate, log, count, reachability, elapseSec, updating;
@synthesize timeoutSec = timeoutSec_;
@synthesize textField, statusLabel;

- (void)_releaseObjects
{
    self.histories = nil;
    self.circles = nil;
    self.locationManager = nil;
    self.tableView = nil;
    self.mapView = nil;
    self.startButton = nil;
    self.indicatorView = nil;
    self.backView = nil;
    self.textField = nil;
    self.statusLabel = nil;
    self.log = nil;
    self.reachability = nil;
}
- (void)dealloc
{
    [self _releaseObjects];
    [accuracySelector release];
    [timerCount release];
    [elapseView release];
    [timeoutLabel release];
    [timeoutSlider release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)setTimeoutSec:(NSInteger)timeoutSec
{
    timeoutSec_ = (timeoutSec/10)*10;
    self.timeoutLabel.text = [NSString stringWithFormat:@"%d sec", self.timeoutSec];
    self.timeoutSlider.value = timeoutSec_;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MKCoordinateSpan span = MKCoordinateSpanMake(10.0, 10.0);
    MKCoordinateRegion coordinateRegion =
        MKCoordinateRegionMake(CLLocationCoordinate2DMake(39.85861, 135.045447), span);
    [self.mapView setRegion:coordinateRegion animated:NO]; 

    
    self.histories = [NSMutableArray array];
    self.circles = [NSMutableArray array];
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [self.dateFormatter setDateFormat:@"MM/dd HH:mm:ss.SSS"]; 
    self.tableView.tableFooterView = self.backView;
    [self.indicatorView stopAnimating];
    
    UITapGestureRecognizer* tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapMapView:)];
    [self.mapView addGestureRecognizer:tgr];
    [tgr release];
    
    
    self.reachability = [FBNetworkReachability networkReachabilityWithHostname:@"xcatsan.com"];
    
    CALayer* layer = self.elapseView.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 5.0f;
    layer = self.mapView.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 7.5f;
    
    [self.startButton setTitle:@"start" forState:UIControlStateNormal];

    self.timeoutSec = TIMEOUT_SEC;
}

- (void)viewDidUnload
{
    [self setAccuracySelector:nil];
    [self setTimerCount:nil];
    [self setElapseView:nil];
    [self setTimeoutLabel:nil];
    [self setTimeoutSlider:nil];
    [super viewDidUnload];
    [self _releaseObjects];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Functions
- (void)didFinish
{
    self.updating = NO;

    self.statusLabel.text = @"Finished";
    NSLog(@"Finished");

    self.startButton.enabled = YES;
    [self.startButton setTitle:@"start" forState:UIControlStateNormal];

    self.accuracySelector.enabled = YES;
    self.timeoutSlider.enabled = YES;
    [self.indicatorView stopAnimating];
}

- (void)sendLog
{
    self.statusLabel.text = @"Send log to server...";
//    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];

    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SEND_URL]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:[self.log dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    /*
	[NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response
                                      error:&error];
    if(error) {
        NSLog(@"%@", error);
        self.statusLabel.text = @"Failed to send log";
    }
     */
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self didFinish];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
    [self didFinish];    
}



- (void)saveLog
{
    NSString* path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* filePath = [path stringByAppendingPathComponent:FILENAME];
    
    FILE* fp;
    if ((fp = fopen([filePath cStringUsingEncoding:NSUTF8StringEncoding],
                    "a"))) {
        const char* buff = [self.log cStringUsingEncoding:NSUTF8StringEncoding];
        fwrite(buff, sizeof(char), strlen(buff), fp);
    }
    fclose(fp);
}

- (void)didFire:(NSTimer*)timer
{
    self.elapseSec++;
    self.timerCount.text = [NSString stringWithFormat:@"%d", self.elapseSec];
    if (self.elapseSec >= self.timeoutSec || self.updating == NO) {
        [timer invalidate];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.histories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    LocationEntry* entry = [self.histories objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"[%02d] +%02.1fsec %0.1fm",
                           indexPath.row+1,
                           entry.elapse,
                           entry.location.horizontalAccuracy];
    cell.detailTextLabel.text = [entry subtitleString];

    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationEntry* entry = [self.histories objectAtIndex:indexPath.row];
    [self.mapView setCenterCoordinate:entry.location.coordinate animated:YES];
}

#pragma mark -
#pragma mark Event handler
- (void)didTapMapView:(id)sender
{
    [self.textField resignFirstResponder];
}

- (void)stopUpdating
{
    [self.locationManager stopUpdatingLocation];

    [self.log appendString:@"\n\n"];

    [self saveLog];
    
#ifdef SEND_LOG
    self.startButton.enabled = NO;

    [self sendLog];
#else
    [self didFinish];
#endif
}

- (IBAction)onClickStartStopButton:(id)sender
{
    if (self.updating) {
        // stop updating
        [self stopUpdating];
        return;
    }
    
    // start updating
    self.updating = YES;
    self.count = 1;

    [self.textField resignFirstResponder];
    NSString* title = self.textField.text;
    if (title == nil || [title length] == 0) {
        title = @"(no title)";
    }
    self.log = [NSMutableString string];
    [self.log appendString:@"----------------------------------------------------------------------\n"];
    [self.log appendFormat:@"[%@] %@\n",
                [self.dateFormatter stringFromDate:[NSDate date]],
                title];
    [self.log appendString:@"----------------------------------------------------------------------\n"];

    [self.startButton setTitle:@"stop" forState:UIControlStateNormal];
    
    self.timeoutSlider.enabled = NO;
    self.accuracySelector.enabled = NO;
    [self.mapView removeAnnotations:self.histories];
    [self.mapView removeOverlays:self.circles];
    [self.histories removeAllObjects];
    [self.circles removeAllObjects];
    [self.tableView reloadData];
    
    [self performSelector:@selector(stopUpdating) withObject:nil afterDelay:self.timeoutSec];
    [self.locationManager startUpdatingLocation];
    self.startDate = [NSDate date];
    [self.indicatorView startAnimating];

    [self.log appendFormat:@"time: %d[sec]\n", self.timeoutSec];
    NSLog(@"time: %d[sec]\n", self.timeoutSec);

    NSString* accuracy;
    switch (self.accuracySelector.selectedSegmentIndex) {
        case 0:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            accuracy = @"Best (kCLLocationAccuracyBest)";
            break;
        case 1:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            accuracy = @"10m (kCLLocationAccuracyNearestTenMeters)";
            break;
        case 2:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            accuracy = @"100m (kCLLocationAccuracyHundredMeters)";
            break;
        case 3:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
            accuracy = @"1km (kCLLocationAccuracyKilometer)";
            break;
        case 4:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
            accuracy = @"3km (kCLLocationAccuracyThreeKilometers)";
            break;
        case 5:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            accuracy = @"Best for navi.(kCLLocationAccuracyBestForNavigation)";
            break;
    }
    [self.log appendFormat:@"desiredAccuracy: %@\n", accuracy];
    NSLog(@"desiredAccuracy: %@", accuracy);
    
    FBNetworkReachabilityConnectionMode mode = self.reachability.connectionMode;
    NSString* network;
    switch (mode) {
        case FBNetworkReachableNon:
            network = @"non";
            break;
            
        case FBNetworkReachableWiFi:
            network = @"WiFi";
            break;
            
        case FBNetworkReachableWWAN:
            network = @"WAN";
            break;
            
        default:
            network = @"?";
            break;
    }
    [self.log appendFormat:@"Network: %@\n", network];    
    NSLog(@"Network: %@", network);
    [self.log appendString:@"\n"];
    [self.log appendString:@"no,elapse[sec],accuracy[m],latitude,longitude\n"];
    [self.log appendString:@"---------------------------------------------\n"];
    
    self.statusLabel.text = @"Updating...";
    
    self.elapseSec = 0;
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(didFire:)
                                   userInfo:nil
                                    repeats:YES];
    self.timerCount.text = [NSString stringWithFormat:@"%d", self.elapseSec];
}

- (IBAction)didChangeAccuracySelector:(id)sender {
}

- (IBAction)didChangeTimtoutSlider:(id)sender {
    self.timeoutSec = (NSInteger)self.timeoutSlider.value;
}


#pragma mark -
#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    static BOOL initLocation_ = NO;

    /*
     // skip old cached location
    NSTimeInterval interval = -[newLocation.timestamp timeIntervalSinceNow];
    if (interval > 5.0) {
        NSLog(@"... location is old|timestamp=%@", [self.dateFormatter stringFromDate:newLocation.timestamp]);
        return;
    }
    */

    LocationEntry* entry = [LocationEntry locationEntryWithLocation:newLocation order:count startDate:self.startDate];

    [self.histories addObject:entry];
    [self.tableView reloadData];
    [self.mapView addAnnotation:entry];
    NSLog(@"%@", [entry logString]);
    
    [self.log appendFormat:@"%@\n", [entry logString]];

    if (!initLocation_) {
        MKCoordinateSpan span = MKCoordinateSpanMake(0.002, 0.002);
        MKCoordinateRegion coordinateRegion =
            MKCoordinateRegionMake(newLocation.coordinate, span);
        [self.mapView setRegion:coordinateRegion animated:YES]; 
        initLocation_ = YES;
    } else {
        [self.mapView setCenterCoordinate:newLocation.coordinate animated:YES];
    }
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.histories count]-1
                                                              inSection:0]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];

    MKCircle *circle = [MKCircle circleWithCenterCoordinate:newLocation.coordinate
                                                     radius:newLocation.horizontalAccuracy];
    [self.mapView addOverlay:circle];
    [self.circles addObject:circle];
    
    
    self.count++;
}


#pragma mark -
#pragma mark MKMapViewDelegate
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleView *view = [[[MKCircleView alloc] initWithCircle:overlay]
                          autorelease];
    view.strokeColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    view.lineWidth = 0.5;
    view.fillColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.05];
    return view;

}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"%@", view);
}
@end
