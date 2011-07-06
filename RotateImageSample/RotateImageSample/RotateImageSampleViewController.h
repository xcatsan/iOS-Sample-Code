//
//  RotateImageSampleViewController.h
//  RotateImageSample
//
//  Created by Hiroshi Hashiguchi on 11/07/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RotateImageSampleViewController : UIViewController {
    
    UIImageView *imageView;
    CGFloat angle_;
    UIButton *button;
}
- (IBAction)start:(id)sender;
@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) IBOutlet UIImageView* imageView; 

@end
