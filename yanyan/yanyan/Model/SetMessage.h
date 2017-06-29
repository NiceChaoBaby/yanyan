//
//  SetMessage.h
//  chat
//
//  Created by 高超 on 16/5/11.
//  Copyright © 2016年 Dong. All rights reserved.
//
// 设置勿扰时段Model
#import <Foundation/Foundation.h>

@interface SetMessage : DModel
/**
 *  勿扰时段 22：00 ~~ 8：00 开关
 */
@property(nonatomic,strong)NSString * m_noHarass;
/**
 *  消息提醒开关
 */
@property(nonatomic,strong)NSString * m_groupMessage;
/**
 *  私聊消息提醒
 */
@property(nonatomic,strong)NSString * m_userMessage;
/**
 *  声音提示
 */
@property(nonatomic,strong)NSString * m_voicePrompt;
/**
 *  震动提示
 */
@property(nonatomic,strong)NSString * m_vibrationPrompt;

/**
 通知显示消息内容
 */
@property(nonatomic,strong)NSString * m_noticePrompt;
@end
