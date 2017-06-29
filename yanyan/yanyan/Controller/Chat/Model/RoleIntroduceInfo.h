//
//  RoleIntroduceInfo.h
//  chat
//
//  Created by 高超 on 2017/5/16.
//  Copyright © 2017年 Dong. All rights reserved.
//
//角色扮演  角色Info
#import <Foundation/Foundation.h>

@interface RoleIntroduceInfo : NSObject

//头像
@property(nonatomic,strong)NSString * m_avatar;
//角色扮演id 我们自己软件的
@property(nonatomic,assign)int m_id;
//角色介绍
@property(nonatomic,strong)NSString * m_rdesc;
//角色名称
@property(nonatomic,strong)NSString * m_rname;

/**
 编号 这是用户选择了以后我自己去请求服务器编号才有
 */
@property(nonatomic,strong)NSString * m_roleNumber;
@property(nonatomic,assign)int m_roomId;
@end
