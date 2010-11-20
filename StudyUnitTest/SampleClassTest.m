//
//  SampleClassTest.m
//  StudyUnitTest
//
//  Created by Hiroshi Hashiguchi on 10/11/20.
//  Copyright 2010 . All rights reserved.
//

#import "SampleClassTest.h"
#import "SampleClass.h"


@implementation SampleClassTest

- (void)setUp
{
	counter_ = 100;
}

- (void)testGreeting
{
	counter_++;
	SampleClass* obj = [[[SampleClass alloc] init] autorelease];
	STAssertTrue([[obj greeting] isEqualToString:@"x"],
				 @"counter=%d, %x", counter_, self);
}

- (void)testFirst
{
	counter_++;
	STAssertTrue(NO, @"counter=%d, %x", counter_, self);
}

/*
#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void) testAppDelegate {
    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
    
}

#else                           // all code under test must be linked into the Unit Test bundle

- (void) testMath {
    
    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );
    
}

#endif
 */


@end
