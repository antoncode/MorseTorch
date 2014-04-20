//
//  ARReceiverViewController.m
//  MorseTorch
//
//  Created by Anton Rivera on 4/17/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARReceiverViewController.h"
#import "ARMagicEvents.h"
#import "NSString+NSStringDisplayMorseCode.h"

@interface ARReceiverViewController ()

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) BOOL greenBoxOn;
@property (nonatomic, strong) NSDate *onTime, *offTime;
@property (nonatomic, strong) NSString *morseReceived, *stringOfChar;

@end

@implementation ARReceiverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arMagicEvents  = [[ARMagicEvents alloc] init];
    [_arMagicEvents startCapture];
    
    _imageView.backgroundColor = [UIColor blackColor];
    _greenBoxOn = NO;
    
    _outputLabel.text = @"";
    _morseReceived = @"";
    _stringOfChar = @"";
    
    _offTime = [NSDate date];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLightSourceDrop:) name:@"lightSourceDrop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLightSourceIncrease:) name:@"lightSourceIncrease" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)receiveLightSourceDrop:(NSNotification *) notification
{
    // Light source dropped
    dispatch_async(dispatch_get_main_queue(), ^{
        [self lightNotDetected];
    });
}

-(void)receiveLightSourceIncrease:(NSNotification *) notification
{
    // Light source increased
    dispatch_async(dispatch_get_main_queue(), ^{
        [self lightDetected];
    });
}

-(void)lightDetected
{
    CGFloat lightOnInterval = 0.0;
    if(!_greenBoxOn)
    {
        _greenBoxOn = YES;
        _imageView.backgroundColor = [UIColor greenColor];
        _onTime = [NSDate date];
        lightOnInterval = [_onTime timeIntervalSinceDate:_offTime];
        NSLog(@"Light on: %f", lightOnInterval);
        [self printMessage:lightOnInterval];
    }
}

-(void)lightNotDetected
{
    CGFloat lightOffInterval = 0.0;
    if(_greenBoxOn)
    {
        _greenBoxOn = NO;
        _imageView.backgroundColor = [UIColor blackColor];
        _offTime = [NSDate date];
        lightOffInterval = [_offTime timeIntervalSinceDate:_onTime];
        NSLog(@"Light off: %f", lightOffInterval);

        [self printBlankSpace:lightOffInterval];
    }
}

- (void)printMessage:(CGFloat)lightOnInterval
{
    if (lightOnInterval < 0.1 ) {
        NSLog(@"This is nothing");
    } else if (lightOnInterval >= 0.1 && lightOnInterval < 0.3) {
        NSLog(@"This is a DOT");
        _morseReceived = [_morseReceived stringByAppendingString:@"."];
    } else if (lightOnInterval >= 0.3 && lightOnInterval < 1.0) {
        NSLog(@"This is a DASH");
        _morseReceived = [_morseReceived stringByAppendingString:@"-"];
    } else if (lightOnInterval >= 1.0) {
        
    }
}

- (void)printBlankSpace:(CGFloat)lightOffInterval
{
    NSString *charFromMorse = @"";
    
    if (lightOffInterval < 0.1 ) {
        NSLog(@"This is nothing");
    } else if (lightOffInterval >= 0.1 && lightOffInterval < 0.5) {
        NSLog(@"Space between SYMBOLS");
        charFromMorse = [_morseReceived convertFromMorseCode:_morseReceived];
        _stringOfChar = [_stringOfChar stringByAppendingString:charFromMorse];
        _outputLabel.text = _stringOfChar;
    } else if (lightOffInterval >= 0.5 && lightOffInterval < 1.0) {
        NSLog(@"Space between WORDS");
        _stringOfChar = [_stringOfChar stringByAppendingString:@" "];
        _outputLabel.text = _stringOfChar;
    } else if (lightOffInterval >= 1.0) {
        _outputLabel.text = @"";
        _stringOfChar = @"";
    }
}

@end










