//
//  SampleModel.m
//  ObjcNewSample
//
//  Created by Hiroshi Hashiguchi on 10/12/08.
//  Copyright 2010 . All rights reserved.
//

#import "SampleModel.h"

@interface SampleModel()
{
	NSString* name;
}
@property (nonatomic, copy) NSString* name;
@end

@implementation SampleModel

-(NSString*)description
{
	return self.name;
}

@end
