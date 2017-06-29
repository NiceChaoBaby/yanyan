//
//  NSString+Validate.m
//  storm
//
//  Created by dong on 15/7/14.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//

#import "NSString+Validate.h"

@implementation NSString (Validate)

- (BOOL)validateTelPhoneNum
{
    NSString *matcher = @"0\\d{2,3}-\\d{7,8}|0\\d{2,3}\\s?\\d{7,8}|13[0-9]\\d{8}|18[0-9]\\d{8}|14[0-9]\\d{8}|15[0-9]\\d{8}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", matcher];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}

- (BOOL)validatePassword
{
    NSString *matcher = @"^\\w[a-zA-Z0-9~!@#$%^&*()_+.~-]{5,19}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", matcher];
    
    BOOL isMatch  = [pred evaluateWithObject:self];
    return  isMatch;
}

- (BOOL)isNull
{
    if(!self || self.length <= 0)
    {
        return NO;
    }
    return YES;
}

@end
