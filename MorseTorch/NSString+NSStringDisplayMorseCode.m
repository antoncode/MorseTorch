//
//  NSString+NSStringDisplayMorseCode.m
//  MorseTorch
//
//  Created by Anton Rivera on 4/14/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "NSString+NSStringDisplayMorseCode.h"

@implementation NSString (NSStringDisplayMorseCode)

- (NSString *)convertToMorseCode
{
    NSString *convertedText = [NSString new];
    
    if ([self.description isEqualToString:@"a"])
        convertedText = @". -";
    else if ([self.description isEqualToString:@"b"])
        convertedText = @"- . . .";
    else if ([self.description isEqualToString:@"c"])
        convertedText = @"- . - .";
    else if ([self.description isEqualToString:@"d"])
        convertedText = @"- . .";
    else if ([self.description isEqualToString:@"e"])
        convertedText = @".";
    else if ([self.description isEqualToString:@"f"])
        convertedText = @". . - .";
    else if ([self.description isEqualToString:@"g"])
        convertedText = @"- - .";
    else if ([self.description isEqualToString:@"h"])
        convertedText = @". . . .";
    else if ([self.description isEqualToString:@"i"])
        convertedText = @". .";
    else if ([self.description isEqualToString:@"j"])
        convertedText = @". - - -";
    else if ([self.description isEqualToString:@"k"])
        convertedText = @"- . - .";
    else if ([self.description isEqualToString:@"l"])
        convertedText = @". - . .";
    else if ([self.description isEqualToString:@"m"])
        convertedText = @"- -";
    else if ([self.description isEqualToString:@"n"])
        convertedText = @"- .";
    else if ([self.description isEqualToString:@"o"])
        convertedText = @"- - -";
    else if ([self.description isEqualToString:@"p"])
        convertedText = @". - - .";
    else if ([self.description isEqualToString:@"q"])
        convertedText = @"- - . -";
    else if ([self.description isEqualToString:@"r"])
        convertedText = @". - .";
    else if ([self.description isEqualToString:@"s"])
        convertedText = @". . .";
    else if ([self.description isEqualToString:@"t"])
        convertedText = @"-";
    else if ([self.description isEqualToString:@"u"])
        convertedText = @". . -";
    else if ([self.description isEqualToString:@"v"])
        convertedText = @". . . -";
    else if ([self.description isEqualToString:@"w"])
        convertedText = @". - -";
    else if ([self.description isEqualToString:@"x"])
        convertedText = @"- . . -";
    else if ([self.description isEqualToString:@"y"])
        convertedText = @"- . - -";
    else if ([self.description isEqualToString:@"z"])
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
        
    return convertedText;
}

@end
