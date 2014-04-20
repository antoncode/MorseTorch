//
//  NSString+NSStringDisplayMorseCode.h
//  MorseTorch
//
//  Created by Anton Rivera on 4/14/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringDisplayMorseCode)

- (NSString *)convertStringToMorseCode:(NSString *)stringToConvert;
- (NSString *)convertToMorseCode;
- (NSString *)convertFromMorseCode:(NSString *)morseToConvert;

@end
