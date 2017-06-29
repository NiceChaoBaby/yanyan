//
//  FriendListModel.h
//  chat
//
//  Created by dong on 16/3/23.
//  Copyright © 2016年 Dong. All rights reserved.
//
//好友列表
#import "DModel.h"

@interface FriendListModel : DModel



/**
 *  消息ID
 */
@property(nonatomic,strong) NSString *m_applyId;
/**
 *  头像
 */
@property(nonatomic,strong) NSString *m_avatar;
/**
 *  生日
 */
@property(nonatomic,strong) NSString *m_birth;
/**
 *  环信名字
 */
@property(nonatomic,strong) NSString *m_easeUname;
/**
 *  表情
 */
@property(nonatomic,strong) NSString *m_emotion;
/**
 *  好友id
 */
@property(nonatomic,strong) NSString *m_fuid;
/**
 *  性别 1男  2女
 */
@property(nonatomic,strong) NSString *m_gender;
/**
 *  家乡
 */
@property(nonatomic,strong) NSString *m_homeTown;
/**
 *  用户等级
 */
@property(nonatomic,strong)NSString * m_levels;

/**
 *  名字
 */
@property(nonatomic,strong) NSString *m_nickname;
/**
 *  兴趣
 */
@property(nonatomic,strong) NSString *m_intrest;
/**
 *  纬度
 */
@property(nonatomic,strong)NSString * m_lat;
/**
 *  经度
 */
@property(nonatomic,strong)NSString * m_lng;
/**
 *  签名
 */
@property(nonatomic,strong) NSString *m_signature;

/**
 来源
 */
@property(nonatomic,strong)NSString *m_source;

@property(retain,nonatomic)NSString *pinYin;
@end
