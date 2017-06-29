//
//  FriendInformationModel.h
//  chat
//
//  Created by 高超 on 16/4/13.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendInformationModel : DModel
/**
 *  头像
 */
@property(nonatomic,strong) NSString *m_avatar;


/**
   用户头像大图
 */
@property(nonatomic,strong) NSString * m_avatarBig;
/**
 *  背景图片
 */
@property(nonatomic,strong)NSString * m_bgimage;
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
 *  性别 1男  2女
 */
@property(nonatomic,strong) NSString *m_gender;
/**
 *  家乡
 */
@property(nonatomic,strong) NSString *m_homeTown;
/**
 *  好友id
 */
@property(nonatomic,strong) NSString *m_id;
/**
 *  兴趣
 */
@property(nonatomic,strong) NSString *m_intrest;

/**
 *  用户等级
 */
@property(nonatomic,strong)NSString * m_levels;

/**
 *  名字
 */
@property(nonatomic,strong) NSString *m_nickname;
/**
 *  签名
 */
@property(nonatomic,strong) NSString *m_signature;
/**
 *  用户长ID
 */
@property(nonatomic,strong)NSString * m_numSerial;








@end
