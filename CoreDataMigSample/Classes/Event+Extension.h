//
//  Event+Extension.h
//  CoreDataMigSample
//
//  Created by Hiroshi Hashiguchi on 10/12/10.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface Event (Extension) 

// for migration
- (NSNumber*)monthOfDate:(NSDate*)date;
- (NSNumber*)dayOfDate:(NSDate*)date;


@end
