//
//  URLPath.m
//  storm
//
//  Created by dong on 15/7/14.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import "URLPath.h"
#import "UIDevice+DeviceCode.h"
#import "NSDictionary+Safety.h"
@implementation URLPath
+ (NSString*)getBasicUrl
{
        if (ShareAppDelegate.isWifi)
        {
            return [NSString stringWithFormat:@"%@/index.php",WIFIURL];
        }
        else
        {
            return [NSString stringWithFormat:@"%@/index.php",NOWIFIURL];
    
        }

}


//取设备模型
+ (NSString *)getDeviceModel
{
    
    return @"iphone";
}

#pragma mark ==============
#pragma mark 系统类---设备注册,版本检查
//+(NSMutableDictionary*)getBasicParameterDic
//{
//    NSMutableDictionary*postDic = [[NSMutableDictionary alloc] init];
//    [postDic safeSetObject:[self getToken] forKey:@"token"];
//    return postDic;
//}
+(NSMutableDictionary*)getBasicParameterDic
{
    //得到用户保存的uid和code
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uidStr=[accountDefaults objectForKey:UserDefaultNameKey];
    
    NSMutableDictionary*postDic = [[NSMutableDictionary alloc] init];
    NSString *uid;
   
    if (![uidStr isNull])
    {
        uid=uidStr;
        if (ShareAppDelegate.isWifi)
        {
            //56  自己26  12
            uid=uidStr;
        }else
        {
            uid=@"26";
        }
    }else
    {
        uid=uidStr;
        if (ShareAppDelegate.isWifi)
        {
            uid=uidStr;
        }else
        {
            uid=@"26";
        }
    }
    
 
    [postDic safeSetObject:uid forKey:K_uid];
  
    return postDic;
}
/**c
 *  设备注册
 *
 *  @param aCityCode 城市code
 *
 *  @return post数据字典  内含  url  和参数
 */
