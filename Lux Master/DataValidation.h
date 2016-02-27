//
//  DataValidation.h
//  Lux Master
//
//  Created by Michael Zanussi on 9/10/13.
//  Copyright (c) 2013 Fat Chile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataValidation : NSObject

+ (BOOL)areAnyTwoFilled:(NSString *)first second:(NSString *)second third:(NSString *)third;
+ (BOOL)areTwoFilled:(NSString *)first second:(NSString *)second;
+ (BOOL)isValidDecimal:(NSString *)value;

@end
