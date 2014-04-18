//
//  ARMagicEvents.h
//  MorseTorch
//
//  Created by Anton Rivera on 4/17/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//


#import <Foundation/Foundation.h>

@class ARMagicEvents;

@interface ARMagicEvents : NSObject

-(BOOL)startCapture;
-(BOOL)stopCapture;
-(void)updateBrightnessThreshold:(int)pValue;

@end
