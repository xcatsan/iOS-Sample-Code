//
//  UTTypeUtility.h
//  UUTypeSample
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright 2010 . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UTTypeUtility : NSObject {

}

+ (NSString*)filenameExtensionFromMimeType:(NSString*)mimeType;
+ (NSString*)mimeTypeFromFilename:(NSString*)filename;
+ (NSString*)mimeTypeFromFilenameExtension:(NSString*)filenameExtension;

+ (NSString*)UTIfromMimeType:(NSString*)mimeType;
+ (NSString*)UTIfromFilename:(NSString*)filename;
+ (NSString*)UTIfromFilenameExtension:(NSString*)filenameExtension;

@end
