//
//  URLPath.h
//  storm
//
//  Created by dong on 15/7/14.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define K_URL_TOKEN                 @"token"
#define K_URL                       @"url"
#define K_URL_PARAMETER             @"parameter"




@interface URLPath : NSObject


+ (NSString*)getBasicUrl;
+(NSMutableDictionary*)getBasicParameterDic;
//设备注册
+(NSDictionary*)registerDevidence:(NSString*)pushToken;







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
+(NSDictionary *)getNetUpDataP:(NSString *)phoneNumber code:(NSString *)vcode;
/**
 *  重置密码前检查
 *
 *  @param phoneNumber 手机号
 *  @param vcode       验证码
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetResetP:(NSString *)phoneNumber code:(NSString *)vcode;

/**
 *  注册
 *
 *  @param phoneNumber 手机号
 *  @param pwd         密码
 *  @param birthday    生日
 *  @param gender      性别
 *  @param nickname    昵称
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRegisteDataP:(NSString *)phoneNumber pwd:(NSString *)pwd birthday:(NSString *)birthday gender:(NSString *)gender nickname:(NSString *)nickname code:(NSString *)code lng:(NSString *)lng lat:(NSString *)lat dfa:(NSString *)dfa;

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
+(NSDictionary *)getNetLoginDataP:(NSString *)phoneNumber pwd:(NSString *)pwd lng:(NSString *)lng  lat:(NSString *)lat addr:(NSString *)addr;
/**
 *  获取验证码
 *
 *  @param phoneNumber 手机号
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetObtainCodePhoneNmuber:(NSString *)phoneNumber;
/**
 *  定位进入聊天室
 *
 *  @param lng         经度
 *  @param lat         纬度
 *  @param addr        地址
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetLocationChatRoomDataP:(NSString *)lng  lat:(NSString *)lat addr:(NSString *)addr;
/**
 *  第三方登陆
 *
 *  @param account   第三方平台账号
 *  @param thirdplat 平台
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetThirdPartyaccountP:(NSString *)account thirdplat:(NSString *)thirdplat;
/**
 第三方注册
 
 @param account 第三方平台账号
 @param thirdplat 平台

 @param nickname 昵称
 @param gender 性别
 @param birthday 生日
 @param lng 经度
 @param lat 纬度
 @param addr 地址
 @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetThirdPartyRegisterAccount:(NSString *)account Thirdplat:(NSString *)thirdplat Nickname:(NSString*)nickname Gender:(NSString *)gender Birthday:(NSString *)birthday lng:(NSString *)lng lat:(NSString *)lat addr:(NSString *)addr;
/**
 *  绑定第三方账号
 *
 *  @param account   第三方平台账号
 *  @param thirdplat 平台
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetBindingThirdPartyaccountP:(NSString *)account thirdplat:(NSString *)thirdplat;

/**
 *  取消第三方账号绑定
 *
 *  @param account   第三方平台账号
 *  @param thirdplat 平台
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetCancelBindingThirdPartyaccountP:(NSString *)account thirdplat:(NSString *)thirdplat;



#pragma mark -  个人资料数据修改方法
/**
 *  重置密码
 *
 *  @param phone    手机号
 *  @param password 新密码
 *  @param code     验证码
 *  @return 数据包
 */
+(NSDictionary *)getNetResetPasswordPhone:(NSString *)phone NewPassword:(NSString *)password code:(NSString *)vcode;
/**
 *  修改手机号
 *
 *  @param phone 新手机号
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairPhoneP:(NSString *)phone code:(NSString *)vcode;
/**
 *  绑定手机号
 *
 *  @param phone  手机号
 *  @param passwd 密码
 *  @param code   验证码
 *
 *  @return 数据
 */
+(NSDictionary *)getNetBindingPhoneNumber:(NSString *)phone password:(NSString *)passwd code:(NSString *)code;

