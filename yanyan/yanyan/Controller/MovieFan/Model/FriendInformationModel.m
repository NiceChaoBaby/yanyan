//
//  FriendInformationModel.m
//  chat
//
//  Created by 高超 on 16/4/13.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "FriendInformationModel.h"

@implementation FriendInformationModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_avatar" : @"avatar",
             @"m_avatarBig":@"avatar_big",
             @"m_bgimage":@"bgimg",
             @"m_birth" : @"birth",
             @"m_easeUname" : @"ease_uname",
             @"m_emotion" : @"emotion",
             @"m_gender" : @"gender",
             @"m_homeTown" : @"hometown",
             @"m_id" : @"id",
             @"m_intrest" : @"intrest",
             @"m_levels" : @"levels",
             @"m_nickname" : @"nickname",
             @"m_signature":@"signature",
             @"m_numSerial":@"num_serial"
    };
}
@end
