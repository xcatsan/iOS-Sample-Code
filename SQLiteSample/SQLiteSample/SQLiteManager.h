//
//  SQLiteManager.h
//  SQLiteSample
//
//  Created by Hiroshi Hashiguchi on 11/04/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <sqlite3.h>

#import <Foundation/Foundation.h>


@interface SQLiteManager : NSObject {
    
    sqlite3* db_;
}

+ (SQLiteManager*)sharedManager;

@end
