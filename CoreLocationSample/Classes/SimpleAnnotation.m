//
//  SimpleAnnotation.m
//  CoreLocationSample
//
//  Created by Hiroshi Hashiguchi on 10/10/21.
//  Copyright 2010 . All rights reserved.
//

#import <MapKit/MapKit.h>
#import "SimpleAnnotation.h"


@implementation SimpleAnnotation
@synthesize location = location_;

#pragma mark -
#pragma mark MKAnnotation
- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

- (NSString*)title
{
    return @"Hello!";
}

@end
