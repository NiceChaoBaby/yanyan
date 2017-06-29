//
//  NSString+Validate.h
//  storm
//
//  Created by dong on 15/7/14.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)

- (BOOL)validateTelPhoneNum;

- (BOOL)validatePassword;

- (BOOL)isNull;
@end
