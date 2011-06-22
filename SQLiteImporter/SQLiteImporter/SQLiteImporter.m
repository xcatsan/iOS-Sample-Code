//
//  SQLiteImporter.m
//  SQLiteImporter
//
//  Created by Hiroshi Hashiguchi on 11/03/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SQLiteImporter.h"

@interface SQLiteImporter()
@property (nonatomic, copy) NSString* CSVFilename;
@property (nonatomic, copy) NSString* SQLiteFilename;
@end


@implementation SQLiteImporter

@synthesize CSVFilename = CSVFilename_;
@synthesize SQLiteFilename = SQLiteFilename_;

- (id)initWithCSVFile:(NSString*)filename
{
    self = [super init];
    if (self) {
        self.CSVFilename = filename;
        NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"%@", path);
    }
    return self;
}
@end