/**
 *  修改昵称
 *
 *  @param nickname 用户新昵称
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairNamenicknameP:(NSString *)nickname;

/**
 *  修改生日
 *
 *  @param birthday 新生日
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairBirthdayP:(NSString *)birthday;

/**
 *  修改密码
 *
 *  @param oldpwd 旧密码
 *  @param passwd 新密码
 *
 *  @return  post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairpasswdoldpwdP:(NSString *)oldpwd passwd:(NSString *)passwd;

/**
 *  修改头像
 *
 *  @return 用AFNPost上传头像  这里上传UID
 */
+(NSDictionary *)getNetRepairUserPhotoavatarP;

/**
 *  修改签名
 *
 *  @param signature 新的签名
 *
 *  @return post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairUsersignatureP:(NSString *)signature;

/**
 *  用户故乡修改
 *
 *  @param home 故乡
 *
 *  @return post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairuserHomeP:(NSString *)home;

/**
 *  用户兴趣修改
 *
 *  @param intrest 兴趣
 *
 *  @return post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairuserIntrestP:(NSString *)intrest;

/**
 *  用户感情修改
 *
 *  @param emotion 用户感情
 *
 *  @return post数据字典  内含  url  和参数
 */
+(NSDictionary *)getNetRepairuserEmotionP:(NSString *)emotion;
/**
 *  获取用户信息
 *
 *  @param uid 获取的UID
 *
 *  @return post数据字典  内含  url  和参数
 */

+(NSDictionary *)getNetUserDtatG:(NSString *)uid;

/**
 *  获取用户收到的申请或邀请
 *
 *  @return get
 */


+(NSDictionary *)getNetObtainInvitationG;

/**
 *  获取加群邀请详情
 *
 *  @param mid 邀请人
 *  @param gid 群组ID
 *
 *  @return Get数据字典
 */
+(NSDictionary *)getNetAddgroupMessageG:(NSString *)mid gid:(NSString *)gid;




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
+(NSDictionary *)getNetCreateGroupnameP:(NSString *)name desc:(NSString *)desc label:(NSString *)label addr:(NSString *)addr addrid:(NSString *)addrid lng:(NSString *)lng lat:(NSString *)lat;



/**
 *  修改群名
 *
 *  @param gid  群组id
 *  @param name 群名称
 *
 *  @return POST
 */
+(NSDictionary *)getNetModifyGroupNamegidP:(NSString *)gid name:(NSString *)name;


/**
 *  修改群地址
 *
 *  @param gid    群ID
 *  @param addr   群地址
 *  @param addrid 群地址ID
 *
 *  @return Post
 */

+(NSDictionary *)getNetModifyGroupAddrgidP:(NSString *)gid addr:(NSString *)addr addrid:(NSString *)addrid;


/**
 *  修改群描述
 *
 *  @param gid  群ID
 *  @param desc 群描述
 *
 *  @return POST
 */

+(NSDictionary *)getNetModifyGroupDescgidP:(NSString *)gid desc:(NSString *)desc;


/**
 *  修改群标签
 *
 *  @param gid   群ID
 *  @param label 群标签
 *
 *  @return POST
 */

+(NSDictionary *)getNetModifyGroupLabelgidP:(NSString *)gid label:(NSString *)label;

/**
 *  修改群头像
 *
 *  @param gid    群ID
 *
 *  @return POST
 */

+(NSDictionary *)getNetModifyGroupPhotogidP:(NSString *)gid;

/**
 *  扩充群人数
 *
 *  @param gid    群ID
 *  @param maxnum 人数上限
 *
 *  @return POST
 */


+(NSDictionary *)getNetExpandGroupPeoplegidP:(NSString *)gid maxnum:(NSString *)maxnum;

/**
 *  邀请加入群
 *
 *  @param gid 群ID
 *  @param mid 用户1 用户2  用户3 。。。
 *
 *  @return POST
 */

+(NSDictionary *)getNetInvitedJoinGroupgidP:(NSString *)gid mid:(NSString *)mid;


