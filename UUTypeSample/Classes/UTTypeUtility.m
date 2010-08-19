//
//  UTTypeUtility.m
//  UUTypeSample
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright 2010 . All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import "UTTypeUtility.h"


@implementation UTTypeUtility

#pragma mark -
#pragma mark MIME Type <=> Filename Extension
+ (NSString*)filenameExtensionFromMimeType:(NSString*)mimeTYpe
{
	CFStringRef uti = UTTypeCreatePreferredIdentifierForTag(
		kUTTagClassMIMEType, (CFStringRef)mimeTYpe, NULL);
	
	NSString* filenamExtension =
		(NSString*)UTTypeCopyPreferredTagWithClass(uti, kUTTagClassFilenameExtension);
	
	CFRelease(uti);
	
	return [filenamExtension autorelease];
}

+ (NSString*)mimeTypeFromFilename:(NSString*)filename
{
	return [self mimeTypeFromFilenameExtension:[filename pathExtension]];
}

+ (NSString*)mimeTypeFromFilenameExtension:(NSString*)filenameExtension
{
	CFStringRef uti = UTTypeCreatePreferredIdentifierForTag(
		kUTTagClassFilenameExtension, (CFStringRef)filenameExtension, NULL);
	
	NSString* mimeType =
		(NSString*)UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType);
	
	CFRelease(uti);
	
	return [mimeType autorelease];
}


#pragma mark -
#pragma mark UTI utilities
+ (NSString*)UTIfromMimeType:(NSString*)mimeType
{
	NSString* uti = (NSString*)UTTypeCreatePreferredIdentifierForTag(
		kUTTagClassMIMEType, (CFStringRef)mimeType, NULL);
	return [uti autorelease];
}

+ (NSString*)UTIfromFilename:(NSString*)filename
{
	return [self UTIfromFilenameExtension:[filename pathExtension]];
}

+ (NSString*)UTIfromFilenameExtension:(NSString*)filenameExtension
{
	NSString* uti = (NSString*)UTTypeCreatePreferredIdentifierForTag(
		kUTTagClassFilenameExtension, (CFStringRef)filenameExtension, NULL);
	return [uti autorelease];
}



@end
