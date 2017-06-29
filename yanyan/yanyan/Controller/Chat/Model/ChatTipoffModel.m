//
//  ChatTipoffModel.m
//  chat
//
//  Created by dong on 16/4/14.
//  Copyright © 2016年 Dong. All rights reserved.
//
//
#import "ChatTipoffModel.h"

@implementation ChatTipoffModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_tipoffId" : @"tipoff_id",
             @"m_roomID" : @"room_id",
             @"m_easeId" : @"ease_id",
             @"m_roomName" : @"room_name",
             @"m_memberUid" : @"member_uid",
             @"m_memberName" : @"member_name",
             @"m_fromUid" : @"from_uid",
             @"m_fromNmae" : @"from_name",
             @"m_type" : @"type",
             @"m_addTime":@"add_time"
             };
}
@end
