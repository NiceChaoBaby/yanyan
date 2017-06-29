//
//  UserPermissionsModel.h
//  chat
//
//  Created by 高超 on 16/9/6.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPermissionsModel : NSObject
/**
 *  等级
 */
@property(nonatomic,strong)NSString * m_level;
/**
 *  可以创建的群数量
 */
@property(nonatomic,strong)NSString * m_createGroupNum;
/**
 *  加入的群的总数量
 */
@property(nonatomic,strong)NSString * m_totalGroupNum;
/**
 *  是否能私聊聊天
 */
@property(nonatomic,strong)NSString * m_canSingleChat;

/**
   是否能加好友
 */
@property(nonatomic,strong)NSString * m_addFriends;

@end
