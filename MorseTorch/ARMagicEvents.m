//
//  ARMagicEvents.m
//  MorseTorch
//
//  Created by Anton Rivera on 4/17/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARMagicEvents.h"
#import <AVFoundation/AVFoundation.h>
#import "ARReceiverViewController.h"

#define NUMBER_OF_FRAME_PER_S 120
#define BRIGHTNESS_THRESHOLD 90
#define MIN_BRIGHTNESS_THRESHOLD 10

@interface ARMagicEvents() <AVCaptureAudioDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic) int lastTotalBrightnessValue, brightnessThreshold;
@property (nonatomic) BOOL started;
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) ARReceiverViewController *receiverViewController;

@end

@implementation ARMagicEvents

#pragma mark - init

- (id)init
{
    if ((self = [super init])) {
        [self initMagicEvents];
    }
    return self;
}

- (void)initMagicEvents
{
    _started = NO;
    _brightnessThreshold = BRIGHTNESS_THRESHOLD;
    
    [NSThread detachNewThreadSelector:@selector(initCapture) toTarget:self withObject:nil];
}

- (void)initCapture
{
    // 1. Setup AVCaptureDevice
    _captureDevice = [self searchForBackCameraIfAvailable];
    
    // 2. Setup AVCaptureDeviceInput
    NSError *error = nil;
    _videoInput = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    if ( ! _videoInput)
    {
        NSLog(@"Could not get video input: %@", error);
        return;
    }
    
    // 3. Setup AVCaptureSession
    _captureSession = [AVCaptureSession new];
    _captureSession.sessionPreset = AVCaptureSessionPresetLow;

    // 4. Add AVCaptureDeviceInput to AVCaptureSession
    [_captureSession addInput:_videoInput];
    
    // 5. Create an AVCAptureVideoPreviewLayer (hint: layerWithSession:)
//    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    // 6./7. Setup AVCAptureDeviceOutput, add to AVCaptureSession
    _videoDataOutput = [AVCaptureVideoDataOutput new];
    [_captureSession addOutput:_videoDataOutput];
    
//    // 8. Add your preview layer to a layer of a view on your screen
//    _receiverViewController = [ARReceiverViewController new];
//    _receiverViewController.videoView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, 240, 168)];
//    CALayer *cameraLayer = _receiverViewController.videoView.layer;
//    _receiverViewController.videoView.backgroundColor = [UIColor clearColor];
//    [cameraLayer setMasksToBounds:YES];
//    previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:_captureSession];
//    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//    [previewLayer setFrame:[cameraLayer bounds]];
//    [cameraLayer addSublayer:previewLayer];

    // Configure your output
    dispatch_queue_t queue = dispatch_queue_create("myQueue", NULL);
    [_videoDataOutput setSampleBufferDelegate:(id)self queue:queue];
    
    // Specify the pixel format; this is essentially a template
    NSDictionary *settings = [[NSDictionary alloc] initWithObjectsAndKeys:
                              [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA],
                              kCVPixelBufferPixelFormatTypeKey, nil];
    _videoDataOutput.videoSettings = settings;
    
//    //configure device
//    [_device lockForConfiguration:nil]; //lock device for configuration
//    [_device setExposureMode:AVCaptureExposureModeLocked];
//    [_device setActiveVideoMinFrameDuration:CMTimeMake(1, 10)]; //configure device framerate
//    [_device unlockForConfiguration]; //unlock device for configuration
    
//    AVCaptureConnection *conn = [_videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
//    if (conn.isVideoMinFrameDurationSupported)
//        conn.videoMinFrameDuration = CMTimeMake(1, NUMBER_OF_FRAME_PER_S);
//    if (conn.isVideoMaxFrameDurationSupported)
//        conn.videoMaxFrameDuration = CMTimeMake(1, NUMBER_OF_FRAME_PER_S);
    
    // 9. Start AVCaptureSession
    [_captureSession startRunning];
    
    _started = YES;
    
}

-(void)updateBrightnessThreshold:(int)pValue
{
    _brightnessThreshold = pValue;
}

-(BOOL)startCapture
{
    if(!_started){
        _lastTotalBrightnessValue = 0;
        [_captureSession startRunning];
        _started = YES;
    }
    return _started;
}

-(BOOL)stopCapture
{
    if(_started){
        [_captureSession stopRunning];
         _started = NO;
    }
    return _started;
}

#pragma mark - Delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    if (CVPixelBufferLockBaseAddress(imageBuffer, 0) == kCVReturnSuccess)
    {
        UInt8 *base = (UInt8 *)CVPixelBufferGetBaseAddress(imageBuffer);
        
        //  calculate average brightness in a simple way
        
        size_t bytesPerRow      = CVPixelBufferGetBytesPerRow(imageBuffer);
        size_t width            = CVPixelBufferGetWidth(imageBuffer);
        size_t height           = CVPixelBufferGetHeight(imageBuffer);
        UInt32 totalBrightness  = 0;
        
        for (UInt8 *rowStart = base; height; rowStart += bytesPerRow, height --)
        {
            size_t columnCount = width;
            for (UInt8 *p = rowStart; columnCount; p += 4, columnCount --)
            {
                UInt32 value = (p[0] + p[1] + p[2]);
                totalBrightness += value;
            }
        }
        CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
        
        if(_lastTotalBrightnessValue==0) _lastTotalBrightnessValue = totalBrightness;
        
        if([self calculateLevelOfBrightness:totalBrightness]<_brightnessThreshold)
        {
            if([self calculateLevelOfBrightness:totalBrightness]>MIN_BRIGHTNESS_THRESHOLD)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"onMagicEventDetected" object:nil];
            }
            else //Mobile phone is probably on a table (too dark - camera obturated)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"onMagicEventNotDetected" object:nil];
            }
            //NSLog(@"%d",[self calculateLevelOfBrightness:totalBrightness]);
        }
        else{
            _lastTotalBrightnessValue = totalBrightness;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"onMagicEventNotDetected" object:nil];
        }
    }
}

-(int) calculateLevelOfBrightness:(int) pCurrentBrightness
{
    return (pCurrentBrightness*100) /_lastTotalBrightnessValue;
}

#pragma mark - Helper method

- (AVCaptureDevice *)searchForBackCameraIfAvailable
{
    //  look at all the video devices and get the first one that's on the front
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *captureDevice = nil;
    for (AVCaptureDevice *device in videoDevices)
    {
        if (device.position == AVCaptureDevicePositionBack)
        {
            captureDevice = device;
            break;
        }
    }
    
    //  couldn't find one on the front, so just get the default video device.
    if ( ! captureDevice)
    {
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    return captureDevice;
}
@end