/**
 *  接受加群邀请
 *
 *  @param applyid 邀请信息的ID
 *
 *  @return POST
 */

+(NSDictionary *)getNetAcceptJoinGroupapplyidP:(NSString *)applyid;

/**
 *  拒绝加群邀请
 *
 *  @param applyid 邀请信息的ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetNoJoinGroupapplyidP:(NSString *)applyid;

/**
 *  踢出群
 *
 *  @param gid 群ID
 *  @param mid 成员ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetGetoutGroupgidP:(NSString *)gid mid:(NSString *)mid;





/**
 *  取消管理员
 */
+(NSDictionary *)getNetRevokAdministratorGidP:(NSString *)gid mid:(NSString *)mid;





/**
 *  关键字搜索群
 *
 *  @param keyword 关键字
 *
 *  @return POST
 */

+(NSDictionary *)getNetSearchGroupkeywordG:(NSString *)keyword page:(NSString *)page;
/**
 *  获取附近的群
 *
 *  @param lng 经度
 *  @param lat 纬度
 *
 *  @return POST
 */
+(NSDictionary *)getNetNearGrouplngG:(NSString *)lng lat:(NSString *)lat Page:(NSString *)page;

/**
 *  加载同一地址更多群组
 *
 *  @param addrID 地址ID
 *  @param page   页数
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetSameAddressG:(NSString *)addrID page:(NSString *)page;
/**
 *  获取群信息
 *
 *  @param gid 群ID
 *
 *  @return POST
 */

+(NSDictionary *)getNetGroupInformationgidG:(NSString *)gid;

/**
 *  申请加入群
 *
 *  @param gid 群ID
 *
 *  @return POST
 */

+(NSDictionary *)getNetApplyGroupgidP:(NSString *)gid;



/**
 *  退出群组
 *
 *  @param gid 群组ID
 *
 *  @return POST
 */

+(NSDictionary *)getNetExitGroupgidP:(NSString *)gid;

/**
 *  解散群组
 *
 *  @param gid 群组ID
 *
 *  @return POST
 */
+(NSDictionary *)getNetDissolutionGroupgidP:(NSString *)gid;
/**
 *  举报群组或用户
 */
+(NSDictionary *)getNetReportTypeP:(NSString *)type whoId:(NSString *)whoid Reason:(NSString *)reason;
/**
 *  获取最新的群组
 *
 *  @return POST
 */
+(NSDictionary *)getNetLatestGroupListG:(NSString *)minID;



/**
 *  屏蔽群组成员
 *
 *  @param gid 群组id
 *  @param mid 屏蔽用户
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetGroupBlockP:(NSString *)gid mid:(NSString *)mid;

/**
 *  取消屏蔽群组成员
 *
 *  @param gid 群组id
 *  @param mid 屏蔽用户
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetGroupUnblockP:(NSString *)gid mid:(NSString *)mid;
/**
 *  获取用户屏蔽群组成员列表
 *
 *  @param gid 群组id
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetGroupBlockListG:(NSString *)gid;

/**
 *  管理员发起禁言
 *
 *  @return
 */
+(NSDictionary *)getNetgroupGagP:(NSString *)gid mid:(NSString *)mid;
/**
 *  同意禁言
 *
 *  @param rid 记录id(透传返回的id)
 *
 *  @return
 */
+(NSDictionary *)getNetGroupAgreeGagP:(NSString *)rid;
/**
 *  不同意禁言
 *
 *  @param rid 记录id(透传返回的id)
 *
 *  @return
 */
+(NSDictionary *)getNetGroupDisagreeGagP:(NSString *)rid;
/**
 *  管理员取消用户禁言
 *
 *  @param mid 被取消禁言的用户
 *  @param gid 群组id
 *
 *  @return
 */
+(NSDictionary *)getNetGroupRevokeGagP:(NSString *)mid gid:(NSString *)gid;
/**
 *  普通群成员举报用户
 *
 *  @param mid    被举报id
 *  @param gid    群组id
 *  @param reason 举报原因
 *
 *  @return
 */
