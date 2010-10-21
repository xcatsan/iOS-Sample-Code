//
//  SimpleAnnotation.h
//  CoreLocationSample
//
//  Created by Hiroshi Hashiguchi on 10/10/21.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SimpleAnnotation : NSObject <MKAnnotation>{

	CLLocation* location_;
	NSString* title_;
}
@property (nonatomic, copy) CLLocation* location;
@property (nonatomic, retain) NSString* title;

@end
