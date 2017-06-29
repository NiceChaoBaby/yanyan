//
//  GroupForbidModel.m
//  chat
//
//  Created by dong on 16/4/29.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "GroupForbidModel.h"

@implementation GroupForbidModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_isforbid" : @"is_forbid",
             @"m_forbidStart" : @"forbid_start",
              @"m_remainTime" : @"remain_time"
             };
}
@end