+(NSDictionary *)getNetgroupTipoffP:(NSString *)mid gid:(NSString *)gid reason:(NSString *)reason;
/**
 *  同意举报
 *
 *  @param rid 举报记录id
 *
 *  @return
 */
+(NSDictionary *)getNetGroupAgreetipoffP:(NSString *)rid;
/**
 *  禁言到时间,取消禁言
 *
 *  @param gid 群组id
 *
 *  @return
 */
+(NSDictionary *)getNetGroupGagTimeoutP:(NSString *)gid;

/**
 *  获取群成员足迹
 *
 *  @param gid 群组id
 *
 *  @return
 */
+(NSDictionary *)getNetMemberPostionqG:(NSString *)gid;
/**
 *  进入群组聊天
 *
 *  @param gid 群组id
 *
 *  @return
 */

+(NSDictionary *)getNetGroupEnterG:(NSString *)gid;

/**
 *  热门群组
 *
 *  @param page 页数
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetHotGroupListPageG:(NSString *)page;
/**
 *  群组发言
 *
 *  @param easeID 环信群组ID
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetGroupMessageP:(NSString *)easeID;

#pragma mark - 好友相关数据处理方法


/**
 *  添加好友
 *
 *  @param fuid 好友ID
 *  @param extra 添加信息
 *  @return POST
 */
+(NSDictionary *)getNetAddFriendfuidP:(NSString *)fuid extra:(NSString *)extra from:(NSString *)from;


/**
 *  删除好友
 *
 *  @param fuid 好友ID
 *
 *  @return POST
 */

+(NSDictionary *)getNetDeleteFriendfuidP:(NSString *)fuid;



/**
 *  获取好友列表
 *
 *  @return post
 */

+(NSDictionary *)getNetobtainFriendListG;

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
+(NSDictionary *)getNetAddfootprintP:(NSString *)uid lng:(NSString *)lng lat:(NSString *)lat addr:(NSString *)addr;

/**
 *  取用户足迹
 *
 *  @param mid 被查看人的id
 *  @return get
 */
+(NSDictionary *)getNetFootprintG:(NSString *)mid;

/**
 *  申请添加好友
 *
 *  @param fuid 目标用户id
 *
 *  @return
 */
+(NSDictionary *)getNetFriendApplyP:(NSString *)fuid;
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

+(NSDictionary *)getNetRequestChatRoomEnterlngG:(NSString *)lng lat:(NSString *)lat addr:(NSString *)addr;
/**
 *  上传背景图片
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetUploadBackgroundP;
/**
 *  聊天室举报用户
 *
 *  @param roomId 聊天室id
 *  @param mid    被举报人id
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomTipoffP:(NSString *)roomId mid:(NSString *)mid reason:(NSString *)reason;

/**
 *  聊天室同意举报用户
 *
 *  @param tipoffId 举报记录id
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomAgreetipoffP:(NSString *)tipoffId;

/**
 *  聊天室禁言时间到取消禁言
 *
 *  @param roomId 聊天室id
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomForbidtimeoutP:(NSString *)roomId;
/**
 *  取消聊天室用户禁言
 *
 *  @param roomId 聊天室id
 *  @param mid 被禁言的用户ID
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomUnforbidP:(NSString *)roomId mid:(int)mid;
/**
 *  聊天室屏蔽用户
 *
 *  @param roomId 聊天室id
 *  @param mid    被屏蔽成员
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomBlockP:(NSString *)roomId mid:(NSString *)mid;
/**
 *  聊天室取消屏蔽用户
 *
 *  @param roomId 聊天室id
 *  @param mid    被屏蔽成员
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomUnblockP:(NSString *)roomId mid:(NSString *)mid;
/**
 *  设置历史聊天室
 *
 *  @param roomId 环信聊天室ID
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomSetHistoryP:(NSString *)roomId;
/**
 *  得到聊天室信息
 *
 *  @param roomId 环信聊天室ID
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetChatroomInfoG:(NSString *)roomId;
/**
 *  得到角色聊天室信息
 *
 *  @param roomId 环信聊天室ID
 *
 *  @return 数据字典
 */
