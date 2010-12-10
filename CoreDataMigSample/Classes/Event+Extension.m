//
//  Event+Extension.m
//  CoreDataMigSample
//
//  Created by Hiroshi Hashiguchi on 10/12/10.
//  Copyright 2010 . All rights reserved.
//

#import "Event+Extension.h"


@implementation Event (Extension)

- (NSNumber*)monthOfDate:(NSDate*)date
{
	NSCalendar* calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSDateComponents* components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
	return [NSNumber numberWithInteger:[components month]];
}
- (NSNumber*)dayOfDate:(NSDate*)date
{	
	NSCalendar* calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSDateComponents* components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
	return [NSNumber numberWithInteger:[components day]];
}


@end
