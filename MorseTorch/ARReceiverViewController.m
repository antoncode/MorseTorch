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

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) BOOL greenBoxOn;
@property (nonatomic, strong) NSDate *onTime, *offTime;
@property (nonatomic, strong) NSString *messageReceived;

@end

@implementation ARReceiverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cfMagicEvents  = [[ARMagicEvents alloc] init];
    [_cfMagicEvents startCapture];
    
    _imageView.backgroundColor = [UIColor blackColor];
    _greenBoxOn = NO;
    
    _messageReceived = [NSString new];
    
    _offTime = [NSDate date];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOnMagicEventDetected:) name:@"onMagicEventDetected" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOnMagicEventNotDetected:) name:@"onMagicEventNotDetected" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)receiveOnMagicEventDetected:(NSNotification *) notification
{
//    Light source dropped
    dispatch_async(dispatch_get_main_queue(), ^{
        [self lightNotDetected];
    });
}

-(void)receiveOnMagicEventNotDetected:(NSNotification *) notification
{
//    Light source went up
    dispatch_async(dispatch_get_main_queue(), ^{
        [self lightDetected];
    });
}

-(void) lightDetected
{
    CGFloat lightOnInterval = 0.0;
    if(!_greenBoxOn)
    {
        _greenBoxOn = YES;
        _imageView.backgroundColor = [UIColor greenColor];
        _onTime = [NSDate date];
        lightOnInterval = [_onTime timeIntervalSinceDate:_offTime];
//        NSLog(@"Light ON for %f seconds", lightOnInterval);
        [self printMessage:lightOnInterval];
    }
}

-(void) lightNotDetected
{
    CGFloat lightOffInterval = 0.0;
    if(_greenBoxOn)
    {
        _greenBoxOn = NO;
        _imageView.backgroundColor = [UIColor blackColor];
        _offTime = [NSDate date];
        lightOffInterval = [_offTime timeIntervalSinceDate:_onTime];
//        NSLog(@"Light OFF for %f seconds", lightOffInterval);
        [self printBlankSpace:lightOffInterval];
    }
}

- (void)printMessage:(CGFloat)lightOnInterval
{
    if (lightOnInterval < 0.06 ) {
        NSLog(@"This is nothing");
    } else if (lightOnInterval >= 0.06 && lightOnInterval < 0.26) {
        NSLog(@"This is a DOT");
        _messageReceived = [_messageReceived stringByAppendingString:@"."];
    } else if (lightOnInterval >= 0.26) {
        NSLog(@"This is a DASH");
        _messageReceived = [_messageReceived stringByAppendingString:@"-"];
    }
}

- (void)printBlankSpace:(CGFloat)lightOffInterval
{
    if (lightOffInterval < 0.06 ) {
        NSLog(@"This is nothing");
    } else if (lightOffInterval >= 0.06 && lightOffInterval < 0.46) {
        NSLog(@"Space between SYMBOLS");
        _messageReceived = [_messageReceived stringByAppendingString:@"."];
    } else if (lightOffInterval >= 0.46) {
        NSLog(@"Space between WORDS");
        _messageReceived = [_messageReceived stringByAppendingString:@"-"];
    }
}

@end










