//
//  NSString+NSStringDisplayMorseCode.m
//  MorseTorch
//
//  Created by Anton Rivera on 4/14/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "NSString+NSStringDisplayMorseCode.h"

@implementation NSString (NSStringDisplayMorseCode)

- (NSString *)convertStringToMorseCode:(NSString *)string
{
    const char *c = [string UTF8String];
    
    NSString *tempString = [NSString new];
    NSString *tempMorseCode = [NSString new];
    
    for (int i=0; i < string.length; i++) {
        tempMorseCode = [[NSString stringWithFormat:@"%c",c[i]] convertToMorseCode];    // Get morse code for character at c[i]
        tempString = [tempString stringByAppendingString:tempMorseCode];                // Append morse code to tempString
        tempString = [tempString stringByAppendingString:@"   "];                       // Add three spaces for space between two letters
    }
    
    return tempString;
}

- (NSString *)convertToMorseCode
{
    NSString *convertedText = [NSString new];
    
    if ([self.description isEqualToString:@"a"] || [self.description isEqualToString:@"A"])
        convertedText = @". -";
    else if ([self.description isEqualToString:@"b"] || [self.description isEqualToString:@"B"])
        convertedText = @"- . . .";
    else if ([self.description isEqualToString:@"c"] || [self.description isEqualToString:@"C"])
        convertedText = @"- . - .";
    else if ([self.description isEqualToString:@"d"] || [self.description isEqualToString:@"D"])
        convertedText = @"- . .";
    else if ([self.description isEqualToString:@"e"] || [self.description isEqualToString:@"E"])
        convertedText = @".";
    else if ([self.description isEqualToString:@"f"] || [self.description isEqualToString:@"F"])
        convertedText = @". . - .";
    else if ([self.description isEqualToString:@"g"] || [self.description isEqualToString:@"G"])
        convertedText = @"- - .";
    else if ([self.description isEqualToString:@"h"] || [self.description isEqualToString:@"H"])
        convertedText = @". . . .";
    else if ([self.description isEqualToString:@"i"] || [self.description isEqualToString:@"I"])
        convertedText = @". .";
    else if ([self.description isEqualToString:@"j"] || [self.description isEqualToString:@"J"])
        convertedText = @". - - -";
    else if ([self.description isEqualToString:@"k"] || [self.description isEqualToString:@"K"])
        convertedText = @"- . - .";
    else if ([self.description isEqualToString:@"l"] || [self.description isEqualToString:@"L"])
        convertedText = @". - . .";
    else if ([self.description isEqualToString:@"m"] || [self.description isEqualToString:@"M"])
        convertedText = @"- -";
    else if ([self.description isEqualToString:@"n"] || [self.description isEqualToString:@"N"])
        convertedText = @"- .";
    else if ([self.description isEqualToString:@"o"] || [self.description isEqualToString:@"O"])
        convertedText = @"- - -";
    else if ([self.description isEqualToString:@"p"] || [self.description isEqualToString:@"P"])
        convertedText = @". - - .";
    else if ([self.description isEqualToString:@"q"] || [self.description isEqualToString:@"Q"])
        convertedText = @"- - . -";
    else if ([self.description isEqualToString:@"r"] || [self.description isEqualToString:@"R"])
        convertedText = @". - .";
    else if ([self.description isEqualToString:@"s"] || [self.description isEqualToString:@"S"])
        convertedText = @". . .";
    else if ([self.description isEqualToString:@"t"] || [self.description isEqualToString:@"T"])
        convertedText = @"-";
    else if ([self.description isEqualToString:@"u"] || [self.description isEqualToString:@"U"])
        convertedText = @". . -";
    else if ([self.description isEqualToString:@"v"] || [self.description isEqualToString:@"V"])
        convertedText = @". . . -";
    else if ([self.description isEqualToString:@"w"] || [self.description isEqualToString:@"W"])
        convertedText = @". - -";
    else if ([self.description isEqualToString:@"x"] || [self.description isEqualToString:@"X"])
        convertedText = @"- . . -";
    else if ([self.description isEqualToString:@"y"] || [self.description isEqualToString:@"Y"])
        convertedText = @"- . - -";
    else if ([self.description isEqualToString:@"z"] || [self.description isEqualToString:@"Z"])
        convertedText = @"- - . .";
    else if ([self.description isEqualToString:@"1"])
        convertedText = @". - - - -";
    else if ([self.description isEqualToString:@"2"])
        convertedText = @". . - - -";
    else if ([self.description isEqualToString:@"3"])
        convertedText = @". . . - -";
    else if ([self.description isEqualToString:@"4"])
        convertedText = @". . . . -";
    else if ([self.description isEqualToString:@"5"])
        convertedText = @". . . . .";
    else if ([self.description isEqualToString:@"6"])
        convertedText = @"- . . . .";
    else if ([self.description isEqualToString:@"7"])
        convertedText = @"- - . . .";
    else if ([self.description isEqualToString:@"8"])
        convertedText = @"- - - . .";
    else if ([self.description isEqualToString:@"9"])
        convertedText = @"- - - - .";
    else if ([self.description isEqualToString:@"0"])
        convertedText = @"- - - - -";
    else if ([self.description isEqualToString:@" "])
        convertedText = @"       ";
        
    return convertedText;
}

@end
