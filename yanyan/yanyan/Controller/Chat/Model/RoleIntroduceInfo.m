//
//  RoleIntroduceInfo.m
//  chat
//
//  Created by 高超 on 2017/5/16.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "RoleIntroduceInfo.h"

@implementation RoleIntroduceInfo
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_avatar":@"avatar",
             @"m_id":@"id",
             @"m_rdesc":@"rdesc",
             @"m_rname":@"rname",
             @"m_roomId":@"room_id"
             };
}

@end
