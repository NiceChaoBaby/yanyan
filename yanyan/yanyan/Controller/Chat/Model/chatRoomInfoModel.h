//
//  chatRoomInfoModel.h
//  chat
//
//  Created by 高超 on 16/6/15.
//  Copyright © 2016年 Dong. All rights reserved.
//
//聊天室成员详细信息Model
#import <Foundation/Foundation.h>

@interface chatRoomInfoModel : DModel

/**
 *  用户头像
 */
@property(nonatomic,strong)NSString * m_avatar;
/**
 *  环信名称
 */
@property(nonatomic,strong)NSString * m_easeUname;
/**
 *  用户ID
 */
@property(nonatomic,strong)NSString * m_id;
/**
 *  用户名
 */
@property(nonatomic,strong)NSString * m_nickName;


@end
