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

- (void)load:(id)sender;

@end

