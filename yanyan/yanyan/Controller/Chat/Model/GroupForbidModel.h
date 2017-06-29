//
//  GroupForbidModel.h
//  chat
//
//  Created by dong on 16/4/29.
//  Copyright © 2016年 Dong. All rights reserved.
//
//禁言信息
#import "DModel.h"

@interface GroupForbidModel : DModel
/**
 *  是否被禁言
 */
@property(nonatomic,strong) NSString *m_isforbid;
/**
 *  禁言开始时间
 */
@property(nonatomic,strong) NSString *m_forbidStart;
/**
 *  剩余时间
 */
@property(nonatomic,strong) NSString *m_remainTime;
/**
 *  结束时间
 */
@property(nonatomic,strong) NSDate *m_endTime;
@end
