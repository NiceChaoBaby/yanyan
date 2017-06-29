//
//  ChatMemberListModel.m
//  chat
//
//  Created by 高超 on 16/9/5.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "ChatMemberListModel.h"

@implementation ChatMemberListModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_avatar" : @"avatar",
             @"m_easeUname":@"ease_uname",
             @"m_id":@"id",
             @"m_nickname":@"nickname",
             @"m_remainTime":@"remain",
             @"m_endDate":@"endDate",
             @"m_isForbid":@"is_forbid",
             @"m_gender":@"gender",
             @"m_roleNmuber":@"role_num",
             @"m_Roleavatar":@"role_avatar",
             @"m_Rolename":@"role_name"
             };
}



@end
