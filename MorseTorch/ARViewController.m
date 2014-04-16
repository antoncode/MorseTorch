//
//  ARViewController.m
//  MorseTorch
//
//  Created by Anton Rivera on 4/14/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARViewController.h"
#import "NSString+NSStringDisplayMorseCode.h"
#import <AVFoundation/AVFoundation.h>

@interface ARViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *morseText;
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (nonatomic, weak) UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UILabel *charBeingSent;

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _morseText.delegate = self;
    _inputText.delegate = self;
}

- (IBAction)convertInputToMorse:(id)sender
{
    _convertButton = sender;
    _convertButton.enabled = NO;
    
    NSString *inputString = _inputText.text;
    NSString *tempString = [NSString new];
    
    tempString = [inputString convertStringToMorseCode:inputString];

    _morseText.text = tempString;
    
    [self convertMorseCodeToFlashes:tempString];
}

- (void)convertMorseCodeToFlashes:(NSString *)morseCode
{
    NSLog(@"%@", morseCode);
    
    AVCaptureDevice *myDevice = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
    
    NSOperationQueue *flashQueue = [NSOperationQueue new];
    [flashQueue setMaxConcurrentOperationCount:1];

    if ([myDevice hasTorch])
    {
        for (int i=0; i < morseCode.length; i++)
        {
            [flashQueue addOperationWithBlock:^{
                if ([[NSString stringWithFormat:@"%c",[morseCode characterAtIndex:i]] isEqualToString:@"."])
                {
                    [myDevice lockForConfiguration:nil];
                    [myDevice setTorchMode:AVCaptureTorchModeOn];
                    [myDevice unlockForConfiguration];
                    
                    usleep(100000);
                    
                    [myDevice lockForConfiguration:nil];
                    [myDevice setTorchMode:AVCaptureTorchModeOff];
                    [myDevice unlockForConfiguration];
                } else if ([[NSString stringWithFormat:@"%c",[morseCode characterAtIndex:i]] isEqualToString:@"-"]) {
                    [myDevice lockForConfiguration:nil];
                    [myDevice setTorchMode:AVCaptureTorchModeOn];
                    [myDevice unlockForConfiguration];
                    
                    usleep(300000);
                    
                    [myDevice lockForConfiguration:nil];
                    [myDevice setTorchMode:AVCaptureTorchModeOff];
                    [myDevice unlockForConfiguration];
                } else if ([[NSString stringWithFormat:@"%c",[morseCode characterAtIndex:i]] isEqualToString:@" "]) {
                    usleep(100000);
                }
            }];
        }
    }
    [flashQueue addOperationWithBlock:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            _convertButton.enabled = YES;
        }];
    }];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // Return dismisses keyboard
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // dismiss keyboard when user taps anywhere on the screen
    [self.view endEditing:YES];
}

@end
