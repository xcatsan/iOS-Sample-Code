//
//  UUTypeSampleViewController.h
//  UUTypeSample
//
//  Created by Hiroshi Hashiguchi on 10/08/12.
//  Copyright  2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UUTypeSampleViewController : UIViewController {

	UITextField* mimeType;
	UITextField* extension;
	UILabel* uti;
}
@property (nonatomic, retain) IBOutlet UITextField* mimeType;
@property (nonatomic, retain) IBOutlet UITextField* extension;
@property (nonatomic, retain) IBOutlet UILabel* uti;

-(IBAction)mimeToExtension:(id)sender;
-(IBAction)extensionToMime:(id)sender;
@end

