//
//  ShutupModel.h
//  chat
//
//  Created by 高超 on 16/4/19.
//  Copyright © 2016年 Dong. All rights reserved.
//
//用户被禁言Model
#import <Foundation/Foundation.h>

@interface ShutupModel : DModel
/**
 *  环信聊天室ID
 */
@property(nonatomic,strong)NSString * m_easeId;
/**
 *  禁言开始时间
 */
@property(nonatomic,strong)NSString * m_forbidStart;
/**
 *  禁言持续时间
 */
@property(nonatomic,strong)NSString * m_remainTime;
/**
 *  被禁言人昵称
 */
@property(nonatomic,strong)NSString * m_memberName;
/**
 *  被禁言人ID
 */
@property(nonatomic,strong)NSString * m_memberUid;
/**
 *  群组头像
 */
@property(nonatomic,strong)NSString * m_roomAvatar;
/**
 *  聊天室ID
 */
@property(nonatomic,strong)NSString * m_roomId;
/**
 *  聊天是名称
 */
@property(nonatomic,strong)NSString * m_roomName;
/**
 *  举报记录ID
 */
@property(nonatomic,strong)NSString * m_tipoffId;
/**
 *  1被举报  2被创建人禁言
 */
@property(nonatomic,strong)NSString * m_toType;


/**
 *  透传时间
 */
@property(nonatomic,strong)NSString * m_addTime;
@end
