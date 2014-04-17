//
//  ARTorchController.h
//  MorseTorch
//
//  Created by Anton Rivera on 4/16/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ARTorchControllerDelegate <NSObject>

-(void)displayNewLetter:(NSString *)newLetter;
-(void)finished;

@end

@interface ARTorchController : NSObject

@property (nonatomic, weak) id<ARTorchControllerDelegate> delegate;

- (void)convertStringToFlashes:(NSString *)inputString;
- (void)convertMorseCodeToFlashes:(NSString *)morseCodeString;
- (void)cancel;

@end
