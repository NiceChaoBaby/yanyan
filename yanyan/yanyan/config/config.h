//
//  config.h
//  storm
//
//  Created by dong on 15/7/7.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#ifndef storm_config_h
#define storm_config_h


#endif
#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)
#import "AppDelegate.h"

//主程序delegate
#define ShareAppDelegate         ((AppDelegate*)[UIApplication sharedApplication].delegate)

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//是否是ios7系统
#define ISIOS7    ([[[UIDevice currentDevice]systemVersion]floatValue] >=7.0)

//是否是ios8系统
#define ISIOS8    ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)

//是否是ios10系统
#define ISIOS10   ([[[UIDevice currentDevice]systemVersion]floatValue] >=10.0)

#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)

#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)

#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

/************** 单位   *************************/
#define MAXFLOAT    0x1.fffffep+127f
#define FirstFLOAT  60
//算所有的宽高  不用除以2
#define RW(designWidth)  (designWidth*LCDW/750)

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])


//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1472), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//定义UIImage对象
#define ImageNamed(imageName) [UIImage imageNamed:imageName]

//提示框
#define KSHOWALERT(A,B) do {UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil message:(A) delegate:nil cancelButtonTitle:(B) otherButtonTitles:nil, nil];[alert show];} while (0)
//提示框
#define UtilAlert(title, msg) { \
UIAlertView *dialAlert = [[UIAlertView alloc] initWithTitle:title \
message:msg \
delegate:nil \
cancelButtonTitle:nil \
otherButtonTitles:@"确定",nil]; \
[dialAlert show]; \
}

#pragma mark =================================================
#pragma makr 获取自定义颜色
#define RGBFromRGBA(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define RGBBgNavColor RGBACOLOR(0,196,186,1)//特殊文字，入导航栏右侧文字按钮 #00C4BA
#define RGBBgColor RGBACOLOR(238,238,238,1)// 默认背景色（非聊天），#EEEEEE
#define RGBBgChatColor RGBACOLOR(240,240,240,1)//默认聊天背景色，#F0F0F0
#define RGBLineColor RGBACOLOR(223,223,221,1)//正常行间1px分割线#DFDFDD
#define RGBRoleColor RGBACOLOR(255,153,0,1)// 角色扮演，#ff9900
#define RGBTopLineColor RGBACOLOR(216,214,214,1)//顶部、底部栏1px分割线#D8D6D6
#define RGBBgFemaleLabColor RGBACOLOR(247,120,198,1)//女性用户粉色标签背景色#F778C6
#define RGBBgMaleLabColor RGBACOLOR(72,174,233,1)//男性用户蓝色标签背景色#48AEE9
#define RGBWhiteColor RGBACOLOR(255,255,255,1)//白色字体，按钮和导航栏等#FFFFFF
#define RGBAssistColor RGBACOLOR(179,179,179,1)//灰底辅助字体，#B3B3B3
#define RGBPlaysHode   RGBACOLOR(199,199,205,1)//UITextField提示字体颜色
#define RGBAddAssistColor RGBACOLOR(117,117,117,1)//加深辅助字体，#757575
#define RGBChatTextColor RGBACOLOR(68,68,68,1)//黑色聊天文字，主题字体，#444444
#define RGBShareColor RGBACOLOR(242,242,242,1) //分享背景颜色
#define RGBCurrentLocationColor RGBACOLOR(179,179,179,1)//群位置未选中
#define RGBLocationColor RGBACOLOR(0,196,186,1)//群位置选中
#define RGBRedColor RGBACOLOR(255,59,48,1)//消息未设置打扰颜色 FF3B3O
#define RGBBlueColor RGBACOLOR(105,221,215,1)//消息设置了免打扰颜色69DDD7
#define RGBcircleOneColor RGBACOLOR(253,101,202,1)//第一个圈颜色  #fd65ca
#define RGBcircleTwoColor RGBACOLOR(0,196,186,1)//第二个圈颜色  #00c4ba
#define RGBcircleThreeColor RGBACOLOR(14,122,255,1)//第三个圈颜色 #0e7aff
#define RGBcircleFourColor RGBACOLOR(254,147,8,1)//第四个圈颜色 #fe9308
#define RGBredColor RGBACOLOR(255,59,48,1)//奖励积分红色 #ff3b30
#define RGBCellDeselectColor  RGBACOLOR(238,238,238,1)
#define UIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0green:(((s &0xFF00) >>8))/255.0blue:((s &0xFF))/255.0alpha:1.0]

//话题聊天室颜色
/**
 *  自己感兴趣  #eb4f38
 */
#define RGBMyInterestColor RGBACOLOR(255,59,48,1)
/**
 *  自己还未感兴趣 #2BDBD5
 */
#define RGBInterestColor RGBACOLOR(105,211,215,1)
/**
 *  聊天中 或者 已结束  #ff9900
 */
#define RGBBeginChatColor RGBACOLOR(255,188,43,1)


#define LCDW    ([[UIScreen mainScreen] bounds].size.width)

#define LCDHH    ([[UIScreen mainScreen] bounds].size.height)
#define LCDH    ([[UIScreen mainScreen] bounds].size.height-20)
#define TITLE_H  44
#define TITLES_H  64
#define LCDH_H  (([[UIScreen mainScreen] bounds].size.height-20)-44)
#define TAB_H  49
#define SizeScale ((LCDW > 375) ? 1.03 : LCDW/375)
//#define SizeScale 1
#define FRAME_W self.frame.size.width
#define FRAME_H self.frame.size.height
#define SaveVideoPath @"/VideoPath"
//外网api---16内test
#define WIFIURL         @"http://testchat.leiyu.tv"
//内网1
#define NOWIFIURL       @"http://192.168.1.103:6000"

//登录的用户i
#define UserDefaultNameKey  @"uid"
#define UserDefaultName  @"name"
//code登录之后服务器返回的编码
#define UserDefaultCodeKey  @"code"
//用户定位信息
#define UserLocationLo  @"longitude"//经度
#define UserLocationLa  @"latitude"//纬度
#define UserLocationAddress  @"address"//地址
#define UserLocationAddressProvince  @"province"//省份
#define UMAPP_KEY @"5547417267e58edbdc003c78"
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
#define KNOTIFICATION_LOGINTHREE  @"loginthree"
#define THREEBUDING_UPDATA       @"threebudingUpdata"
#define KNOTIFICATION_CHANGEPLACE @"changePlace"
#define KNOTIFICATION_REFRESHDATA @"refreshData"
#define KNOTIFICATION_CHANGEROOM @"chatchangeroom"
#define KNOTIFICATION_SEARCHCHATROOM @"searchchatroom"

//#define ChatTV @"http://chat.leiyu.tv/"