+(NSDictionary *)getNetRoleChatroomInfoG:(NSString *)roomId;

#pragma mark - 消息相关数据处理方法
/**
 *  同意好友申请
 *
 *  @param applyid 申请id
 *
 *  @return
 */
+(NSDictionary *)getNetFriendAgreeP:(NSString *)applyid;
/**
 *  拒绝好友申请
 *
 *  @param applyid 申请id
 *
 *  @return
 */
+(NSDictionary *)getNetFriendRefuseP:(NSString *)applyid;
/**
 *  同意加群申请
 *
 *  @param applyid 申请消息的ID
 *
 *  @return POST
 */

+(NSDictionary *)getNetAgreedJoinGroupapplyidP:(NSString *)applyid;

/**
 *  拒绝加群申请（管理员）
 *
 *  @param applyid 申请的消息ID
 *
 *  @return POST
 */

+(NSDictionary *)getNetDisaJoinGroupapplyidP:(NSString *)applyid;
#pragma mark - 微信拉取access_token
/**
 *  微信拉取access_token
 *
 *  @param appid     appid
 *  @param secret    appkey
 *  @param code      授权给的code
 *  @param grantType authorization_code
 */
+(NSDictionary *)WXupdateAppId:(NSString *)appid secret:(NSString *)secret Code:(NSString *)code grantType:(NSString *)grantType;
/**
 *  微信拉取用户信息
 */
+(NSDictionary *)WXupdateAccessToken:(NSString *)access_token openid:(NSString *)openid;

#pragma mark - 黑名单
/**
 *  黑名单列表请求
 */
+(NSDictionary *)getNetBlackListRequest;
/**
 *  黑名单加入
 *  @param mid 目标ID
 */
+(NSDictionary *)getNetblacklistAddID:(NSString *)mid;
/**
 *  黑名单减人
 *  @param mid 目标ID
 */
+(NSDictionary *)getNetblacklistRemoveID:(NSString *)mid;

#pragma mark - 新闻
/**
 *  获取群组新闻
 *
 *  @param easeID 环信群组ID
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetGetNewsGroupIDG:(NSString *)easeID;
/**
 *  获取聊天室新闻
 *
 *  @param easeID 环信聊天室ID
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetGetChatRoomNewsGroupIDG:(NSString *)easeID;

/**
 *  崩溃日志
 *
 *  @param ex 崩溃信息
 *
 *  @return 数据包
 */
+(NSDictionary *)getNetExceptionP:(NSString *)ex;
#pragma mark - 聊天广场
/**
 *  聊天广场
 *
 *   @return 数据包
 */
+(NSDictionary *)getNetChatroomSquareG;

/**
 *  获取聊天室详情
 */
+(NSDictionary *)getNetChatRoomDataGRoomID:(NSString *)id;


/**
 *  获取用户最后一条足迹，有人进入聊天室时用，火星聊天室除外
 */
+(NSDictionary *)getNetUserFootprintEid:(NSString *)eid;
/**
 *  聊天室搜索框
 *
 *  @param keyWord 关键词
 *  @param page    页号
 *
 */
+(NSDictionary *)getNetChatroomSearchKeyWordG:(NSString *)keyWord Page:(NSString *)page;
/**
 *  分享新闻
 *
 *  @param url 分享的URL
 */
+(NSDictionary *)getNetShareTheNewsUrlP:(NSString *)url;

/**
 *  根据URL获取分享的新闻
 *
 *  @param url 新闻URL
 */
+(NSDictionary *)getNetAccessShareNewsDataUrlG:(NSString *)url;

/**
 *  提交反馈及bug
 */
+(NSDictionary *)getNetSubmitBugNumPhont:(NSString *)num content:(NSString *)content;
/**
 *  提交封停申诉
 */
