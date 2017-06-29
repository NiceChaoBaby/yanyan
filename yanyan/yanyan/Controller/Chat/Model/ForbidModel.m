//
//  ForbidModel.m
//  chat
//
//  Created by dong on 16/4/7.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "ForbidModel.h"

@implementation ForbidModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_Rid" : @"rid",
             @"m_memberUid" : @"member_uid",
             @"m_memberName" : @"member_name",
              @"m_fromUid" : @"from_uid",
             @"m_fromName" : @"from_name",
             @"m_groupID" : @"group_id",
             @"m_group_name" : @"group_name"
             };
}


@end
