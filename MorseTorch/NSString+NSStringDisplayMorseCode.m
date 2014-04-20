//
//  NSString+NSStringDisplayMorseCode.m
//  MorseTorch
//
//  Created by Anton Rivera on 4/14/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "NSString+NSStringDisplayMorseCode.h"

@implementation NSString (NSStringDisplayMorseCode)

- (NSString *)convertStringToMorseCode:(NSString *)stringToConvert
{
    NSString *morseCodeString = [NSString new];
    NSString *charMorseCode = [NSString new];
    
    for (NSInteger i=0; i < stringToConvert.length; i++) {
        if ((i != 0)  && ![[NSString stringWithFormat:@"%c", [stringToConvert characterAtIndex:i-1]] isEqualToString:@" "])
            morseCodeString = [morseCodeString stringByAppendingString:@"   "];                       // Add three spaces for space between two characters
        charMorseCode = [[NSString stringWithFormat:@"%c",[stringToConvert characterAtIndex:i]] convertToMorseCode];    // Get morse code for character at stringToConvert[i]
        morseCodeString = [morseCodeString stringByAppendingString:charMorseCode];                // Append morse code to tempString
    }
    
    return morseCodeString;
}

- (NSString *)convertToMorseCode
{
    NSString *convertedText = [NSString new];
    
    NSString *lowercaseText = [self.description lowercaseString];
    
    NSArray *letterKeys = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n",@"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @" "];
    NSArray *morseCode = @[@". -", @"- . . .", @"- . - .", @"- . .", @".", @". . - .", @"- - .", @". . . .", @". .", @". - - -", @"- . - .", @". - . .", @"- -", @"- .", @"- - -", @". - - .", @"- - . -", @". - .", @". . .", @"-", @". . -", @". . . -", @". - -", @"- . . -", @"- . - -", @"- - . .", @". - - - -", @". . - - -", @". . . - -", @". . . . -", @". . . . .", @"- . . . .", @"- - . . .", @"- - - . .", @"- - - - .", @"- - - - -", @"  "];
    NSDictionary *conversionDictionary = [[NSDictionary alloc] initWithObjects:morseCode
                                                                       forKeys:letterKeys];
    
    convertedText = [conversionDictionary objectForKey:lowercaseText];
    
    return convertedText;
}

- (NSString *)convertFromMorseCode:(NSString *)morseToConvert
{
    NSDictionary *morseDictionary =@{@".-"      :@"a",
                                     @"-..."    :@"b",
                                     @"-.-."    :@"c",
                                     @"-.."     :@"d",
                                     @"."       :@"e",
                                     @"..-."    :@"f",
                                     @"--."     :@"g",
                                     @"...."    :@"h",
                                     @".."      :@"i",
                                     @".---"    :@"j",
                                     @"-.-."    :@"k",
                                     @".-.."    :@"l",
                                     @"--"      :@"m",
                                     @"-."      :@"n",
                                     @"---"     :@"o",
                                     @".--."    :@"p",
                                     @"--.-"    :@"q",
                                     @".-."     :@"r",
                                     @"..."     :@"s",
                                     @"-"       :@"t",
                                     @"..-"     :@"u",
                                     @"...-"    :@"v",
                                     @".--"     :@"w",
                                     @"-..-"    :@"x",
                                     @"-.--"    :@"y",
                                     @"--.."    :@"z",
                                     @".----"   :@"1",
                                     @"..---"   :@"2",
                                     @"...--"   :@"3",
                                     @"....-"   :@"4",
                                     @"....."   :@"5",
                                     @"-...."   :@"6",
                                     @"--..."   :@"7",
                                     @"---.."   :@"8",
                                     @"----."   :@"9",
                                     @"-----"   :@"0"};
    
    if ([morseDictionary objectForKey:morseToConvert]) {
        return [morseDictionary objectForKey:morseToConvert];
    } else {
        // That is not morse code
        return @"";
    }
}

@end
