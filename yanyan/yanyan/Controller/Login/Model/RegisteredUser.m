//
//  RegisteredUser.m
//  chat
//
//  Created by 高超 on 16/3/21.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "RegisteredUser.h"
#import "RegisteredThirdPlat.h"
@implementation RegisteredUser
//+ (NSDictionary *)objectClassInArray
//{
//    return @{
//             
//             @"m_thirdArray": @"RegisteredThirdPlat"
//             
//             };
//    
//    
//}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_avatar" : @"avatar",
             @"m_bgimage":@"bgimg",
             @"m_birth" : @"birth",
             @"m_uname" : @"ease_uname",
             @"m_gender" : @"gender",
             @"m_id" : @"id",
             @"m_integral" : @"integral",
             @"m_levels":@"levels",
             @"m_nickname":@"nickname",
             @"m_passwd" : @"passwd",
             @"m_phonenum" : @"phonenum",
             @"m_signature" : @"signature",
             @"m_thirdArray" :@"third_plat",
             @"m_thirdInfo":@"third_info",
             @"m_hometown":@"hometown",
             @"m_emotion":@"emotion",
             @"m_intrest":@"intrest",
             @"m_numSerial":@"num_serial",
             @"m_finishTime":@"finish_time"
    };
}


//读取本地时走这个方法model
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.m_avatar   = [aDecoder decodeObjectForKey:@"m_avatar"];
        self.m_bgimage   = [aDecoder decodeObjectForKey:@"m_bgimage"];
        self.m_birth   = [aDecoder decodeObjectForKey:@"m_birth"];
        self.m_uname   = [aDecoder decodeObjectForKey:@"m_uname"];
        self.m_gender   = [aDecoder decodeObjectForKey:@"m_gender"];
        self.m_id   = [aDecoder decodeObjectForKey:@"m_id"];
        self.m_integral   = [aDecoder decodeObjectForKey:@"m_integral"];
        self.m_levels   = [aDecoder decodeObjectForKey:@"m_levels"];
        self.m_nickname   = [aDecoder decodeObjectForKey:@"m_nickname"];
        self.m_passwd   = [aDecoder decodeObjectForKey:@"m_passwd"];
        self.m_phonenum   = [aDecoder decodeObjectForKey:@"m_phonenum"];
        self.m_signature   = [aDecoder decodeObjectForKey:@"m_signature"];
        self.m_thirdArray   = [aDecoder decodeObjectForKey:@"m_thirdArray"];
        self.m_hometown   = [aDecoder decodeObjectForKey:@"m_hometown"];
        self.m_emotion   = [aDecoder decodeObjectForKey:@"m_emotion"];
        self.m_intrest   = [aDecoder decodeObjectForKey:@"m_intrest"];
        self.m_numSerial   = [aDecoder decodeObjectForKey:@"m_numSerial"];
        self.m_thirdInfo   = [aDecoder decodeObjectForKey:@"m_thirdInfo"];
        self.m_finishTime = [aDecoder decodeIntegerForKey:@"m_finishTime"];
    }
    return self;
}

//本地存储时走这个方法存model
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.m_avatar forKey:@"m_avatar"];
    [aCoder encodeObject:self.m_bgimage forKey:@"m_bgimage"];
    [aCoder encodeObject:self.m_birth forKey:@"m_birth"];
    [aCoder encodeObject:self.m_uname forKey:@"m_uname"];
    [aCoder encodeObject:self.m_gender forKey:@"m_gender"];
    [aCoder encodeObject:self.m_id forKey:@"m_id"];
    [aCoder encodeObject:self.m_integral forKey:@"m_integral"];
    [aCoder encodeObject:self.m_levels forKey:@"m_levels"];
    [aCoder encodeObject:self.m_nickname forKey:@"m_nickname"];
    [aCoder encodeObject:self.m_passwd forKey:@"m_passwd"];
    [aCoder encodeObject:self.m_phonenum forKey:@"m_phonenum"];
    [aCoder encodeObject:self.m_signature forKey:@"m_signature"];
    [aCoder encodeObject:self.m_thirdArray forKey:@"m_thirdArray"];
    [aCoder encodeObject:self.m_hometown forKey:@"m_hometown"];
    [aCoder encodeObject:self.m_emotion forKey:@"m_emotion"];
    [aCoder encodeObject:self.m_intrest forKey:@"m_intrest"];
    [aCoder encodeObject:self.m_numSerial forKey:@"m_numSerial"];
    [aCoder encodeObject:self.m_thirdInfo forKey:@"m_thirdInfo"];
    [aCoder encodeInteger:self.m_finishTime forKey:@"m_finishTime"];
}



@end
