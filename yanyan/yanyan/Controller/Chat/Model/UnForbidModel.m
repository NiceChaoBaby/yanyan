//
//  UnForbidModel.m
//  chat
//
//  Created by dong on 16/4/7.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "UnForbidModel.h"

@implementation UnForbidModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_groupId" : @"group_id",
             @"m_groupName" : @"group_name",
             @"m_memberUid" : @"member_uid",
             @"m_memberName" : @"member_name"
             };
}
@end
