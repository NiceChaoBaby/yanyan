//
//  HXmodel.h
//  chat
//
//  Created by 高超 on 16/3/21.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "DModel.h"

@interface HXmodel : DModel
/**
 * 环信登陆账号
 **/
@property(nonatomic,strong)NSString * m_HXname;
/**
 * 环信登陆密码
 **/
@property(nonatomic,strong)NSString * m_HXpasswd;


@end
