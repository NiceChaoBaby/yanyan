//
//  GroupMemberModel.m
//  chat
//
//  Created by dong on 16/3/23.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "GroupMemberModel.h"

@implementation GroupMemberModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"m_avatar":@"avatar",
              @"m_easeUname" : @"ease_uname",
             @"m_gender" : @"gender",
             @"m_id" : @"id",
             @"m_isforbid" : @"is_forbid",
             @"m_isManger" :@"is_manager",
             @"m_remain" :@"remain",
              @"m_endDate":@"endDate",
             @"m_nickName":@"nickname",
             @"m_roleNmuber":@"role_num",
             @"m_Roleavatar":@"role_avatar",
             @"m_Rolename":@"role_name"
             };
}
@end
