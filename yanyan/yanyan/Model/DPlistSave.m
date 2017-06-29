//
//  DPlistSave.m
//  chat
//
//  Created by dong on 16/4/1.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "DPlistSave.h"

@implementation DPlistSave
/**
 *  得到文件目录地址
 *
 *  @return 存储的Plist路径
 */
+ (NSString *)getPListFilePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) safeObjectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"LoginView.plist"];
    return path;
}

//6.26 xiong

/**
 *  读取存入列表的用户数据
 */
+(RegisteredUser*)readUserData
{
    NSString *path = [DPlistSave getPListFilePath];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
//    NSDictionary * userData = [dictionary objectForKey:K_login];
//    return  [RegisteredUser mj_objectWithKeyValues:userData];
    NSData * data = [dictionary objectForKey:K_login];
    RegisteredUser * model = (RegisteredUser*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return  model;
}

//用户数据储存
+(BOOL)UserDataLocalStore:(RegisteredUser *)userInfo
{
    
    NSString *path = [DPlistSave getPListFilePath];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (dicData==nil)
    {
        dicData=[[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    [dicData removeAllObjects];
     NSData * data = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [dicData setObject:data forKey:K_login];
    BOOL isSuccess=[dicData writeToFile:path atomically:YES];
    if (isSuccess)
    {
        return YES;
        
    }else
    {
        return NO;
        
    }
}

/**
 删除个人信息
 */
+(BOOL)RemoveUserData
{
    NSString *path = [DPlistSave getPListFilePath];
    NSMutableDictionary *dicData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
//    if (dicData!=nil)
//    {
         [dicData removeObjectForKey:K_login];
         [dicData removeAllObjects];
         BOOL isSuccess=[dicData writeToFile:path atomically:YES];
        if (isSuccess)
        {
            return YES;
            
        }else
        {
            return NO;
            
        }
//    }
}
//修改用户积分
+(BOOL)UserModifyTheIntegral:(NSString *)Integral
{
    
    RegisteredUser * model = [DPlistSave readUserData];
    
    model.m_integral = Integral;
    
    return [DPlistSave UserDataLocalStore:model];
    
    
}
//第三方绑定返回字符串本地解析储存
+(BOOL)ThireBindingLocalStore:(NSString *)data
{
    
    data = [data substringFromIndex:1];
    
    
    NSMutableArray *strarray = (NSMutableArray *)[data componentsSeparatedByString:@"|"];
    
    for ( NSString * code in strarray) {
        if ([code  isEqual:@""]) {
            [strarray removeObject:code];
            break;
        }
    }
//    for (int i = 0; i < strarray.count; i ++) {
//        = strarray[i];
//        if ([code  isEqual:@""]) {
//            [strarray removeObjectAtIndex:i];
//            i = 0;
//        }
//    }
    RegisteredUser * m_userData = [DPlistSave readUserData];
    [m_userData.m_thirdArray removeAllObjects];
    [m_userData.m_thirdArray addObjectsFromArray:strarray];
    m_userData.m_thirdInfo = data;
    NSDictionary * dic = [m_userData mj_keyValues];
    DLog(@"%@",dic);
    RegisteredUser * userModel = [RegisteredUser mj_objectWithKeyValues:dic];
    BOOL a =  [DPlistSave UserDataLocalStore:userModel];
    if (a) {
        return YES;
        DLog(@"成功");
    }else{
        return NO;
        DLog(@"失败");
    }
 
    
    
    
    
    
}

@end