+(NSDictionary *)getNetSubmitComplaintNum:(NSString *)num content:(NSString *)content;

#pragma mark - 话题聊天室
/**
 *  创建话题聊天室
 *
 *  @param cname 聊天室名称
 *  @param desc  聊天室描述
 *  @param lng   经度
 *  @param lat   纬度
 *  @param addr  地址名
 *  @param cid   频道ID
 *
 */
+(NSDictionary *)getNetCreateTopicChatCname:(NSString *)cname Desc:(NSString *)desc lng:(NSString *)lng lat:(NSString *)lat addr:(NSString *)addr lname:(NSString *)lname;
/**
 *  对某个话题聊天室感兴趣
 *
 *  @param cid 聊天室ID
 *
 */
+(NSDictionary *)getNetInterestedCid:(NSString *)cid;
/**
 *  过去话题聊天室列表
 *
 *  @param page 页号(从0开始)
 */
+(NSDictionary *)getNetObtainTopicChatRoomList:(NSString *)page;

/**
 *  获取话题聊天室详情
 */
+(NSDictionary *)getNetTopicChatRoomInformationEid:(NSString *)eid;

/**
 *  话题聊天室创建人直接禁言某个用户：
 *
 *  @param eid 环信聊天室ID
 *  @param mid 被禁言用户ID
 */
+(NSDictionary *)getNetTopicChatRoomSilenceUsersEid:(NSString *)eid Mid:(NSString *)mid;




/**
 *  请求限时聊天室分类类别 并且判断是否可以创建聊天室
 */
+(NSDictionary *)getNetRequestChatRoomLable;

/**
 *  每天第一次聊天调用给用户加经验和积分：
 */
+(NSDictionary *)getNetChatroomIntegral;


/**
 *  获取聊天室某个成员信息
 */
+(NSDictionary *)getNetChatRoomUserData:(NSString *)euid Erid:(NSString *)erid;

/**
 新闻聊天室列表请求
 */
+(NSDictionary *)getNetHaveNewDataList:(int)mid cid:(NSString *)cid;


/**
 对新闻感兴趣
 */
+(NSDictionary *)getNetInterestedNewId:(int)nid;

/**
 请求新闻详情
 */
+(NSDictionary *)getNetDataNewId:(int)nid;

/**
 评论新闻
 */
+(NSDictionary *)getNetCommentsNewId:(int)nid content:(NSString *)content;
/**
 设置用户推送数据

 @param displayMessage 是否显示消息内容
 @param sound 声音是否开启
 @param shake 震动是否开启
 @param notdisturd 免扰是否开启
 */
+(NSDictionary *)getNetSetUserPushGisDisplayMessage:(NSString *)displayMessage isSound:(NSString *)sound isShake:(NSString *)shake isNotDisturd:(NSString *)notdisturd;

/**
 设置角标数量

 @param bage 退到后台或者程序杀死 角标数量上传
 */
+(NSDictionary *)getNetSetBage:(NSString *)bage lasttime:(NSString *)lasttime;

/**
 消息同步请求
 */
+(NSDictionary *)getNetSetMessageSynchronousLastTime:(NSString *)time;



/**
 获取评论列表

 @param newid 新闻ID
 @param page page页号
 */
+(NSDictionary *)getNetCommentsListNewId:(NSString *)newid Page:(NSString *)page;

/**
 获取角色扮演聊天室详情
 @param roleid 新闻ID
 */
+(NSDictionary *)getNetRolePlayRoomData:(NSString *)roleId;
/**
 获取角色列表
 
 @param roomID 我们自己的房间ID
 @return <#return value description#>
 */
+(NSDictionary *)getNetRolePlayRoleList:(NSString *)roomID;


/**
 获取角色编号
 */
+(NSDictionary *)getNetRoleplayRoleNumberRoomid:(NSString *)roomID roleID:(NSString *)roleid;

@end
