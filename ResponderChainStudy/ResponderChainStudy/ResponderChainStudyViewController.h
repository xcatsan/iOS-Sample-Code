//
//  ResponderChainStudyViewController.h
//  ResponderChainStudy
//
//  Created by Hiroshi Hashiguchi on 11/06/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResponderChainStudyViewController : UIViewController {
    
    UIButton *button;
    UIButton *button2;
}
@property (nonatomic, retain) IBOutlet UIButton *button;
- (IBAction)display:(id)sender;
@property (nonatomic, retain) IBOutlet UIButton *button2;

@end
