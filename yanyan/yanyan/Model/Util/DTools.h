//
//  DTools.h
//  storm
//
//  Created by dong on 15/7/8.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>//相册ios8
#import <Photos/Photos.h>//相册ios10
#import "DEnumClass.h"
#import "FriendListModel.h"
typedef void  (^completeBlock)(BOOL);
@interface DTools : NSObject

@property(nonatomic,copy)completeBlock m_completeblock;
//判断是否为空字符串
+(BOOL)isStringEmpty:(NSString * )aStr;
//软件信息获取
+(NSString*)getVersion;
+(NSString*)getSoftName;
/**
 判断是否有特殊字符存在
 */
+(BOOL)filterSpecialStringJudge:(NSString *)str;
/**
 判断是否存在自己设定的特殊字符
 */
+(BOOL)filterSpecialStringJudge:(NSString *)str  Rules:(NSString *)rules;
/**
 *  切圆角
 */
+(void)getAvaterCorner:(UIView*)v;
/**
 还原圆角
 */
+(void)getZeroAvaterCorner:(UIView *)v;

+ (void)setGraphicsCutCirculayWithView:(UIImageView *) view roundedCornersSize:(CGFloat )cornersSize;
//
/**
 *  切圆角标签默认6
 */
+(void)getLabelCorner:(UIView*)v;

+(void)getCorner:(UIView*)v radius:(CGFloat)radius;
//加边框
+(void)getBorder:(UIView*)v Width:(CGFloat)f andColor:(CGColorRef)color;
//切圆形图
+(void)setImageView:(UIView*)view;

+(NSString *)currentTime;
//得到view的viewController
+(UIViewController*)getViewController:(UIView*)view;

//iphone应用变成中，不识别16进制的表示法，需要转化成rgb表示法
+(UIColor *) getColor:(NSString *)hexColor;

//是否有表情
+(BOOL)stringContainsEmoji:(NSString *)string;


+(NSDictionary *)getIsNull:(NSDictionary *)dic;

//时间差
+(NSString *)getTime:(NSString *)times;
/**
 *  得到2者之间的距离
 *
 *  @return 距离
 */
+(NSString *)getBetweenDistance:(NSString*)lat lng:(NSString*)lng;
/**
 *  得到用户的年龄
 *
 *  @return 年龄
 */
+(NSString *)getUserAge:(NSString*)birth;

#pragma mark - 是否定位储存
/**
 *  定位储存 是否开启
 *
 *  @param storage 定位开关
 */
+(void)positioningMessageStorage:(BOOL)storage;
/**
 *  读取定位是否开启
 *
 *  @return 是否开启了定位
 */
+(BOOL)positioningMessageRead;

#pragma mark - 本地储存黑名单
/**
 *  存储黑名单列表
 */
+(void)storageUserBlackList:(NSMutableArray *)array;

/**
 *  获取黑名单
 */
+(NSMutableArray *)haveStorageUserBlackList;

/**
 *  判断黑名单是否有此用户
 */
+(BOOL)judgeBlackListUserID:(NSString *)userID;

/**
 *  删除聊天室
 */
+(void)DeleteCurrentPage;

/**
 *  存储感兴趣时间 1分钟 感兴趣3次
 */
+(void)StoredInterestedTimeOneMin:(NSString *)time KName:(NSString *)name;
/**
 *  对比3次次点击事件间隔是否为1分钟
 */
+(BOOL)compareTouch:(NSString*)newTime KName:(NSString *)name;
/**
 *  取出存储时间感兴趣数组
 */
+(NSMutableArray *)TakeOutInterestedTimeArrayKName:(NSString *)name;



/**
 *  转换时间
 *  @param time 给我剩余时间
 */
+(NSString *)ConversionTime:(NSString *)time;
/**
 跟上面不一样的格式
 */
+(NSString *)ConversionTimeTwoFormat:(NSString *)time;
/**
 *  转换时间 不需要加当前时间 直接是1970年到到期时间的秒数  我自己直接转化成到期时间
 */
+(NSString *)ConversionTimeTwo:(NSString *)time;
/**
 计算新闻聊天内容刷新整点
 */
+(NSString *)NewConversionTime:(NSString *)time;
/**
 *  对比时间 过了多久
 */
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02;
/**
 *  存储感兴趣时间 登录时会告诉你多少秒 先转换到什么时候到时间在传给我去储存
 */
