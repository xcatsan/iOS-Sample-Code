//
//  ViewController.h
//  CameraSample
//
//  Created by Hiroshi Hashiguchi on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) AVCaptureSession* captureSession;
@property (nonatomic, strong) AVCaptureStillImageOutput* imageOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;
@property (nonatomic) BOOL adjustingExposure;

@property (nonatomic, strong) CALayer* indicatorLayer;

- (void)setPoint:(CGPoint)p;

@end
