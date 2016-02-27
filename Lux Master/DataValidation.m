//
//  DataValidation.m
//  Lux Master
//
//  Created by Michael Zanussi on 9/10/13.
//  Copyright (c) 2013 Fat Chile. All rights reserved.
//

#import "DataValidation.h"

@implementation DataValidation

+ (BOOL)areAnyTwoFilled:(NSString *)first second:(NSString *)second third:(NSString *)third
{
    if ([DataValidation isValidDecimal:first] && [DataValidation isValidDecimal:second] && ![DataValidation isValidDecimal:third])
    {
        return YES;
    }
    
    if ([DataValidation isValidDecimal:first] && ![DataValidation isValidDecimal:second] && [DataValidation isValidDecimal:third])
    {
        return YES;
    }
    
    if (![DataValidation isValidDecimal:first] && [DataValidation isValidDecimal:second] && [DataValidation isValidDecimal:third])
    {
        return YES;
    }
    
    return NO;
}

+ (BOOL)areTwoFilled:(NSString *)first second:(NSString *)second
{
    if ([DataValidation isValidDecimal:first] && [DataValidation isValidDecimal:second])
    {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isValidDecimal:(NSString *)value
{
    if (value.length == 0) {
        return NO;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:value];
    BOOL isValid = [scanner scanDouble:NULL] && [scanner isAtEnd];
    
    return isValid;
}

@end
