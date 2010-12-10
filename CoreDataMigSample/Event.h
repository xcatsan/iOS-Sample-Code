//
//  Event.h
//  CoreDataMigSample
//
//  Created by Hiroshi Hashiguchi on 10/12/10.
//  Copyright 2010 . All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Event :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * memo;
@property (nonatomic, retain) NSNumber * month;
@property (nonatomic, retain) NSNumber * day;


@end