+(NSDictionary*)registerDevidence:(NSString*)pushToken
{
    NSMutableDictionary*postDic = [[NSMutableDictionary alloc] init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@/deviceinfos/saveDeviceInfos",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary*parameterDic = [[NSMutableDictionary alloc] init];//[self getBasicParameterDic];
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称当前应用名称
    [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // 当前应用软件版本  比如：1.0.1当前应用软件版本
    [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // 当前应用版本号码   int类型当前应用Build版本代号
    [infoDictionary objectForKey:@"CFBundleVersion"];
    
    [parameterDic safeSetObject:[self getDeviceModel] forKey:@"system"];
    [parameterDic safeSetObject:[[UIDevice currentDevice] getDeviceCode] forKey:@"device_code"];
    [parameterDic safeSetObject:[infoDictionary objectForKey:@"CFBundleVersion"] forKey:@"versions"];
    if (pushToken!=nil&&pushToken.length>0)
    {
        [parameterDic safeSetObject:pushToken forKey:@"push_code"];
    }
    else
    {
        [parameterDic safeSetObject:@"" forKey:@"push_code"];
    }
    [parameterDic safeSetObject:@"Apple" forKey:@"phone_brand"];
    [parameterDic safeSetObject:[[UIDevice currentDevice] model] forKey:@"phone_model"];
    [parameterDic safeSetObject:[[UIDevice currentDevice] systemVersion] forKey:@"api_level"];
    [parameterDic safeSetObject:@"445dpi" forKey:@"density"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}



/*-------------------------------------------------------------------------------
 华丽丽的分割线
 ---------------------------------------------------------------------------------*/

#pragma mark - 登陆相关数据方法
/**
 *  检查手机号是否注册
 *
 *  @param phoneNumber 手机号
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetUpDataP:(NSString *)phoneNumber code:(NSString *)vcode
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=checkphone",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:phoneNumber forKey:@"phone"];
    [parameterDic safeSetObject:vcode forKey:@"vcode"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  重置密码前检查
 *
 *  @param phoneNumber 手机号
 *  @param vcode       验证码
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetResetP:(NSString *)phoneNumber code:(NSString *)vcode
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=resetpwdstep1",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:phoneNumber forKey:@"phone"];
    [parameterDic safeSetObject:vcode forKey:@"vcode"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
    
    
}
/**
 *  注册
 *
 *  @param phoneNumber 手机号
 *  @param pwd         密码
 *  @param birthday    生日
 *  @param gender      性别
 *  @param nickname    昵称
 *  @param dfa         默认头像编号
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRegisteDataP:(NSString *)phoneNumber pwd:(NSString *)pwd birthday:(NSString *)birthday gender:(NSString *)gender nickname:(NSString *)nickname code:(NSString *)code lng:(NSString *)lng lat:(NSString *)lat dfa:(NSString *)dfa
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=register",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:phoneNumber forKey:@"phone"];
    [parameterDic safeSetObject:pwd forKey:@"passwd"];
    [parameterDic safeSetObject:birthday forKey:@"birthday"];
    [parameterDic safeSetObject:gender forKey:@"gender"];
    [parameterDic safeSetObject:nickname forKey:@"nickname"];
    [parameterDic safeSetObject:code forKey:@"vcode"];
    [parameterDic safeSetObject:lng forKey:@"lng"];
    [parameterDic safeSetObject:lat forKey:@"lat"];
    [parameterDic safeSetObject:dfa forKey:@"dfa"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  登陆
 *
 *  @param phoneNumber 手机号码
 *  @param pwd         密码
 *  @param lng         经度
 *  @param lat         纬度
 *  @param addr        地址
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetLoginDataP:(NSString *)phoneNumber pwd:(NSString *)pwd lng:(NSString *)lng  lat:(NSString *)lat addr:(NSString *)addr
{
//    DLog(@"%@",pwd);
//    NSLog(@"%@",pwd);
//   pwd= [pwd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=loginphone",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:phoneNumber forKey:@"phone"];
    [parameterDic safeSetObject:pwd forKey:@"passwd"];
    [parameterDic safeSetObject:lng forKey:@"lng"];
    [parameterDic safeSetObject:lat forKey:@"lat"];
    [parameterDic safeSetObject:addr forKey:@"addr"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  获取验证码
 *
 *  @param phoneNumber 手机号
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetObtainCodePhoneNmuber:(NSString *)phoneNumber
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=verifycode",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:phoneNumber forKey:@"phone"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  定位进入聊天室
 *
 *  @param lng         经度
 *  @param lat         纬度
 *  @param addr        地址
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetLocationChatRoomDataP:(NSString *)lng  lat:(NSString *)lat addr:(NSString *)addr
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=enter",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:lng forKey:@"lng"];
    [parameterDic safeSetObject:lat forKey:@"lat"];
    [parameterDic safeSetObject:addr forKey:@"addr"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  第三方登陆
 *
 *  @param account   第三方平台账号
 *  @param thirdplat 平台
 *  @param avatar    头像文件
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetThirdPartyaccountP:(NSString *)account thirdplat:(NSString *)thirdplat
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=loginthirdplat",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:account forKey:@"account"];
    [parameterDic safeSetObject:thirdplat forKey:@"thirdplat"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 第三方注册
 
 @param account 第三方平台账号
 @param thirdplat 平台
 @param avatar 头像文件
 @param nickname 昵称
 @param gender 性别
 @param birthday 生日
 @param lng 经度
 @param lat 纬度
 @param addr 地址
 @return
 */
+(NSDictionary *)getNetThirdPartyRegisterAccount:(NSString *)account Thirdplat:(NSString *)thirdplat  Nickname:(NSString*)nickname Gender:(NSString *)gender Birthday:(NSString *)birthday lng:(NSString *)lng lat:(NSString *)lat addr:(NSString *)addr
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=thirdregister",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:account forKey:@"account"];
    [parameterDic safeSetObject:thirdplat forKey:@"thirdplat"];
    [parameterDic safeSetObject:nickname forKey:@"nickname"];
    [parameterDic safeSetObject:gender forKey:@"gender"];
    [parameterDic safeSetObject:birthday forKey:@"birthday"];
    [parameterDic safeSetObject:lng forKey:@"lng"];
    [parameterDic safeSetObject:lat forKey:@"lat"];
    [parameterDic safeSetObject:addr forKey:@"addr"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  绑定第三方账号
 *
 *  @param account   第三方平台账号
 *  @param thirdplat 平台
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetBindingThirdPartyaccountP:(NSString *)account thirdplat:(NSString *)thirdplat
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=bindaccount",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];;
    [parameterDic safeSetObject:account forKey:@"account"];
    [parameterDic safeSetObject:thirdplat forKey:@"thirdplat"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    
    return postDic;
}


/**
 *  取消第三方账号绑定
 *
 *  @param account   第三方平台账号
 *  @param thirdplat 平台
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetCancelBindingThirdPartyaccountP:(NSString *)account thirdplat:(NSString *)thirdplat
{
    
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=unbindaccount",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:account forKey:@"account"];
    [parameterDic safeSetObject:thirdplat forKey:@"thirdplat"];
   
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    
    return postDic;
    
}



#pragma mark -  个人资料数据修改方法

/**
 *  重置密码
 *
 *  @param phone    手机号
 *  @param password 新密码
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetResetPasswordPhone:(NSString *)phone NewPassword:(NSString *)password code:(NSString *)vcode
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=resetpass",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:phone forKey:@"phone"];
    [parameterDic safeSetObject:password forKey:@"passwd"];
    [parameterDic safeSetObject:vcode forKey:@"vcode"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  修改手机号
 *
 *  @param phone 新手机号
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairPhoneP:(NSString *)phone code:(NSString *)vcode
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=updatephone",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:phone forKey:@"phone"];
    [parameterDic safeSetObject:vcode forKey:@"vcode"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  绑定手机号
 *
 *  @param phone  手机号
 *  @param passwd 密码
 *  @param code   验证码
 *
 *  @return 数据
 */
+(NSDictionary *)getNetBindingPhoneNumber:(NSString *)phone password:(NSString *)passwd code:(NSString *)code
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=bindphone",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:phone forKey:@"phone"];
    [parameterDic safeSetObject:passwd forKey:@"passwd"];
    [parameterDic safeSetObject:code forKey:@"vcode"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  修改昵称
 *
 *  @param nickname 用户新昵称
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairNamenicknameP:(NSString *)nickname
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=updatenickname",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];;
    [parameterDic safeSetObject:nickname forKey:@"nickname"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  修改生日
 *
 *  @param birthday 新生日
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairBirthdayP:(NSString *)birthday
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=updatebirthday",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];;
    [parameterDic safeSetObject:birthday forKey:@"birthday"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  修改密码
 *
 *  @param oldpwd 旧密码
 *  @param passwd 新密码
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairpasswdoldpwdP:(NSString *)oldpwd passwd:(NSString *)passwd
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=updatepasswd",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];;
    [parameterDic safeSetObject:oldpwd forKey:@"oldpwd"];
    [parameterDic safeSetObject:passwd forKey:@"passwd"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  修改头像
 *
 *  @return 用AFNPost上传头像  这里上传UID
 */
+(NSDictionary *)getNetRepairUserPhotoavatarP
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=updateavatar",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  修改签名
 *
 *  @param signature 新的签名
 *
 *  @return post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairUsersignatureP:(NSString *)signature
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=updatesignature",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];;
    [parameterDic safeSetObject:signature forKey:@"signature"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


/**
 *  用户故乡修改
 *
 *  @param home 故乡
 *
 *  @return post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairuserHomeP:(NSString *)home
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=uphome",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];;
    [parameterDic safeSetObject:home forKey:@"home"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  用户兴趣修改
 *
 *  @param intrest 兴趣
 *
 *  @return post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairuserIntrestP:(NSString *)intrest
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=upintrest",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];;
    [parameterDic safeSetObject:intrest forKey:@"intrest"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}

/**
 *  用户感情修改
 *
 *  @param emotion 用户感情
 *
 *  @return post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairuserEmotionP:(NSString *)emotion
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=upemotion",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:emotion forKey:@"emotion"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


/**
 *  获取用户信息
 *
 *  @param uid 获取的UID
 *
 *  @return post数据字典  内含  url  和参数
 */

+(NSDictionary *)getNetUserDtatG:(NSString *)uid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=getuserinfo",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =  [self getBasicParameterDic];
     [parameterDic safeSetObject:uid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  获取用户收到的申请或邀请
 *
 *  @return get
 */

+(NSDictionary *)getNetObtainInvitationG
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=recvlist",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
#pragma mark -  群组相关操作方法
/**
 *  创建群
 *
 *  @param name   群名
 *  @param desc   描述
 *  @param label  群组标签
 *  @param addr   群地址
 *  @param addrid 地点
 *  @param lng    经度
 *  @param lat    纬度
 *
 *  @return Post
 */
+(NSDictionary *)getNetCreateGroupnameP:(NSString *)name desc:(NSString *)desc label:(NSString *)label addr:(NSString *)addr addrid:(NSString *)addrid lng:(NSString *)lng lat:(NSString *)lat
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=create",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:name forKey:@"name"];
    [parameterDic safeSetObject:desc forKey:@"desc"];
    [parameterDic safeSetObject:label forKey:@"label"];
    [parameterDic safeSetObject:addr forKey:@"addr"];
    [parameterDic safeSetObject:addrid forKey:@"addrid"];
    [parameterDic safeSetObject:lng forKey:@"lng"];
    [parameterDic safeSetObject:lat forKey:@"lat"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


/**
 *  修改群名
 *
 *  @param gid  群组id
 *  @param name 群名称
 *
 *  @return POST
 */
+(NSDictionary *)getNetModifyGroupNamegidP:(NSString *)gid name:(NSString *)name
{
    
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=updatename",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:name forKey:@"name"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  修改群地址
 *
 *  @param gid    群ID
 *  @param addr   群地址
 *  @param addrid 群地址ID
 *
 *  @return Post
 */
+(NSDictionary *)getNetModifyGroupAddrgidP:(NSString *)gid addr:(NSString *)addr addrid:(NSString *)addrid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=updateaddr",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:addr forKey:@"addr"];
    [parameterDic safeSetObject:addrid forKey:@"addrid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  修改群描述
 *
 *  @param gid  群ID
 *  @param desc 群描述
 *
 *  @return POST
 */
+(NSDictionary *)getNetModifyGroupDescgidP:(NSString *)gid desc:(NSString *)desc
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=updatedesc",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:desc forKey:@"desc"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


/**
 *  修改群标签
 *
 *  @param gid   群ID
 *  @param label 群标签
 *
 *  @return POST
 */
+(NSDictionary *)getNetModifyGroupLabelgidP:(NSString *)gid label:(NSString *)label
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=updatelabel",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:label forKey:@"label"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  修改群头像
 *
 *  @param gid    群ID
 *  @param avatar 群头像
 *
 *  @return POST
 */
+(NSDictionary *)getNetModifyGroupPhotogidP:(NSString *)gid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=updateavatar",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  扩充群人数
 *
 *  @param gid    群ID
 *  @param maxnum 人数上限
 *
 *  @return POST
 */
+(NSDictionary *)getNetExpandGroupPeoplegidP:(NSString *)gid maxnum:(NSString *)maxnum
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=expand",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:maxnum forKey:@"maxnum"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  邀请加入群
 *
 *  @param gid 群ID
 *  @param mid 用户1 用户2  用户3 。。。
 *
 *  @return POST
 */
+(NSDictionary *)getNetInvitedJoinGroupgidP:(NSString *)gid mid:(NSString *)mid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=invitemember",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  获取加群邀请详情
 *
 *  @param mid 邀请人
 *  @param gid 群组ID
 *
 *  @return Get数据字典
 */
+(NSDictionary *)getNetAddgroupMessageG:(NSString *)mid gid:(NSString *)gid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=getinviteinfo",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;

    
}

/**
 *  接受加群邀请
 *
 *  @param applyid 邀请信息的ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetAcceptJoinGroupapplyidP:(NSString *)applyid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=accept",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:applyid forKey:@"applyid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  拒绝加群邀请
 *
 *  @param applyid 邀请信息的ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetNoJoinGroupapplyidP:(NSString *)applyid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=refuse",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:applyid forKey:@"applyid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  踢出群
 *
 *  @param gid 群ID
 *  @param mid 成员ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetGetoutGroupgidP:(NSString *)gid mid:(NSString *)mid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=delmember",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  设置管理员
 *
 *  @param gid 群组ID
 *  @param mid 要设置的ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetSetadministratorgidP:(NSString *)gid mid:(NSString *)mid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=setmanager",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  取消管理员
 *
 *  @param gid 群组ID
 *  @param mid 要设置的ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetRevokAdministratorGidP:(NSString *)gid mid:(NSString *)mid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=revokemanager",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  获取用户群组列表
 *
 *  @return POST
 */
+(NSDictionary *)getNetGrouplistG;
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=getgrouplist",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

///**
// *  获取群组成员列表
// *
// *  @param gid 群组ID
// *
// *  @return POST
// */
//+(NSDictionary *)getNetGroupUserlistgidG:(NSString *)gid;
//{
//    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
//    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=getmemberlist",[self getBasicUrl]] forKey:K_URL];
//    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
//    [parameterDic safeSetObject:gid forKey:@"gid"];
//    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
//    return postDic;
//}

/**
 *  关键字搜索群
 *
 *  @param keyword 关键字
 *
 *  @return POST
 */
+(NSDictionary *)getNetSearchGroupkeywordG:(NSString *)keyword page:(NSString *)page
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=seach",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:keyword forKey:@"keyword"];
    [parameterDic safeSetObject:page forKey:@"page"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  通过标签搜索群组
 *
 *  @param label 标签
 *  @param page  页号
 *
 *  @return
 */
+(NSDictionary *)getNetGroupSeachbylabelG:(NSString *)label Page:(NSString *)page
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=seachbylabel",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:label forKey:@"label"];
    [parameterDic safeSetObject:page forKey:@"page"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  获取附近的群
 *
 *  @param lng 经度
 *  @param lat 纬度
 *
 *  @return POST
 */
+(NSDictionary *)getNetNearGrouplngG:(NSString *)lng lat:(NSString *)lat Page:(NSString *)page;
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=neargroup",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:lng forKey:@"lng"];
     [parameterDic safeSetObject:lat forKey:@"lat"];
    [parameterDic safeSetObject:page forKey:@"page"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  加载同一地址更多群组
 *
 *  @param addrID 地址ID
 *  @param page   页数
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetSameAddressG:(NSString *)addr page:(NSString *)page
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=getaddrmore",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:addr forKey:@"addr"];
    [parameterDic safeSetObject:page forKey:@"page"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
    
    
}
/**
 *  获取群信息
 *
 *  @param gid 群ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetGroupInformationgidG:(NSString *)gid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=getinfo",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}

/**
 *  申请加入群
 *
 *  @param gid 群ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetApplyGroupgidP:(NSString *)gid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=join",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}




/**
 *  退出群组
 *
 *  @param gid 群组ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetExitGroupgidP:(NSString *)gid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=leftgroup",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  解散群组
 *
 *  @param gid 群组ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetDissolutionGroupgidP:(NSString *)gid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=dismiss",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  举报群组或用户
 */
+(NSDictionary *)getNetReportTypeP:(NSString *)type whoId:(NSString *)whoid Reason:(NSString *)reason
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=report",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:type forKey:@"type"];
    [parameterDic safeSetObject:whoid forKey:@"who"];
    [parameterDic safeSetObject:reason forKey:@"reason"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  获取最新的群组
 *
 *  @return POST
 */
+(NSDictionary *)getNetLatestGroupListG:(NSString *)minID
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=getlatetlist",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
     [parameterDic safeSetObject:minID forKey:@"min_id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  屏蔽群组成员
 *
 *  @param gid 群组id
 *  @param mid 屏蔽用户
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetGroupBlockP:(NSString *)gid mid:(NSString *)mid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=block",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  取消屏蔽群组成员
 *
 *  @param gid 群组id
 *  @param mid 屏蔽用户
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetGroupUnblockP:(NSString *)gid mid:(NSString *)mid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=unblock",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  获取用户屏蔽群组成员列表
 *
 *  @param gid 群组id
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetGroupBlockListG:(NSString *)gid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=unblock",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  管理员发起禁言
 *
 *  @return
 */
+(NSDictionary *)getNetgroupGagP:(NSString *)gid mid:(NSString *)mid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=gag",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  同意禁言
 *
 *  @param rid 记录id(透传返回的id)
 *
 *  @return
 */
+(NSDictionary *)getNetGroupAgreeGagP:(NSString *)rid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=agreegag",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:rid forKey:@"rid"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  不同意禁言
 *
 *  @param rid 记录id(透传返回的id)
 *
 *  @return
 */
+(NSDictionary *)getNetGroupDisagreeGagP:(NSString *)rid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=disagreegag",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:rid forKey:@"rid"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  管理员取消用户禁言
 *
 *  @param mid 被取消禁言的用户
 *  @param gid 群组id
 *
 *  @return
 */
+(NSDictionary *)getNetGroupRevokeGagP:(NSString *)mid gid:(NSString *)gid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=revokegag",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  普通群成员举报用户
 *
 *  @param mid    被举报id
 *  @param gid    群组id
 *  @param reason 举报原因
 *
 *  @return
 */
+(NSDictionary *)getNetgroupTipoffP:(NSString *)mid gid:(NSString *)gid reason:(NSString *)reason
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=tipoff",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    [parameterDic safeSetObject:reason forKey:@"reason"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


/**
 *  同意举报
 *
 *  @param rid 举报记录id
 *
 *  @return
 */
+(NSDictionary *)getNetGroupAgreetipoffP:(NSString *)rid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=agreetipoff",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:rid forKey:@"rid"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  禁言到时间,取消禁言
 *
 *  @param gid 群组id
 *
 *  @return
 */
+(NSDictionary *)getNetGroupGagTimeoutP:(NSString *)gid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=gagtimeout",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  获取群成员足迹
 *
 *  @param gid 群组id
 *
 *  @return
 */

+(NSDictionary *)getNetMemberPostionqG:(NSString *)gid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=memberpostion",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc] init];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  进入群组聊天
 *
 *  @param gid 群组id
 *
 *  @return
 */

+(NSDictionary *)getNetGroupEnterG:(NSString *)gid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=enter",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =  [self getBasicParameterDic];
    [parameterDic safeSetObject:gid forKey:@"gid"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  热门群组
 *
 *  @param page 页数
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetHotGroupListPageG:(NSString *)page
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=hot",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =  [self getBasicParameterDic];
    [parameterDic safeSetObject:page forKey:@"page"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
    
    
}
/**
 *  群组发言
 *
 *  @param easeID 环信群组ID
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetGroupMessageP:(NSString *)easeID
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=msgtime",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:easeID forKey:@"ease_id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

#pragma mark - 好友相关数据处理方法
/**
 *  添加好友
 *
 *  @param fuid  好友ID
 *  @param extra 添加信息
 *  @param from  来自哪里
 *  @return POST
 */
+(NSDictionary *)getNetAddFriendfuidP:(NSString *)fuid extra:(NSString *)extra from:(NSString *)from
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=friend&op=apply",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:fuid forKey:@"fuid"];
    [parameterDic safeSetObject:extra forKey:@"extra"];
    [parameterDic safeSetObject:from forKey:@"from"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  删除好友
 *
 *  @param fuid 好友ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetDeleteFriendfuidP:(NSString *)fuid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=friend&op=del",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:fuid forKey:@"fuid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


/**
 *  获取好友列表
 *
 *  @return post
 */
+(NSDictionary *)getNetobtainFriendListG
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=friend&op=list",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  添加用户足迹
 *
 *  @param uid  用户
 *  @param lng  精度
 *  @param lat  纬度
 *  @param addr 地址
 *
 *  @return Post
 */
+(NSDictionary *)getNetAddfootprintP:(NSString *)uid lng:(NSString *)lng lat:(NSString *)lat addr:(NSString *)addr
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=setuserorbit",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc] init];
    [parameterDic safeSetObject:uid forKey:@"uid"];
    [parameterDic safeSetObject:lng forKey:@"lng"];
    [parameterDic safeSetObject:lat forKey:@"lat"];
    [parameterDic safeSetObject:addr forKey:@"addr"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  取用户足迹
 *
 *  @param mid 被查看人的id
 *  @return get
 */
+(NSDictionary *)getNetFootprintG:(NSString *)mid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=getuserorbits",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
     [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  申请添加好友
 *
 *  @param fuid 目标用户id
 *
 *  @return
 */
+(NSDictionary *)getNetFriendApplyP:(NSString *)fuid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=friend&op=apply",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:fuid forKey:@"fuid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  上传背景图片
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetUploadBackground
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=updatebgimg",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


#pragma mark - 聊天室相关数据处理方法
/**
 *  获取要进入的聊天室信息
 *
 *  @param lng  经度
 *  @param lat  纬度
 *  @param addr 地址
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetRequestChatRoomEnterlngG:(NSString *)lng lat:(NSString *)lat addr:(NSString *)addr
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=enter",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:lng forKey:@"lng"];
    [parameterDic safeSetObject:lat forKey:@"lat"];
    [parameterDic safeSetObject:addr forKey:@"addr"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
    
    
}
/**
 *  上传背景图片  用AFNPost上传头像  这里上传UID
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetUploadBackgroundP
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=updatebgimg",[self getBasicUrl]] forKey:K_URL];
    
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


/**
 *  聊天室举报用户
 *
 *  @param roomId 聊天室id
 *  @param mid    被举报人id
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomTipoffP:(NSString *)roomId mid:(NSString *)mid reason:(NSString *)reason
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=tipoff",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:roomId forKey:@"room_id"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [parameterDic safeSetObject:reason forKey:@"reason"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  聊天室同意举报用户
 *
 *  @param tipoffId 举报记录id
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomAgreetipoffP:(NSString *)tipoffId
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=agreetipoff",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:tipoffId forKey:@"rid"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  聊天室禁言时间到取消禁言
 *
 *  @param roomId 聊天室id
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomForbidtimeoutP:(NSString *)roomId
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=forbidtimeout",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:roomId forKey:@"room_id"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  取消聊天室用户禁言
 *
 *  @param roomId 聊天室id
 *  @param mid 被禁言的用户ID
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomUnforbidP:(NSString *)roomId mid:(int)mid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=unforbid",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:roomId forKey:@"room_id"];
     [parameterDic safeSetObject:[NSNumber numberWithInt:mid] forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  聊天室屏蔽用户
 *
 *  @param roomId 聊天室id
 *  @param mid    被屏蔽成员
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomBlockP:(NSString *)roomId mid:(NSString *)mid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=block",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:roomId forKey:@"room_id"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  聊天室取消屏蔽用户
 *
 *  @param roomId 聊天室id
 *  @param mid    被屏蔽成员
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomUnblockP:(NSString *)roomId mid:(NSString *)mid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=unblock",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:roomId forKey:@"room_id"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  聊天室屏蔽用户列表
 *
 *  @param roomId 聊天室id
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomBlocklistG:(NSString *)roomId
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=blocklist",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:roomId forKey:@"room_id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  设置历史聊天室
 *
 *  @param roomId 环信聊天室ID
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomSetHistoryP:(NSString *)roomId
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=sethistory",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:roomId forKey:@"room_id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  得到聊天室信息
 *
 *  @param roomId 环信聊天室ID
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomInfoG:(NSString *)roomId
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=info",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:roomId forKey:@"room_id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  得到角色聊天室信息
 *
 *  @param roomId 环信聊天室ID
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetRoleChatroomInfoG:(NSString *)roomId
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=roleinfo",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:roomId forKey:@"id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
#pragma mark - 消息相关数据处理方法
/**
 *  同意好友申请
 *
 *  @param applyid 申请id
 *
 *  @return
 */
+(NSDictionary *)getNetFriendAgreeP:(NSString *)applyid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=friend&op=agree",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:applyid forKey:@"applyid"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  拒绝好友申请
 *
 *  @param applyid 申请id
 *
 *  @return
 */
+(NSDictionary *)getNetFriendRefuseP:(NSString *)applyid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=friend&op=refuse",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:applyid forKey:@"applyid"];
    
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  同意加群申请
 *
 *  @param applyid 申请消息的ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetAgreedJoinGroupapplyidP:(NSString *)applyid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=agreejoin",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:applyid forKey:@"applyid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  拒绝加群申请（管理员）
 *
 *  @param applyid 申请的消息ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetDisaJoinGroupapplyidP:(NSString *)applyid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=group&op=disagreejoin",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:applyid forKey:@"applyid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}
#pragma mark - 微信网络请求
/**
 *  微信拉取access_token
 *
 *  @param appid     appid
 *  @param secret    appkey
 *  @param code      授权给的code
 *  @param grantType authorization_code
 */
+(NSDictionary *)WXupdateAppId:(NSString *)appid secret:(NSString *)secret Code:(NSString *)code grantType:(NSString *)grantType
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    NSString * str = @"https://api.weixin.qq.com/sns/oauth2/access_token?";
    [postDic safeSetObject:str forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:appid forKey:@"appid"];
    [parameterDic safeSetObject:secret forKey:@"secret"];
    [parameterDic safeSetObject:code forKey:@"code"];
    [parameterDic safeSetObject:grantType forKey:@"grant_type"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}
/**
 *  微信拉取用户信息
 */
+(NSDictionary *)WXupdateAccessToken:(NSString *)access_token openid:(NSString *)openid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    NSString * str = @"https://api.weixin.qq.com/sns/userinfo?";
    [postDic safeSetObject:str forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:access_token forKey:@"access_token"];
    [parameterDic safeSetObject:openid forKey:@"openid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
#pragma mark - 黑名单
/**
 *  黑名单列表请求
 */
+(NSDictionary *)getNetBlackListRequest
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=blacklist",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic; 
}
/**
 *  黑名单加入
 */
+(NSDictionary *)getNetblacklistAddID:(NSString *)mid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=addblack",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  黑名单减人
 *  @param mid 目标ID
 */
+(NSDictionary *)getNetblacklistRemoveID:(NSString *)mid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=delblack",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


#pragma mark - 新闻
/**
 *  获取群组新闻
 *
 *  @param easeID 环信群组ID
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetGetNewsGroupIDG:(NSString *)easeID
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=news&op=group",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:easeID forKey:@"ease_id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
    
}
/**
 *  获取聊天室新闻
 *
 *  @param easeID 环信聊天室ID
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetGetChatRoomNewsGroupIDG:(NSString *)easeID
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=news&op=chatroom",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:easeID forKey:@"ease_id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  崩溃日志
 *
 *  @param ex 崩溃信息
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetExceptionP:(NSString *)ex
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=default&op=exception",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc] init];
    [parameterDic safeSetObject:ex forKey:@"ex"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

#pragma mark - 聊天广场
/**
 *  聊天广场
 *
 *   @return 数据包
 */
+(NSDictionary *)getNetChatroomSquareG
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=index",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc] init];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}
/**
 *  获取聊天室详情
 */
+(NSDictionary *)getNetChatRoomDataGRoomID:(NSString *)roomId
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=detail",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[self getBasicParameterDic];
     [parameterDic safeSetObject:roomId forKey:@"room_id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  获取用户最后一条足迹，有人进入聊天室时用，火星聊天室除外
 */
+(NSDictionary *)getNetUserFootprintEid:(NSString *)eid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=getlastoribit",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc] init];
    [parameterDic safeSetObject:eid forKey:@"eid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}
/**
 *  聊天室搜索框
 *
 *  @param keyWord 关键词
 *  @param page    页号
 *
 */
+(NSDictionary *)getNetChatroomSearchKeyWordG:(NSString *)keyWord Page:(NSString *)page
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=search",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc] init];
    [parameterDic safeSetObject:keyWord forKey:@"keyword"];
    [parameterDic safeSetObject:page forKey:@"page"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;

}

/**
 *  分享新闻
 *
 *  @param url 分享的URL
 */
+(NSDictionary *)getNetShareTheNewsUrlP:(NSString *)url
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=news&op=share",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc] init];
    [parameterDic safeSetObject:url forKey:@"url"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}

/**
 *  根据URL获取分享的新闻
 *
 *  @param url 新闻URL
 */
+(NSDictionary *)getNetAccessShareNewsDataUrlG:(NSString *)url
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=news&op=info",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc] init];
    [parameterDic safeSetObject:url forKey:@"url"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}

/**
 *
 *  提交反馈及bug
 *
 *  @param num     手机号或者QQ号
 *  @param content 内容
 */
+(NSDictionary *)getNetSubmitBugNumPhont:(NSString *)num content:(NSString *)content
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=feedback",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:num forKey:@"num"];
     [parameterDic safeSetObject:content forKey:@"content"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;

}


/**
 *  提交封停申诉
 *
 *  @param num     手机或者QQ号
 *  @param content 内容
 */
+(NSDictionary *)getNetSubmitComplaintNum:(NSString *)num content:(NSString *)content
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=appeal",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:num forKey:@"num"];
    [parameterDic safeSetObject:content forKey:@"content"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}

/**
 *  创建话题聊天室
 *
 *  @param cname 聊天室名称
 *  @param desc  聊天室描述
 *  @param cid   频道ID
 *
 */
+(NSDictionary *)getNetCreateTopicChatCname:(NSString *)cname Desc:(NSString *)desc lng:(NSString *)lng lat:(NSString *)lat addr:(NSString *)addr lname:(NSString *)lname
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=addtopic",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:cname forKey:@"cname"];
    [parameterDic safeSetObject:desc  forKey:@"desc"];
    [parameterDic safeSetObject:lng forKey:@"lng"];
    [parameterDic safeSetObject:lat forKey:@"lat"];
    [parameterDic safeSetObject:addr forKey:@"addr"];
    [parameterDic safeSetObject:lname  forKey:@"lname"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}


/**
 *  对某个话题聊天室感兴趣
 *
 *  @param cid 聊天室ID
 *
 */
+(NSDictionary *)getNetInterestedCid:(NSString *)cid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=intrest",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:cid forKey:@"cid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  过去话题聊天室列表
 *
 *  @param page 页号(从0开始)
 */
+(NSDictionary *)getNetObtainTopicChatRoomList:(NSString *)page
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=topiclist",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:page forKey:@"page"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;

    
    
}

/**
 *  获取话题聊天室详情
 */
+(NSDictionary *)getNetTopicChatRoomInformationEid:(NSString *)eid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=topicinfo",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic = [self getBasicParameterDic];
    [parameterDic safeSetObject:eid forKey:@"cid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 *  话题聊天室创建人直接禁言某个用户：
 *
 *  @param eid 环信聊天室ID
 *  @param mid 被禁言用户ID
 */
+(NSDictionary *)getNetTopicChatRoomSilenceUsersEid:(NSString *)eid Mid:(NSString *)mid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=frobid",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[self getBasicParameterDic];
    [parameterDic safeSetObject:eid forKey:@"eid"];
    [parameterDic safeSetObject:mid forKey:@"mid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}




/**
 *  请求限时聊天室分类类别 并且判断是否可以创建聊天室
 */
+(NSDictionary *)getNetRequestChatRoomLable
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=lables",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[self getBasicParameterDic];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}
/**
 *  每天第一次聊天调用给用户加经验和积分：
 */
+(NSDictionary *)getNetChatroomIntegral
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=chat",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[self getBasicParameterDic];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}
/**
 *  获取聊天室某个成员信息
 */
+(NSDictionary *)getNetChatRoomUserData:(NSString *)euid Erid:(NSString *)erid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=uinfo",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:euid forKey:@"euid"];
     [parameterDic safeSetObject:erid forKey:@"erid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 设置用户推送数据
 
 @param displayMessage 是否显示消息内容
 @param sound 声音是否开启
 @param shake 震动是否开启
 @param notdisturd 免扰是否开启
 */
+(NSDictionary *)getNetSetUserPushGisDisplayMessage:(NSString *)displayMessage isSound:(NSString *)sound isShake:(NSString *)shake isNotDisturd:(NSString *)notdisturd
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=setpush",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[self getBasicParameterDic];
    [parameterDic safeSetObject:displayMessage forKey:@"show_content"];
    [parameterDic safeSetObject:sound forKey:@"has_sound"];
     [parameterDic safeSetObject:shake forKey:@"has_shake"];
     [parameterDic safeSetObject:notdisturd forKey:@"not_disturd"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


/**
 设置角标数量
 
 @param bage 退到后台或者程序杀死 角标数量上传
 */
+(NSDictionary *)getNetSetBage:(NSString *)bage lasttime:(NSString *)lasttime
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=setbage",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[self getBasicParameterDic];
    [parameterDic safeSetObject:bage forKey:@"bage"];
    [parameterDic safeSetObject:lasttime forKey:@"lasttime"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}

/**
 消息同步请求
 */
+(NSDictionary *)getNetSetMessageSynchronousLastTime:(NSString *)time
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=user&op=notices",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[self getBasicParameterDic];
    [parameterDic safeSetObject:time forKey:@"lasttime"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}

/**
 新闻聊天室列表请求
 */
+(NSDictionary *)getNetHaveNewDataList:(int)mid cid:(NSString *)cid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=news",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:[NSNumber numberWithInt:mid] forKey:@"page"];
    [parameterDic safeSetObject:cid forKey:@"cid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}

/**
 对新闻感兴趣
 */
+(NSDictionary *)getNetInterestedNewId:(int)nid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=news&op=intrest",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[self getBasicParameterDic];
    [parameterDic safeSetObject:[NSNumber numberWithInt:nid] forKey:@"nid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
}
/**
 请求新闻详情
 */
+(NSDictionary *)getNetDataNewId:(int)nid
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=news&op=getinfo",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:[NSNumber numberWithInt:nid] forKey:@"nid"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;

    
}
/**
 评论新闻
 */
+(NSDictionary *)getNetCommentsNewId:(int)nid content:(NSString *)content
{
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=news&op=comment",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[self getBasicParameterDic];
    [parameterDic safeSetObject:[NSNumber numberWithInt:nid] forKey:@"nid"];
     [parameterDic safeSetObject:content forKey:@"content"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
    
}
/**
 获取评论列表
 
 @param newid 新闻ID
 @param page page页号
 */
+(NSDictionary *)getNetCommentsListNewId:(NSString *)newid Page:(NSString *)page
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=news&op=commentlist",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:newid forKey:@"nid"];
    [parameterDic safeSetObject:page forKey:@"page"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
    
    
    
}

/**
 获取角色扮演聊天室详情
 @param roleid 新闻ID
 */
+(NSDictionary *)getNetRolePlayRoomData:(NSString *)roleId
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=roleinfo",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:roleId forKey:@"id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}



/**
 获取角色列表

 @param roomID 我们自己的房间ID
 @return <#return value description#>
 */
+(NSDictionary *)getNetRolePlayRoleList:(NSString *)roomID
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=rolelist",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[[NSMutableDictionary alloc]init];
    [parameterDic safeSetObject:roomID forKey:@"id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
}


/**
 获取角色编号
 */
+(NSDictionary *)getNetRoleplayRoleNumberRoomid:(NSString *)roomID roleID:(NSString *)roleid
{
    
    NSMutableDictionary * postDic = [[NSMutableDictionary alloc]init];
    [postDic safeSetObject:[NSString stringWithFormat:@"%@?ac=chatroom&op=setrole",[self getBasicUrl]] forKey:K_URL];
    NSMutableDictionary * parameterDic =[self getBasicParameterDic];
    [parameterDic safeSetObject:roomID forKey:@"room_id"];
     [parameterDic safeSetObject:roleid forKey:@"role_id"];
    [postDic setObject:parameterDic forKey:K_URL_PARAMETER];
    return postDic;
    
    
    
}
@end
