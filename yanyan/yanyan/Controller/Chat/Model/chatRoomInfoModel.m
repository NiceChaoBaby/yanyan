//
//  chatRoomInfoModel.m
//  chat
//
//  Created by 高超 on 16/6/15.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "chatRoomInfoModel.h"

@implementation chatRoomInfoModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_avatar" : @"avatar",
             @"m_easeUname":@"ease_uname",
             @"m_id":@"id",
             @"m_nickName":@"nickname"
             };
}
@end
