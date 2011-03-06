//
//  ftsSampleAppDelegate.h
//  ftsSample
//
//  Created by 橋口 湖 on 11/03/04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ftsSampleAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)setupDirectories;
- (IBAction)fts;
- (IBAction)stdlib;
- (IBAction)cocoa;

@end
