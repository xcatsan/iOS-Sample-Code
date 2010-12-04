//
//  IBOutletCollectionSampleViewController.h
//  IBOutletCollectionSample
//
//  Created by Hiroshi Hashiguchi on 10/12/05.
//  Copyright 2010 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBOutletCollectionSampleViewController : UIViewController {

	
	IBOutletCollection (UILabel) NSArray* labels;
	IBOutletCollection (UITextField) NSArray* textFields;
	IBOutletCollection (id) NSArray* stuffs;
}

- (IBAction)dump;
- (IBAction)action;

@end

