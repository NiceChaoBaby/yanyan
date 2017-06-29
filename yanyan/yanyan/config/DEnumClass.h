//
//  DEnumClass.h
//  storm
//
//  Created by dong on 15/7/14.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//默认0开始
typedef NS_ENUM(NSInteger, SearchType) {
    //以下是枚举成员
    SearchTypeTopic = 0,//话题
    SearchTypeBrand = 1,//品牌
    SearchTypePlace = 2,//地点
    
};

//点击编辑模式
//默认0开始
typedef NS_ENUM(NSInteger, UserDataType) {
    //以下是枚举成员
    UserDataTypeName = 0,//用户名字
    UserDataTypeProfile = 1,//用户个人简介
    UserDataTypeFrom = 2,//用户故乡
     UserDataTypeInterest = 3,//用户兴趣
    UserDataTypeBirthDay = 4,//用户生日
    UserDataTypeEmotion = 5//用户情感
};

//群组管理

//默认0开始
typedef NS_ENUM(NSInteger, GroupManageType) {
    //以下是枚举成员
    GroupManageName = 0,//群组名字
    GroupManageSite = 1,//群组地点
    GroupManageMark = 2,//群组标签
    GroupManageInfo = 3,//群组介绍
};


#pragma mark - 登陆数据请求枚举
typedef NS_ENUM(NSInteger, LoginRequestType) {
    //以下是枚举成员
    Loginrequest = 0,//登陆请求
    LoginForgotPassword = 1,//忘记密码请求
    LoginWX = 2,//微信第三方登陆请求
    LoginQQ = 3,//QQ第三方登陆请求
    LoginWB = 4 //微博第三方登陆请求
};

//改变头像 背景的枚举
typedef NS_ENUM (NSInteger,selectPhotoType){

    changeUserPhoto = 0,
    changeBackgroundImage = 1




};

//聊天类型
typedef NS_ENUM (NSInteger,ChatType){
    
    ChatTypeC = 0,//聊天室
    ChatTypeG = 1//群组聊天
    
    
    
    
};
//注册类型
typedef NS_ENUM (NSInteger,RegistereType){
    
    Code = 0,//请求验证码
    Registere = 1,//注册
    ModifyPhone = 2,//修改手机号
    ResetPassword = 3,//重置密码
    BudingPhone = 4//如果没有手机号就绑定手机号和设置密码
    
    
    
};
//群组操作 举报 屏蔽  退出群组 解散
typedef NS_ENUM (NSInteger,GroupActionType){
    
   ToReport = 0,//举报
   shielding = 1,//屏蔽
   QuitGroup = 2,//退出群组
   DissolutionGroup = 3//解散群组
};

//群组详情  地点  介绍
typedef NS_ENUM (NSInteger,GroupData){
    
   groupSites = 0,//群组地点
   groupintroduce = 1,//群组介绍
   
};


typedef NS_ENUM (NSInteger,WXRequestType){
    
    WXToken = 0,//申请Token
    WXUserInfor = 1,//用户信息
    WBUserInfor = 2,//微博获取用户信息
    ThreeLanding = 3,//自己的第三方登陆接口
    
};

typedef NS_ENUM (NSInteger,ThreeLoding){
    
    WX = 0,//微信
    QQ = 1,//QQ
    WB = 2,//微博
};

typedef NS_ENUM (NSInteger,SetStateType){
    
    SetStateNoHarass = 0,//勿扰时段
    SetStateGroupMessage = 1,//群消息提醒
    SetStateUserMessage = 2,//私聊信息提醒
    SetStateVoice = 3,//声音提醒
    SetStateVibration = 4 //震动
};
typedef NS_ENUM (NSInteger,MessageType)
{
    MessageGroup = 0,//群组消息
    MessageUser  = 1,//个人消息
    MessageNotice = 2//通知消息
    
    
};
typedef NS_ENUM (NSInteger,LocationType)
{
   LocationFJ = 0,//附近
   LocationXQ = 1,//小区
   LocationSC = 2,//商场
   LocationXX = 3 //学校
};



typedef NS_ENUM (NSInteger,SharingType)
{
    SharingQQ = 0,//qq
    SharingQQFriend = 1,//qq朋友圈
    SharingWX = 2,//微信
    SharingWXFriend = 3,//微信朋友圈
    SharingWB = 4, //微博
    SharingQQZone = 5 //QQ空间
};

typedef NS_ENUM (NSInteger,touchNewsType)
{
   JustClick = 0,//直接点击
   CellClick     //Cell点击
};


typedef NS_ENUM (NSInteger,TopicChatType)
{
    Interested = 0,//感兴趣的
    NOtInterested,//不感兴趣的
    ChatIn,//聊天中
    EndChat//结束
    
};

typedef NS_ENUM (NSInteger,ChatSquareType)
{
    WhatNot = 0,//什么也不是
    ChatSquareInterested,//已感兴趣的
    ChatSquareChatIn,//聊天中
    ChatSquareNotInterested, //还没有感兴趣
    ChatMyCreate,//我创建
    ChatAddRoom//已加入
    
};

typedef NS_ENUM (NSInteger,UserOperationType)
{
   addGroup = 0,//加群
   createGroup, //建群
   directMessages, //私聊
    addFriend,    //加好友
    BeInvitedAddGroup //被邀请入群
    
};
//有人加入或者离开聊天室
typedef NS_ENUM (NSInteger,PeopleChat)
{
    addChatRoom = 0,//加入聊天室
    leaveChatRoom,//离开聊天室
    
};
//有人加入或者离开聊天室
typedef NS_ENUM (NSInteger,ChatInfoType)
{
     ordinary = 0, //普通
    administrator,//管理员
    founder,//创建人
     manager, //群主
    
    
};

//有人加入或者离开聊天室
typedef NS_ENUM (NSInteger,MessageTypeG)
{
    systemMessage = 0, //系统消息
    applyMessage//申请消息

    
    
};

//有人加入或者离开聊天室
typedef NS_ENUM (NSInteger,changeFriendData)
{
    signature = 0, //签名
    Avatar,//头像
    nickName//名称
    
    
};


//有人加入或者离开聊天室
typedef NS_ENUM (NSInteger,NewType)
{
    GroupNew = 0, //群组新闻
    GroupChatNew,//群组聊天里的新闻
    ChatNew,//聊天新闻
    HomeNew//主页新闻
    
};
//有人加入或者离开聊天室
typedef NS_ENUM (NSInteger,LodingData)
{
    PullonLoading = 0, //上啦加载
    DropDownRefresh //下拉刷新
    
};
//登录的样式
typedef NS_ENUM (NSInteger,LodingType)
{
    lodingIng = 0,//登录中
    lodingSuccessful, //登录成功
    lodingFailure //登录失败
    
};

//聊天室类型
typedef NS_ENUM (NSInteger,ChatRoomType)
{
    ChatRoomTypeNews = 1,//新闻聊天室
    ChatRoomTypeTopic,//话题聊天室
    ChatRoomTypeRolePlay//角色扮演聊天室
    
};



