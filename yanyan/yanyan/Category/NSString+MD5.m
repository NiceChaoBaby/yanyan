//
//  NSString+MD5.m
//  ScqjqxIphone
//
//  Created by CloverFly on 15/4/10.
//  Copyright (c) 2015年 yuandaiyong. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (MD5)

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
   
    return hash;
}

@end
