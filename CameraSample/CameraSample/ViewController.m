//
//  ViewController.m
//  CameraSample
//
//  Created by Hiroshi Hashiguchi on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"

@implementation ViewController
@synthesize captureSession, imageOutput, previewLayer, adjustingExposure;
@synthesize indicatorLayer;

#define INDICATOR_RECT_SIZE 50.0

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.captureSession = [[AVCaptureSession alloc] init];
    AVCaptureDevice* videoCaptureDevice =
        [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError* error = nil;
    AVCaptureDeviceInput* videoInput =
    [AVCaptureDeviceInput deviceInputWithDevice:videoCaptureDevice
                                          error:&error];
    if (videoInput) {
        [self.captureSession addInput:videoInput];
        [self.captureSession beginConfiguration];
        self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
        [self.captureSession commitConfiguration];
        
        NSError* error = nil;
        if ([videoCaptureDevice lockForConfiguration:&error]) {
            if ([videoCaptureDevice isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                videoCaptureDevice.focusMode = AVCaptureFocusModeContinuousAutoFocus;
                
            } else if ([videoCaptureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
                videoCaptureDevice.focusMode = AVCaptureFocusModeAutoFocus;
            }
            
            if ([videoCaptureDevice isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
                videoCaptureDevice.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
            } else if ([videoCaptureDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
                videoCaptureDevice.exposureMode = AVCaptureExposureModeAutoExpose;
            }
            
            if ([videoCaptureDevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance]) {
                videoCaptureDevice.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
            } else if ([videoCaptureDevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
                videoCaptureDevice.whiteBalanceMode = AVCaptureWhiteBalanceModeAutoWhiteBalance;
            }
            
            if ([videoCaptureDevice isFlashModeSupported:AVCaptureFlashModeAuto]) {
                videoCaptureDevice.flashMode = AVCaptureFlashModeAuto;
            }
            
            [videoCaptureDevice unlockForConfiguration];
            
            [videoCaptureDevice addObserver:self
                                 forKeyPath:@"adjustingExposure"
                                    options:NSKeyValueObservingOptionNew
                                    context:nil];
            
        } else {
            NSLog(@"%s|[ERROR] %@", __PRETTY_FUNCTION__, error);
        }
        
        self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
        [self.captureSession addOutput:self.imageOutput];
        for (AVCaptureConnection* connection in self.imageOutput.connections) {
            connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        }
        
        self.previewLayer =
            [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        self.previewLayer.automaticallyAdjustsMirroring = NO;
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.previewLayer.frame = self.view.bounds;
        [self.view.layer addSublayer:self.previewLayer];
     
        [self.captureSession startRunning];

        // add layer
        self.indicatorLayer = [CALayer layer];
        self.indicatorLayer.borderColor = [[UIColor whiteColor] CGColor];
        self.indicatorLayer.borderWidth = 1.0;
        self.indicatorLayer.frame = CGRectMake(self.view.bounds.size.width/2.0 - INDICATOR_RECT_SIZE/2.0,
                                               self.view.bounds.size.height/2.0 - INDICATOR_RECT_SIZE/2.0,
                                               INDICATOR_RECT_SIZE,
                                               INDICATOR_RECT_SIZE);
        self.indicatorLayer.hidden = NO;
        [self.view.layer addSublayer:self.indicatorLayer];

        
        // add gesture
        UIGestureRecognizer* gr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(didTapGesture:)];
        [self.view addGestureRecognizer:gr];
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



// added

- (void)setPoint:(CGPoint)p
{
    CGSize viewSize = self.view.bounds.size;
    CGPoint pointOfInterest = CGPointMake(p.y / viewSize.height,
                                          1.0 - p.x / viewSize.width);

    AVCaptureDevice* videoCaptureDevice =
    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError* error = nil;
    if ([videoCaptureDevice lockForConfiguration:&error]) {
        
        if ([videoCaptureDevice isFocusPointOfInterestSupported] &&
            [videoCaptureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            videoCaptureDevice.focusPointOfInterest = pointOfInterest;
            videoCaptureDevice.focusMode = AVCaptureFocusModeAutoFocus;
        }
        
        if ([videoCaptureDevice isExposurePointOfInterestSupported] &&
            [videoCaptureDevice isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]){
            self.adjustingExposure = YES;
            videoCaptureDevice.exposurePointOfInterest = pointOfInterest;
            videoCaptureDevice.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        }
        
        [videoCaptureDevice unlockForConfiguration];
    } else {
        NSLog(@"%s|[ERROR] %@", __PRETTY_FUNCTION__, error);        
    }

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!self.adjustingExposure) {
        return;
    }
    
	if ([keyPath isEqual:@"adjustingExposure"]) {
		if ([[change objectForKey:NSKeyValueChangeNewKey] boolValue] == NO) {
            self.adjustingExposure = NO;
            AVCaptureDevice* videoCaptureDevice =
            [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            
			NSError *error = nil;
			if ([videoCaptureDevice lockForConfiguration:&error]) {
                NSLog(@"%s|%@", __PRETTY_FUNCTION__, @"locked!");
				[videoCaptureDevice setExposureMode:AVCaptureExposureModeLocked];
				[videoCaptureDevice unlockForConfiguration];
			}
		}
	}
}


- (void)didTapGesture:(UITapGestureRecognizer*)tgr
{
    CGPoint p = [tgr locationInView:tgr.view];
    self.indicatorLayer.frame = CGRectMake(p.x - INDICATOR_RECT_SIZE/2.0,
                                           p.y - INDICATOR_RECT_SIZE/2.0,
                                           INDICATOR_RECT_SIZE,
                                           INDICATOR_RECT_SIZE);
    [self setPoint:p];
}


@end
