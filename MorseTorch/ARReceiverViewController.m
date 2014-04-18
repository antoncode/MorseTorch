//
//  ARReceiverViewController.m
//  MorseTorch
//
//  Created by Anton Rivera on 4/17/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARReceiverViewController.h"
#import "CFMagicEvents.h"
#import "NSString+NSStringDisplayMorseCode.h"

@interface ARReceiverViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) BOOL greenBoxOn;
@property (nonatomic) CGFloat interval;
@property (nonatomic, strong) NSDate *onTime, *offTime;
@property (nonatomic, strong) NSString *messageReceived;

@end

@implementation ARReceiverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _cfMagicEvents  = [[CFMagicEvents alloc] init];
    [_cfMagicEvents startCapture];
    
    _imageView.backgroundColor = [UIColor blackColor];
    _greenBoxOn = NO;
    
    _messageReceived = [NSString new];
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
    if(!_greenBoxOn)
    {
        _greenBoxOn = YES;
        _imageView.backgroundColor = [UIColor greenColor];
        _onTime = [NSDate date];
        _interval = [_onTime timeIntervalSinceDate:_offTime];
        NSLog(@"%f seconds passed", _interval);
        [self printMessage:_interval];
    }
}

-(void) lightNotDetected
{
    if(_greenBoxOn)
    {
        _greenBoxOn = NO;
        _imageView.backgroundColor = [UIColor blackColor];
        _offTime = [NSDate date];
    }
}

- (void)printMessage:(CGFloat)interval
{
    if (interval < 0.06 ) {
        NSLog(@"This is nothing");
    } else if (interval >= 0.06 && interval < 0.26) {
        NSLog(@"This is a DOT");
        _messageReceived = [_messageReceived stringByAppendingString:@"."];
    } else if (interval >= 0.26) {
        NSLog(@"This is a DASH");
        _messageReceived = [_messageReceived stringByAppendingString:@"-"];
    }
}

@end