+(void)StoredInterestedTime:(NSString *)time;
/**
 *  取出存储时间
 */
+(NSString *)TakeOutInterestedTime;

/**
 * 判断消息身份   是否发送方
 * type  0 普通 1 管理员 2 创建人 3 群主    
 * direction  YES 发送方  NO 非发送方
 */
+(UIImage *)ChatDubbleDetermineType:(ChatInfoType)type direction:(BOOL)direction;
/**
 读取等级提示信息
 
 */
+(NSString *)userReadLevelCluesLevel:(NSString *)userlevel;
/**
 ID是否是我自己
 */
+(BOOL)IFMyID:(NSString *)id;
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

/**
 比较好友
 
 @param uid 好友id
 
 @return YES 是 好友 no 非好友
 */
+(BOOL)compareIsFriend:(int)uid;
//6.26 xiong
/**
 比较好友 返回Model
 
 */
+(FriendListModel *)CompareIsFriendModelEaseId:(NSString *)easeid;
/**
 比较好友
 
 @param uid 好友id
 
 @return YES 是 好友 no 非好友
 */
+(BOOL)compareIsFriendEaseId:(NSString *)uid;

/**
 通过环信用户id 获取好友用户id
 
 @param uid 用户环信id
 @return 用户id
 */
+(int)compareXSDIsFriendEaseId:(NSString *)uid;
/**
 
 用户是否开始定位
 
 @return Yes
 */
+(BOOL)userIsOpenLocation;

#pragma 判断空格

//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL) isEmpty:(NSString *) str;

/**
 判断是否含有空格
 */
+(BOOL) isHaveEmpty:(NSString *)str;

/**
 去除首尾空格和换行
 */
+(NSString *)filterString:(NSString *)str;



/**
 存储好友请求时间
 */
+(void)recordFriendsListRequestTime:(NSString *)time;

/**
 好友列表是否可以请求
 */
+(BOOL)reqFriendListNowTime:(NSString *)nowTime;

/**
 存储群组请求时间
 */
+(void)recordGroupListRequestTime:(NSString *)time;
/**
 群组列表是否可以请求
 */
+(BOOL)reqGroupListNowTime:(NSString *)nowTime;

#pragma mark - 本地储存最后一次消息时间

/**
 存储 申请消息 或者  系统消息最后一次时间
 */
+(void)storageLastMessageTime:(NSString *)time;
/**
 取出 申请消息或者 系统最后一次时间
 */
+(NSString *)TakeLastMessageTime;

/**
 检测敏感字
 
 @param word 字符串
 @return bool
 */
+(BOOL)isWordSensitive:(NSString *)word;
//麦克风
+ (BOOL)isCanUseMicrophone;
//相机
+ (BOOL)isCanUseCamera;
//相册
+ (BOOL)isCanUsePhotos;
//统计未读数
+(void)refreshUnreadMessage;

/**
 判断账号是否还在全局禁言
 */
+(BOOL)whetherGlobalSilence;
//去掉特殊字符
+(NSString *)filterSpecialString:(NSString *)str;

+ (PHImageRequestID)getPhotoWithAsset:(id)asset isSynchronous:(BOOL)isSynchronous photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed;
+(void )GetPhoto:(id)m_asset completion:(void (^)(UIImage *photo))completion;
+(NSString * )photoIdefer:(id)asset;
/**
 解析原图@缩略图
 */
+(NSMutableDictionary *)ImageResolution:(NSString *)str;
+(CGFloat) getRatioSize:(CGFloat) bitWidth bitHeight:(CGFloat) bitHeight ;
/**
 图片缩放
 
 @param img 原图
 @return 缩放图片
 */
+ (UIImage *)scaleToSize:(UIImage *)img;
/**
 聊天室结束  2个小时
 */
+(void)chatRoomEnd;

/**
 是否登陆
 */
+(BOOL)isLogin;
/**
 给按钮添加等待动画
 */
+(void)buttonWaitForHUD:(UIButton *)btn HUD:(BOOL)hud;

/**
 自改 2017  05 08  获取data gif
 */
+ (NSData *)xsd_dataGIFNamed:(NSString *)name;
/**
 给按钮添加完成动画
 */
+(void)buttonCompleteHUD:(UIButton *)btn blockBtn:(void(^)(bool isDown))blockbtn;
//弹窗框提示
+ (void)alertController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message handler:(void (^ __nullable)(UIAlertAction *action))handler;



@end
