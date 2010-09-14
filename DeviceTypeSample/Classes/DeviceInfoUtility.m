//
//  DeviceInfoUtility.m
//  DeviceTypeSample
//
//  Created by Hiroshi Hashiguchi on 10/09/12.
//  Copyright 2010 Hiroshi Hashiguchi. All rights reserved.
//

#import "DeviceInfoUtility.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#define UNKOWN_KEY	@"unkown"

@implementation DeviceInfoUtility


/*
static NSDictionary* deviceList_;
+ (void)initialize
{
	NSString* filePath = [[NSBundle mainBundle] pathForResource:@"DeviceNameList" ofType:@"plist"];
	deviceList_ = [[NSDictionary alloc] initWithContentsOfFile:filePath];
}
*/

+ (NSString *) hwMachine{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *) deviceName {
	NSString* hwMachine = [self hwMachine];
	NSString* filePath = [[NSBundle mainBundle]
						  pathForResource:@"DeviceNameList" ofType:@"plist"];
	NSDictionary* deviceList = [NSDictionary dictionaryWithContentsOfFile:filePath];
	NSString* deviceName = [deviceList objectForKey:hwMachine];

	if (deviceName == nil) {
		deviceName = hwMachine;
	}
	return deviceName;
}


@end
