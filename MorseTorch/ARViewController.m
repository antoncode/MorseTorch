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
    
    const char *c = [inputString UTF8String];
    
    NSString *tempString = [NSString new];
    NSString *tempMorseCode = [NSString new];
    
    for (int i=0; i < [inputString length]; i++) {
        tempMorseCode = [[NSString stringWithFormat:@"%c",c[i]] convertToMorseCode];
        tempString = [tempString stringByAppendingString:tempMorseCode];
        tempString = [tempString stringByAppendingString:@"   "]; // Three spaces for space between two letters
    }
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
