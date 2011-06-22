//
//  ftsSampleAppDelegate.m
//  ftsSample
//
//

#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fts.h>
#include <dirent.h>
#include <mach/mach.h>

#import "ftsSampleAppDelegate.h"

@implementation ftsSampleAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    NSLog(@"%@", [self path]);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (u_int)getMemory
{
    struct task_basic_info t_info;
    mach_msg_type_number_t t_info_count = TASK_BASIC_INFO_COUNT;
    
    if (task_info(current_task(), TASK_BASIC_INFO, (task_info_t)&t_info, &t_info_count)!= KERN_SUCCESS)
    {
        NSLog(@"%s(): Error in task_info(): %s",
              __FUNCTION__, strerror(errno));
    }
    
    u_int rss = t_info.resident_size;
    u_int vs = t_info.virtual_size;
    
//    NSLog(@"Memory: %u Bytes, VS: %u Bytes.", rss, vs);
    
    return rss;
}


- (NSString*)path
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

int countOfDirectories;
int countOfFiles;

#define BUFF_SIZE   1024
- (void)makeDirLevel:(int)level path:(NSString*)path
{
    int i, j;
    level--;
    char buff[BUFF_SIZE];
    for (i=0; i < 10; i++) {
        NSString* dirname = [NSString stringWithFormat:@"%02d", i];
        NSString* dirPath = [path stringByAppendingPathComponent:dirname];
        mkdir([dirPath cStringUsingEncoding:NSUTF8StringEncoding], 0777);
        countOfDirectories++;
        if (level == 0) {
            for (j=0; j < 10; j++) {
                NSString* filePath = [dirPath stringByAppendingPathComponent:
                                      [NSString stringWithFormat:@"file-%02d", j]];                
                FILE* file = fopen([filePath cStringUsingEncoding:NSUTF8StringEncoding], "w");
                fwrite(buff, sizeof(char), BUFF_SIZE, file);
                fclose(file);
                countOfFiles++;
            }
        } else {
            [self makeDirLevel:level path:dirPath];
        }
    }
}

- (IBAction)setupDirectories
{
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    countOfDirectories = 0;
    countOfFiles = 0;
    NSLog(@"[setup] creating....");
    [self makeDirLevel:3 path:[self path]];
    NSLog(@"[setup] finished.");
    NSLog(@"[setup] elapse: %f", [NSDate timeIntervalSinceReferenceDate] - start);
    NSLog(@"[setup] dirs: %d, files: %d", countOfDirectories, countOfFiles);
}


int cmpare(const FTSENT **a, const FTSENT **b)
{
    return (-strcasecmp((*a)->fts_name, (*b)->fts_name));
}

int _compareWithLastAccessTime(const FTSENT **a, const FTSENT **b)
{
    __darwin_time_t atime1 = (*a)->fts_statp->st_atimespec.tv_sec;
    __darwin_time_t atime2 = (*b)->fts_statp->st_atimespec.tv_sec;
    
    if (atime1 < atime2) {
        return -1;
    } else if (atime1 > atime2) {
        return 1;
    } else {
        return 0;   // equals
    }
}

- (IBAction)fts
{
    u_int start_m = [self getMemory];
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    int count = 0;
    int size = 0;
    FTS* fts;
    FTSENT *entry;
    char* paths[] = {
        [[self path] cStringUsingEncoding:NSUTF8StringEncoding], NULL
    };
//    fts = fts_open(paths, 0, cmpare);
//    fts = fts_open(paths, 0, NULL);
    fts = fts_open(paths, 0, _compareWithLastAccessTime);
    while ((entry = fts_read(fts))) {
//        NSLog(@"%s", entry->fts_path);
        if (entry->fts_info & FTS_DP || entry->fts_level == 0) {
            // ignore post-order
            continue;
        }
        if (entry->fts_info & FTS_F) {
            NSLog(@"%s", entry->fts_path);
            count++;
            size += entry->fts_statp->st_size;
        }
    }
    fts_close(fts);
    
    NSLog(@"[fts] elapse: %f", [NSDate timeIntervalSinceReferenceDate] - start);
    NSLog(@"[fts] count : %d", count);
    NSLog(@"[fts] size  : %d", size);

    u_int end_m = [self getMemory];
    NSLog(@"[fts] memory: %u",  (end_m-start_m)/1024);
}

int countStdlib;
int sizeStdlib;
void countdir(const char* path) {
    DIR* dir = opendir(path);
    struct dirent* ent;
    struct stat buf;
    
    char newPath[4096];
    if (dir) {
        for(;;) {
            if ((ent = readdir(dir)) == NULL) {
                break;
            }
            strcpy(newPath, path);
            strcat(newPath, "/");
            strcat(newPath, ent->d_name);

            if (ent->d_type == DT_DIR) {
                if (strcmp(ent->d_name, ".") && strcmp(ent->d_name, "..")) {
                    countdir(newPath);
                }
            } else {
                // file
                stat(newPath, &buf);
                sizeStdlib += buf.st_size;
                countStdlib++;
            }
        }
    }
    closedir(dir);
}

- (IBAction)stdlib
{
    u_int start_m = [self getMemory];
    countStdlib = 0;
    sizeStdlib = 0;

    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    countdir([[self path] cStringUsingEncoding:NSUTF8StringEncoding]);
    NSLog(@"[stdlib] elapse: %f", [NSDate timeIntervalSinceReferenceDate] - start);
    NSLog(@"[stdlib] count : %d", countStdlib);    
    NSLog(@"[stdlib] size  : %d", sizeStdlib);    
 
    u_int end_m = [self getMemory];
    NSLog(@"[stdlib] memory: %u",  (end_m-start_m)/1024);
}

/*
- (IBAction)cocoa
{
    u_int start_m = [self getMemory];
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    NSArray* array = [fileManager subpathsOfDirectoryAtPath:[self path]
                                                      error:&error];
    NSLog(@"[cocoa] elapse: %f", [NSDate timeIntervalSinceReferenceDate] - start);
    NSLog(@"[cocoa] count : %d", [array count]);   
    
    u_int end_m = [self getMemory];
    NSLog(@"[stdlib] memory: %u", start_m - end_m);
}
*/

- (IBAction)cocoa
{
    u_int start_m = [self getMemory];
    NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];

    int count = 0;
    int size = 0;
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    NSString* path = [self path];

    for (NSString* filename in [fileManager enumeratorAtPath:[self path]]) { 
        NSDictionary* attributes = [fileManager
            attributesOfItemAtPath:[path stringByAppendingPathComponent:filename]
                                    error:&error];
        if ([[attributes objectForKey:NSFileType] isEqualToString:NSFileTypeRegular]) {
            count++;
            size += [[attributes objectForKey:NSFileSize] intValue];
        }
    }
    NSLog(@"[cocoa] elapse: %f", [NSDate timeIntervalSinceReferenceDate] - start);
    NSLog(@"[cocoa] count : %d", count);    
    NSLog(@"[cocoa] size  : %d", size);

    u_int end_m = [self getMemory];
    NSLog(@"[cocoa] memory: %u",  (end_m-start_m)/1024);
}

@end
