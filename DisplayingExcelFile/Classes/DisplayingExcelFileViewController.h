//
//  DisplayingExcelFileViewController.h
//  DisplayingExcelFile
//
//  Created by Hiroshi Hashiguchi on 10/12/31.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayingExcelFileViewController : UIViewController {

	UIWebView* webView_;
}
@property (nonatomic, retain) IBOutlet 	UIWebView* webView;

- (IBAction)load:(id)sender;
- (IBAction)load2:(id)sender;
- (IBAction)load3:(id)sender;
- (IBAction)load4:(id)sender;
- (IBAction)load5:(id)sender;
- (IBAction)load6:(id)sender;
- (IBAction)load7:(id)sender;
- (IBAction)dumpCache:(id)sender;
@end

