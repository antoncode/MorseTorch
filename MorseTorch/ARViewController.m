//
//  ARViewController.m
//  MorseTorch
//
//  Created by Anton Rivera on 4/14/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARViewController.h"
#import "NSString+NSStringDisplayMorseCode.h"

@interface ARViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *morseText;
@property (weak, nonatomic) IBOutlet UITextField *inputText;

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
    NSString *inputString = _inputText.text;
    NSString *tempString = [NSString new];
    
    tempString = [inputString convertStringToMorseCode:inputString];

    _morseText.text = tempString;

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
