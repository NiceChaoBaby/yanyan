//
//  BlickListModel.h
//  chat
//
//  Created by 高超 on 16/5/4.
//  Copyright © 2016年 Dong. All rights reserved.
//
//黑名单用户Model
#import <Foundation/Foundation.h>

@interface BlickListModel : DModel

/**
 *  用户头像
 */
@property(nonatomic,strong)NSString * m_avatar;
/**
 *  环信名
 */
@property(nonatomic,strong)NSString * m_easeUname;
/**
 *  用户ID
 */
@property(nonatomic,strong)NSString * m_id;
/**
 *  用户名称
 */
@property(nonatomic,strong)NSString * m_nickName;

@end
