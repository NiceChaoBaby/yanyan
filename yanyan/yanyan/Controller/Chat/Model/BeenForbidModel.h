//
//  BeenForbidModel.h
//  chat
//
//  Created by dong on 16/4/7.
//  Copyright © 2016年 Dong. All rights reserved.
//
//被禁言 9
#import "DModel.h"

@interface BeenForbidModel : DModel
/**
 *  禁言开始时间
 */
@property(nonatomic,strong) NSString *m_forbidStart;
/**
 *  禁言的群组
 */
@property(nonatomic,strong) NSString *m_groupId;
/**
 *  环信群组ID
 */
@property(nonatomic,strong) NSString *m_easeGroupId;
/**
 *  被禁言的用户id
 */
@property(nonatomic,strong) NSString *m_memberUid;
/**
 *  群组名称
 */
@property(nonatomic,strong)NSString * m_groupNmae;
/**
 *  被禁言用户昵称
 */
@property(nonatomic,strong)NSString * m_memberName;
/**
 *  禁言发起ID
 */
@property(nonatomic,strong) NSString *m_rid;
/**
 *  群组头像
 */
@property(nonatomic,strong) NSString *m_groupAvatar;
/**
 *  1被举报 2被管理员禁言
 */
@property(nonatomic,strong) NSString *m_toType;





@end
