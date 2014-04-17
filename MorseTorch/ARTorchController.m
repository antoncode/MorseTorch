//
//  ARTorchController.m
//  MorseTorch
//
//  Created by Anton Rivera on 4/16/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARTorchController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+NSStringDisplayMorseCode.h"

@interface ARTorchController ()

@property (nonatomic, strong) NSOperationQueue *flashQueue;

@end

@implementation ARTorchController

- (id)init
{
    self = [super init];
    
    if (self) {
        _flashQueue = [NSOperationQueue new];
        [_flashQueue setMaxConcurrentOperationCount:1];
    }
    
    return self;
}

- (void)cancel
{
    [_flashQueue cancelAllOperations];
}

- (void) convertStringToFlashes:(NSString *)inputString;
{
    NSString *charMorseCode = [NSString new];
    for (int i=0; i<inputString.length; i++)
    {
        [_flashQueue addOperationWithBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.delegate displayNewLetter:[NSString stringWithFormat:@"%c",[inputString characterAtIndex:i]]];
            }];
        }];

        charMorseCode = [[NSString stringWithFormat:@"%c",[inputString characterAtIndex:i]] convertToMorseCode];
        [self convertMorseCodeToFlashes:charMorseCode];
    }
    
    [_flashQueue addOperationWithBlock:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.delegate finished];
        }];
    }];
}

- (void)convertMorseCodeToFlashes:(NSString *)morseCodeString
{
    AVCaptureDevice *myDevice = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
    
    if ([myDevice hasTorch])
    {
        for (int i=0; i < morseCodeString.length; i++)
        {
            [_flashQueue addOperationWithBlock:^{
                if ([[NSString stringWithFormat:@"%c",[morseCodeString characterAtIndex:i]] isEqualToString:@"."])
                {
                    [myDevice lockForConfiguration:nil];
                    [myDevice setTorchMode:AVCaptureTorchModeOn];
                    [myDevice unlockForConfiguration];
                    
                    usleep(100000);
                    
                    [myDevice lockForConfiguration:nil];
                    [myDevice setTorchMode:AVCaptureTorchModeOff];
                    [myDevice unlockForConfiguration];
                } else if ([[NSString stringWithFormat:@"%c",[morseCodeString characterAtIndex:i]] isEqualToString:@"-"])
                {
                    [myDevice lockForConfiguration:nil];
                    [myDevice setTorchMode:AVCaptureTorchModeOn];
                    [myDevice unlockForConfiguration];
                    
                    usleep(300000);
                    
                    [myDevice lockForConfiguration:nil];
                    [myDevice setTorchMode:AVCaptureTorchModeOff];
                    [myDevice unlockForConfiguration];
                } else if ([[NSString stringWithFormat:@"%c",[morseCodeString characterAtIndex:i]] isEqualToString:@" "])
                {
                    usleep(100000);
                }
            }];
        }
    }
}

@end
