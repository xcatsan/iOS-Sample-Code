//
//  SQLiteImporter.h
//  SQLiteImporter
//
//  Created by Hiroshi Hashiguchi on 11/03/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SQLiteImporter : NSObject {

    NSString* CSVFilename_;
    NSString* SQLiteFilename_;
}

@property (nonatomic, copy, readonly) NSString* CSVFilename;
@property (nonatomic, copy, readonly) NSString* SQLiteFilename;

- (id)initWithCSVFile:(NSString*)filename;

@end
