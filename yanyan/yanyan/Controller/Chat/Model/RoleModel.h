//
//  RoleModel.h
//  chat
//
//  Created by 高超 on 2017/5/11.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoleModel : NSObject


/**
角色头像
 */
@property(nonatomic,strong)NSString * m_userImageUrl;

/**
 角色名称
 */
@property(nonatomic,strong)NSString * m_userName;


/**
 角色说明
 */
@property(nonatomic,strong)NSString * m_roleInstructions;

/**
 角色ID
 */
@property(nonatomic,assign)int  m_id;
@end
