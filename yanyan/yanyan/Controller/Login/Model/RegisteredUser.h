//
//  RegisteredUser.h
//  chat
//
//  Created by 高超 on 16/3/21.
//  Copyright © 2016年 Dong. All rights reserved.
//
//用户信息 Model

#import "DModel.h"

@interface RegisteredUser : DModel
/**
 * 头像
 */
@property(nonatomic,strong)NSString * m_avatar;//头像
/**
 *  背景图片
 */
@property(nonatomic,strong)NSString * m_bgimage;//背景Image
/**
 *  生日
 */
@property(nonatomic,strong)NSString * m_birth;//生日

/**
 *  ease_uname是环信上的用户名
 */
@property(nonatomic,strong)NSString *m_uname;
/**
 *  性别  1 男 2女
 */
@property(nonatomic,strong)NSString * m_gender;
/**
 *   用户id 这个id值就是和服务器通信的id
 */
@property(nonatomic,strong)NSString * m_id;
/**
 *  积分
 */
@property(nonatomic,strong)NSString * m_integral;
/**
 *  用户等级
 */
@property(nonatomic,strong)NSString * m_levels;
/**
 *  昵称
 */
@property(nonatomic,strong)NSString * m_nickname;
/**
 *  用户全ID
 */
@property(nonatomic,strong)NSString * m_numSerial;
/**
 *  密码？
 */
@property(nonatomic,strong)NSString * m_passwd;
/**
 *  手机号（账号）
 */
@property(nonatomic,strong)NSString * m_phonenum;
/**
 *  用户签名
 */
@property(nonatomic,strong)NSString * m_signature;
/**
 *  用第三方账号登录时用的
 */
@property(nonatomic,strong)NSMutableArray * m_thirdArray;
/**
 * 第三方账号|QQ#.......|的形式字符串 与 m_thirdArray 一样
 */
@property(nonatomic,strong)NSString * m_thirdInfo;
/**
 *   家乡
 */
@property(nonatomic,strong)NSString * m_hometown;
/**
 *  情感
 */
@property(nonatomic,strong)NSString * m_emotion;
/**
 *  兴趣
 */
@property(nonatomic,strong)NSString * m_intrest;


/**
 账号全局禁言结束时间戳
 */
@property(nonatomic,assign)long long  m_finishTime;
@end
