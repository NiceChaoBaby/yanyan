//
//  NoticeModel.h
//  chat
//
//  Created by 高超 on 16/4/8.
//  Copyright © 2016年 Dong. All rights reserved.
//
//消息cellmodel
#import <Foundation/Foundation.h>

@interface NoticeModel : DModel
/**
 *  标题
 */
@property(nonatomic,strong)NSString * m_title;
/**
 *  会话id
 */
@property(nonatomic,strong)NSString * m_conversationId;
/**
 *  消息类型0 申请消息  1=系统及通知，2=群组 3好友
 */
@property(nonatomic,strong)NSString * m_chatType;
/**
 *  用户名称  群组发言需要显示哪个用户说的
 */
@property(nonatomic,strong)NSString * m_userName;
/**
 *  时间
 */
@property(nonatomic,strong)NSString * m_time;
/**
 *  头像
 */
@property(nonatomic,strong)NSString * m_avatar;
/**
 *  内容
 */
@property(nonatomic,strong)NSString * m_content;
/**
 *  未读条数
 */
@property(nonatomic,assign)NSInteger m_number;
/**
 *  内容 跳转页面用
 */
@property(nonatomic,strong)NSMutableArray * m_dataArray;
/**
 *  用户id(主要用在陌生人聊天里)
 */
@property(nonatomic,strong)NSString * m_uid;
/**
 *  聊天来源 单聊用
 */
@property(nonatomic,strong)NSString * m_from;

@end

