//
//  main.m
//  AutoreleasePoolTest
//
//  Created by Hiroshi Hashiguchi on 10/10/15.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
