//
//  GroupMemberModel.h
//  chat
//
//  Created by dong on 16/3/23.
//  Copyright © 2016年 Dong. All rights reserved.
//
//成员
#import "DModel.h"

@interface GroupMemberModel : DModel
/**
 *  头像
 */
@property(nonatomic,strong) NSString *m_avatar;
/**
 *  性别1男 2女
 */
@property(nonatomic,strong) NSString *m_gender;
/**
 *  环信名
 */
@property(nonatomic,strong) NSString *m_easeUname;
/**
 *  id
 */
@property(nonatomic,strong) NSString *m_id;
/**
 *  是否被禁言了
 */
@property(nonatomic,strong) NSString *m_isforbid;
@property(nonatomic,strong) NSDate    *m_endDate;
@property(nonatomic,assign) float m_remain;
/**
 * is_manager-1群主，2管理员，0 普通成员
 */
@property(nonatomic,strong) NSString *m_isManger;
/**
 *  名字
 */
@property(nonatomic,strong) NSString *m_nickName;
@property(strong,nonatomic)NSString *pinYin;
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
