//
//  DPlistSave.h
//  chat
//
//  Created by dong on 16/4/1.
//  Copyright © 2016年 Dong. All rights reserved.
//
//储存写入plist的数据类
#import <Foundation/Foundation.h>
#import "RegisteredUser.h"
@interface DPlistSave : NSObject
/**
 *  得到文件目录地址
 *
 *  @return 存储的Plist路径
 */
+ (NSString *)getPListFilePath;
//6.26 xiong
/**
 *  读取存入列表的用户数据
 */
+(RegisteredUser*)readUserData;

//用户数据储存
+(BOOL)UserDataLocalStore:(RegisteredUser *)userInfo;
/**
 删除个人信息
 */
+(BOOL)RemoveUserData;
/**
 修改用户积分
 */
+(BOOL)UserModifyTheIntegral:(NSString *)Integral;

//第三方绑定返回字符串本地解析储存
+(BOOL)ThireBindingLocalStore:(NSString *)data;


@end
