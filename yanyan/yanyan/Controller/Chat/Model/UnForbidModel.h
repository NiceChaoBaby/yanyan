//
//  UnForbidModel.h
//  chat
//
//  Created by dong on 16/4/7.
//  Copyright © 2016年 Dong. All rights reserved.
//
//取消禁言 10
#import "DModel.h"

@interface UnForbidModel : DModel
/**
 *   群组ID
 */
@property(nonatomic,strong) NSString *m_groupId;
/**
 *   群组名称
 */
@property(nonatomic,strong) NSString *m_groupName;
/**
 *   被取消禁言的用户ID
 */
@property(nonatomic,strong) NSString *m_memberUid;
/**
 *   被取消禁言的用户昵称
 */
@property(nonatomic,strong) NSString *m_memberName;


@end
