//
//  ARViewController.m
//  MorseTorch
//
//  Created by Anton Rivera on 4/14/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARSenderViewController.h"
#import "NSString+NSStringDisplayMorseCode.h"
#import <ProgressHUD/ProgressHUD.h>
#import "ARTorchController.h"

@interface ARSenderViewController () <UITextFieldDelegate, ARTorchControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *morseText;
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (nonatomic, strong) UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UILabel *charBeingSent;
@property (nonatomic, strong) ARTorchController *torchController;

@end

@implementation ARSenderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _morseText.delegate = self;
    _inputText.delegate = self;
    
    _charBeingSent.text = @" ";
    
    _torchController = [ARTorchController new];
    _torchController.delegate = self;
}

- (IBAction)convertInputToMorse:(id)sender
{
    NSString *inputString = _inputText.text;
    
    NSString *morseString = [NSString new];
    morseString = [inputString convertStringToMorseCode:inputString];
    _morseText.text = morseString;
    
    [_torchController convertStringToFlashes:inputString];
    
    _convertButton = sender;
    [_convertButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [_convertButton addTarget:self action:@selector(cancelButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)displayNewLetter:(NSString *)newLetter
{
    _charBeingSent.text = newLetter;
    [ProgressHUD show:newLetter];
}

- (void)finished
{
    [ProgressHUD dismiss];
    [_convertButton setTitle:@"Convert to Morse" forState:UIControlStateNormal];
    [_convertButton addTarget:self action:@selector(convertInputToMorse:) forControlEvents:UIControlEventTouchUpInside];
    _charBeingSent.text = @" ";
}

- (void)cancelButton
{
    [_torchController cancel];
    [ProgressHUD dismiss];
    [_convertButton setTitle:@"Convert to Morse" forState:UIControlStateNormal];
    [_convertButton addTarget:self action:@selector(convertInputToMorse:) forControlEvents:UIControlEventTouchUpInside];
    _charBeingSent.text = @" ";
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
