//
//  UIViewController+StorageMethods.h
//  chat
//
//  Created by 高超 on 16/4/12.
//  Copyright © 2016年 Dong. All rights reserved.
//
//本地存储延展类
#import <UIKit/UIKit.h>
#import "FriendListModel.h"
#import "NoticeModel.h"
#import "UserPermissionsModel.h"
#import "UserOperation.h"
@interface UIViewController (StorageMethods)

#pragma mark - 消息本地本地存储方法
/**
 跳转登录页面
 */
-(void)pushLodingView:(UIViewController *)vc;

/**
 跳转注册页面
 */
-(void)pushRegisteredView:(UIViewController *)vc;
/**
 *  存储ChatSquare的数据Key数组
 */
-(void)ChatSquareCollecTionDataStorage:(NSMutableArray *)array;
/**
 *  读取ChatSquare的数据Key数组
 */
-(NSMutableArray *)ChatSquareTableDataLocalRead;
/**
 *  消息本地数据储存
 */
-(void)messageLocalStorage:(NoticeModel *)model;
/**
 *  消息本地数据读取
 */
-(NoticeModel *)messageLocalRead;
/**
 *  消息本地数据储存  申请消息
 */
-(void)messageLocalStorageApply:(NoticeModel *)model;
/**
 *  消息本地数据读取 申请消息
 */
-(NoticeModel *)messageLocalReadApply;
/**
 *  删除本地数据对应的Key
 */
-(void)RemoveForKey:(NSString *)key;







/**
 *  个人好友列表储存
 */
-(void)myFriendListLocalStorage:(NSMutableArray *)array;
/**
 *  个人好友列别读取
 */
-(NSMutableArray *)myFriendListLocalRead;
/**
 当好友修改了 签名 头像 名称  透传过来走此方法找出好友列表里对应的好友进行替换信息  并刷新好友列表
 */
-(void)changeFrientSignature:(NSDictionary *)dic type:(changeFriendData)type;
/**
 *  移除好友   或者 有好友解除了和你关系
 */
-(void)RemoveMyFriend:(NSDictionary *)dic;

/**
 *  移除好友   或者 有好友解除了和你关系
 *
 *  @param m_id 好友id
 */
-(void)RemoveMyFriendID:(NSString *)m_id;
/**
 *  获取当前时间
 *
 *  @return yyyy年MM月dd日HH小时mm分钟ss秒SSS毫秒
 */
-(NSString *)tellMeTime;
/**
 *  获取当前时间
 *
 *  @return yyyy年MM月dd日HH小时mm分钟ss秒SSS毫秒
 */
-(NSString *)tellMeTimeSS;
/**
 *  获取当前时间 这里不从服务器获取 从本地获取
 *
 *  @return yyyy年MM月dd日HH小时mm分钟ss秒SSS毫秒
 */
-(NSString *)tellMeTimeSSNew;
/**
 *  获取当前时间 格式yyyy-MM-dd HH:mm:ss
 */
-(NSString *)tellMeTimeTwo;
/**
 *  获取当前精确时间到SS
 *
 *  @return yyyy年MM月dd日HH小时mm分钟ss秒SSS毫秒
 */
-(NSString *)tellMeAccurateTime;
/**
 *  获取用户Id
 *
 *  @return uid
 */
-(NSString *)giveMeUid;
/**
 *  清空所以本地缓存
 */
-(void)clear;
//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password roomId:(NSString *)roomid;



#pragma mark --附近地址
/**
 *  取位置信息
 *
 *  @return
 */
-(NSMutableDictionary *)TakePositionInfo;
/**
 *  存储位置信息
 *
 *  @param dic
 */
-(void)storagePositionInfo:(NSMutableDictionary *)dic;
/**
 *  取位置信息UID
 *
 *  @return
 */
-(NSString *)TakePositionUID;
/**
 *  存储位置信息UID
 *
 *  @param dic
 */
-(void)storagePositionUID:(NSString *)str;

/**
 *  储存各个附近地点数组
 *
 *  @param array 数组
 *  @param type  类型
 */
