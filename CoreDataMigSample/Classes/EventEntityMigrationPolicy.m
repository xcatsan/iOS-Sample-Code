//
//  EventEntityMigrationPolicy.m
//  CoreDataMigSample
//
//  Created by Hiroshi Hashiguchi on 10/12/10.
//  Copyright 2010 . All rights reserved.
//

#import "EventEntityMigrationPolicy.h"


@implementation EventEntityMigrationPolicy

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


- (BOOL)beginEntityMapping:(NSEntityMapping *)mapping manager:(NSMigrationManager *)manager error:(NSError **)error
{
	NSLog(@"Begin migration");
	return YES;
}
- (BOOL)endEntityMapping:(NSEntityMapping *)mapping manager:(NSMigrationManager *)manager error:(NSError **)error
{
	[timer_ invalidate];
	[alertView_ dismissWithClickedButtonIndex:0
									 animated:YES];

	NSLog(@"End migration");
	return YES;
}

/*

- (BOOL)createDestinationInstancesForSourceInstance:(NSManagedObject *)sInstance entityMapping:(NSEntityMapping *)mapping manager:(NSMigrationManager *)manager error:(NSError **)error
{
	NSManagedObjectContext* context = [manager destinationContext];
	NSString *entityName = [mapping destinationEntityName];
	
	NSDate *timeStamp = [sInstance valueForKey:@"timeStamp"];
	
	NSCalendar* calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSDateComponents* components = [calendar components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:timeStamp];

	NSManagedObject* dInstance = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];

	[dInstance setValue:timeStamp forKey:@"timeStamp"];
	[dInstance setValue:[NSNumber numberWithInt:[components month]] forKey:@"month"];
	[dInstance setValue:[NSNumber numberWithInt:[components day]] forKey:@"day"];
	[dInstance setValue:@"Good morning!" forKey:@"memo"];
	
	return YES;
}
*/

@end
