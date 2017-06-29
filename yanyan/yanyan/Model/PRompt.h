//
//  PRompt.h
//  chat
//
//  Created by 高超 on 16/5/10.
//  Copyright © 2016年 Dong. All rights reserved.
//
//声音 震动 提示
#import <Foundation/Foundation.h>
#import "SetMessage.h"
@interface PRompt : NSObject


///**
// *  震动提示
// */
//+(void)promptVibrationPrompt;
//
///**
// *  声音提示
// */
//+(void)promptVoicePrompt;

//储存设置状态
+(void)promptStorageSetState:(SetMessage * )model;
/**
 *  读取设置
 */
+(SetMessage *)promptReadStorage;
/**
 *  判断本地是否储存设置
 */
+(BOOL)promptBeingstorage;


/**
 判断免扰进行本地消息推送判断
 
 @param type  <#type description#>
 @param ideID <#ideID description#>
 */
+(BOOL)JudgePromptMessage:(MessageType)type identifyID:(NSString *)ideID;

/**
 *  判断是否声音提示
 */
+(void)JudgePrompt:(MessageType)type identifyID:(NSString *)ideID;
/**
 *  存储聊天室消息免打扰
 */
+(void)judgeChatRoomMessage:(BOOL)message;
/**
 *  读取聊天室消息免打扰
 */
+(BOOL)judgeStateChatRoomMessage;

//储存是否提示变量
+(void)PromptStorage:(BOOL)prompt;
@end