-(void)storagePosittionArray:(NSMutableArray *)array type:(LocationType)type;
/**
 *  获取各个附近地点数组
 *
 *  @param type 类型
 *
 *  @return
 */
-(NSMutableArray *)TakePosittionArrayType:(LocationType)type;
/**
 *  读取消息数
 *
 *  @return
 */
-(NSString *)TakeAllMessageNumber;
/**
 *  本地储存消息数
 *
 *  @param number
 */
-(void)storageAllMessageNumber:(NSString *)number;
/**
 *  删除本地储存的地点数组 和 地点选择的数据
 */
-(void)deletePosittion;
/**
 *  给Lable添加阴影效果
 *
 *  @param label label
 */
-(void)AddShadowEffectLable:(UILabel *)label;
/**
 *  给群组Lable添加阴影效果
 *
 *  @param label label
 */
-(void)AddShadowEffectLableGroup:(UILabel *)label;
/**
 *  调整字体行间距
 *
 *  @param label
 */
-(void)AddSpacingLabel:(UILabel *)label;


-(void)pushChatRoomController;

/**
 /////  和当前时间比较
 ////   1）1分钟以内 显示        :    刚刚
 ////   2）1小时以内 显示        :    X分钟前
 ///    3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 ///    4) 今年显示              :   09月12日
 ///    5) 大于本年      显示    :    2013/09/09
 **/
- (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate;

/**
 计算聊天室里面剩余时间
 */
- (NSString *)ChatFormateDate:(NSString *)dateString;
//计算聊天广场时间
- (NSString *)ChatSquareFormateDate:(NSString *)dateString withFormate:(NSString *) formate;
/**
 判断条件并弹出提示框
 */
-(BOOL)promptMessageOperationType:(UserOperationType)type;
/**
 *  判断用户等级操作
 */
-(UserOperation *)DetermineTheUserLevelOperationType:(UserOperationType)type;
/**
 *  单个好友写入 用于跳界面
 */
-(void)writefriendAlone:(FriendListModel *)model;
/**
 *  单个好友读取 用于跳界面
 */
-(FriendListModel *)readfriendAlone;

#pragma 判断空格 

//判断内容是否全部为空格  yes 全部为空格  no 不是
- (BOOL) isEmpty:(NSString *) str;

/**
 判断是否含有空格
 */
-(BOOL) isHaveEmpty:(NSString *)str;


/**
 *  获取用户EaseID
 *
 *  @return uid
 */
-(NSString *)giveMeEaseID;
//消息列表保存
-(void)storageMessageList:(NSString *)easeID;
//读取消息列表
-(void)readMessageList:(NSString *)easeID;

//删除所有用户储存的  用户系统消息 和 申请消息 和 消息提示设置
-(void)removeUserMessageandSet;
//存储房间K_roomName
-(void)strongRoomName:(NSString *)str;
//读取房间K_roomName
-(NSString *)readRoomName;


/**
 输入限制计算方法
 
 @param label 输入的TextField
 @param number 输入个数显示Label
 @param limit 规则 输入几个字符的字
 */
-(NSInteger)stringConvertTo:(UITextField *)textField numberLabel:(UILabel *)number limitNuber:(NSInteger)limit;



/**
 输入限制计算方法
 
 @param label 输入的TextField
 @param number 输入个数显示Label
 @param limit 规则 输入几个字符的字
 */
-(NSInteger)stringConvertToView:(UITextView *)textView numberLabel:(UILabel *)number limitNuber:(NSInteger)limit;
/**
 计算字符串多少字节
 */
-(NSInteger)stringConvertTo:(NSString *)toBeString;
/**
 用户第三方登陆名称注册时用的
 */
-(void)stringConvertToUserName:(UITextField *)textField  limitNuber:(NSInteger)limit;
/**
  判断是否登陆并是否跳转登录

  @param BOOL <#BOOL description#>
  @return <#return value description#>
  */
-(BOOL)isLoginPush:(BOOL)bo pushLodingViewL:(UIViewController*)vc;


//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size image:(UIImage *)image;
@end
