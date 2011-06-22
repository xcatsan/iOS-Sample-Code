//
//  SQLiteManager.m
//  SQLiteSample
//
//  Created by Hiroshi Hashiguchi on 11/04/19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "SQLiteManager.h"

#define DBNAME  @"access_log.db"


static SQLiteManager* sharedManager_;

@implementation SQLiteManager

- (NSString*)_dbPath
{
    NSString* basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbPath = [basePath stringByAppendingPathComponent:DBNAME];
    return dbPath;
}

- (BOOL)_setupDB
{
    BOOL result = NO;
    NSString* dbPath = [self _dbPath];
    NSFileManager* fileManager = [NSFileManager defaultManager];

    NSLog(@"dbPath: %@", dbPath);
    
    if (![fileManager fileExistsAtPath:dbPath]) {
        
        NSError* error = nil;
        NSString* templatePath = [[NSBundle mainBundle] pathForResource:DBNAME ofType:nil];
        NSLog(@"templatePath: %@", templatePath);
        
        if ([fileManager copyItemAtPath:templatePath toPath:dbPath error:&error]) {
            result = YES;
        } else {
            NSLog(@"%s|[ERROR] Can not copy the template db '%@'|%@",
                  __PRETTY_FUNCTION__, templatePath, error);
        }
    }
    return result;
}

- (sqlite3*)_openDB
{
    sqlite3* db = NULL;
    NSString* dbPath = [self _dbPath];
    if (sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK) {
        
    }
    return db;
}


- (id)init {
    self = [super init];
    if (self) {
        [self _setupDB];
        db_ = [self _openDB];
        
        NSLog(@"sqlite3_threadsafe: %d", sqlite3_threadsafe());
    }
    return self;
}
- (void)dealloc {
    if (db_) {
        sqlite3_close(db_);
    }
    [super dealloc];
}


+ (SQLiteManager*)sharedManager
{
    if (sharedManager_ == nil) {
        sharedManager_ = [[SQLiteManager alloc] init];
    }
    return sharedManager_;
}

@end
