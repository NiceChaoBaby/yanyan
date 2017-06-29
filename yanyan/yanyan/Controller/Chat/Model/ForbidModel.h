//
//  ForbidModel.h
//  chat
//
//  Created by dong on 16/4/7.
//  Copyright © 2016年 Dong. All rights reserved.
//
//发起禁言 8
#import "DModel.h"

@interface ForbidModel : DModel
/**
 *  禁言记录ID(rid)
 */
@property(nonatomic,strong) NSString *m_Rid;
/**
 *  /被禁言的用户id
 */
@property(nonatomic,strong) NSString *m_memberUid;
/**
 *  /被禁言的用户昵称
 */
@property(nonatomic,strong) NSString *m_memberName;
/**
 *  /发起人ID
 */
@property(nonatomic,strong) NSString *m_fromUid;
/**
 *  发起人昵称
 */
@property(nonatomic,strong) NSString *m_fromName;
/**
 *  群组id
 */
@property(nonatomic,strong) NSString *m_groupID;
/**
 *  群组名称
 */
@property(nonatomic,strong) NSString *m_group_name;
@end
