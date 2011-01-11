//
//  JSONFrameworkSampleViewController.h
//  JSONFrameworkSample
//
//  Created by Hiroshi Hashiguchi on 11/01/11.
//  Copyright 2011 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSONFrameworkSampleViewController : UIViewController {

	UITextView* textView_;
}
@property (nonatomic, retain) IBOutlet 	UITextView* textView;

- (IBAction)parse:(id)sender;

@end

