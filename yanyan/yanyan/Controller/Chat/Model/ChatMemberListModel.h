//
//  ChatMemberListModel.h
//  chat
//
//  Created by 高超 on 16/9/5.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMemberListModel : NSObject
/**
 *  头像
 */
@property(nonatomic,strong)NSString * m_avatar;
/**
 *  环信名称
 */
@property(nonatomic,strong)NSString * m_easeUname;
/**
 性别
 */
@property(nonatomic,strong)NSString * m_gender;
/**
 *  ID
 */
@property(nonatomic,strong)NSString * m_id;
/**
 *  用户名称
 */
@property(nonatomic,strong)NSString * m_nickname;
/**
 *  用户名称
 */
@property(nonatomic,strong)NSString * m_isForbid;
/**
 禁言将要结束的时间
 */
@property(nonatomic,strong)NSDate * m_endDate;

/**
 服务器返给我们的剩余时间
 */
@property(nonatomic,assign)float m_remainTime;

//-----------------角色扮演----------------------//

/**
 角色号
 */
@property(nonatomic,assign)int m_roleNmuber;

/**
 角色头像
 */
@property(nonatomic,strong)NSString * m_Roleavatar;

/**
 角色名称
 */
@property(nonatomic,strong)NSString * m_Rolename;

@end
