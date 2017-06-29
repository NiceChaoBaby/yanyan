//
//  RoleModel.m
//  chat
//
//  Created by 高超 on 2017/5/11.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "RoleModel.h"

@implementation RoleModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_userImageUrl":@"avatar",
             @"m_userName":@"rname",
             @"m_roleInstructions":@"rdesc",
             @"m_id":@"id"
             
             };
}

@end
