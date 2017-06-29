//
//  KeyWordsString.h
//  storm
//
//  Created by dong on 15/7/23.
//  Copyright (c) 2015年 dong. All rights reserved.
///

#ifndef SX_LFQX_KeyWordsString_h
#define SX_LFQX_KeyWordsString_h


#pragma mark 预定义宏

#define K_header       @"header"          //类型
#define K_mid          @"mid"             //加载页数
#define K_islast       @"islast"          //加载总页数(是否是最后一页)
#define K_name         @"name"               //运动名称
#define K_picName      @"pic"                 //图片名
#define K_desc         @"desc"                //描述
#define K_colorName    @"color"              //颜色名
#define K_id           @"id"               //id
#define K_project      @"project"           //project
#define K_login        @"login"             //login
#define K_LOGINTYPE    @"k_logintype"       //登录样式
#define K_REGISTEREDTYPE @"registeredtype"  //注册样式
#define K_weixin       @"weixin"            //微信
#define K_sina         @"sina"              //新浪
#define K_renren       @"renren"            //人人
//2016.3.22 高超
#define k_number       @"number"           //第几个群组位置分类
#define K_data         @"data"            //数据
#define K_date         @"Date"            //时间
#define k_room_id      @"room_id"         //进入的聊天室ID
#define k_userLoginNumber @"userLoginNumber"  //用户登录后台服务器账号
#define k_hxName       @"hx_name"         //环信登陆账号
#define k_hxPasswd     @"hx_passwd"       //环信登陆密码
#define k_msg          @"msg"             //返回的中文信息
#define K_rs           @"rs"              //错误信息
#define K_REMOVETIME   @"removetime"      //删除群组聊天时间定时器
#define k_groups       @"groups"           //个人群组信息
#define k_friends      @"friends"          //个人好友信息
#define k_changePhoto  @"changePhoto"      //改变头像通知标示
#define k_popView      @"popView"          //返回视图
#define K_TopEndTime      @"topEndTime"          //话题聊天室结束时间
#define K_NewsEndTime      @"NewsEndTime"          //新闻聊天室结束时间
#define K_RoleEndTime      @"RoleEndTime"          //Role聊天室结束时间
#define k_reqFriendList @"reqfriendlist"  //记录好友列表请求时间
#define K_REFRESHCOMMENTSLIST @"refreshcommentslist"//刷新评论列表
#define k_reqGroupList @"reqGrouplist"    // 记录群组列表请求时间
#define K_RemoveroomInformation  @"removeroomInformation"  //移除新闻聊天 右上角消息个数
#define k_topicCreateDat     @"topiccreatedat" //记录最后一次创建话题聊天室的信息
//消息
#define k_model        @"model"           //消息页面回传的详细信息model
#define k_positioning @"positioning"     //是否开启定位储存
#define k_message      @"message"       //提示信息说明
#define k_messageList  @"messageList"      //消息列表
#define k_messageListApply @"messageListApply"//申请消息列表
#define k_msgtype      @"msgtype"          //申请消息的类型
#define k_applyID      @"k_applyID"       //消息ID
#define k_atype        @"atyoe"           //标识是否处理 0 1 2 (3是没有同不同意 直接是个通知）
#define k_time         @"Newtime"         //现在的时间
#define k_messageNumber @"messageNumber"   //消息总数
#define K_NONEWMESSAGE @"k_nonewmessage"   //没有新的消息
#define K_SIGNATURE_INFO @"signature"   //签名
#define K_MessageType   @""
#define K_cmdType @"cmdType"  //透传类型
#define K_cmdMessageNotice @"cmdMessage_notice"  //透传消息通知
#define K_endAloneChat @"end_alone_chat"  //结束单聊
#define K_REMessagetwo @"k_remessagetwo"  //刷新消息数据第二页面
#define K_REMessagethree @"k_remessagethree"//刷新消息数据第三页面
#define K_lastMessageTime @"k_lastMessageTime" //最后一条消息时间
#define KTAKEROOTVIEW    @"ktakerootview" //回到根视图 话题聊天室创建页面
//
#define k_ChatSquareKeyArr @"chatSquareKeyArr" //chatSquare类的兴趣组的Key数组

#define k_ChatSquareAllDataDic @"ChatSquareAllDataDic"//chatSquare类的兴趣组的Key数组对应的数据
//限时聊天广场
#define K_PEOPLEPHOTORELOATDATA @"k_peoplephotoreloatdata"//刷星输入框上方CollectionView
#define K_CHANGEFREAMALL @"k_changefream"   //改变聊天框上面人物头像的fream
#define K_CHANGEFREAMNOALL @"k_changefreamnoall"   //改变聊天框上面人物头像的fream
#define k_PUSHCHATROOM @"PUSHCHATROOM"//取消限时聊天室模态视图
#define K_NewMessage @"k_newmessage"  //有新消息
#define K_NONEWMessage @"k_nonewmessage" //没有新消息
#define K_CmdMessage @"cmdMessage" //透传新消息
#define K_TOUCHPHOTOVIEW @"k_touchphotoview" //当点击了输入框上面的视图
#define K_CHATROOMLABEL @"k_chatroomlabel" //限时聊天室标签
#define K_MessageNumberNav @"k_messagenumbernav"//更新未读信息
//黑名单
#define k_blackList    @"blackList"       //黑名单列表

#define k_ThumbnailImage      @"thumbnailimage"     //缩略图
#define k_OriginalImage       @"originalimage"      //原图



//话题聊天广场
#define k_ClickTime @"clicktime"   //点击感兴趣时间
#define k_ClickTimeArray @"clicktimeArray" //点击感兴趣时间数组
#define K_NewClickTimeArray @"newclicktimearray" //点击新闻感兴趣时间
//设置
#define k_set         @"setState"          //勿扰状态
#define k_setArray    @"setArray"          //记录勿扰群组数组
#define k_location    @"location"          //位置信息
#define k_locationUID @"locationUID"          //位置信息UID
#define k_WhetherPrompt @"whetherPrompt"    //是否提示

#define K_UserMessageAndSet @"k_usermessageandset"  //用户系统消息 和 申请消息 和 消息提示设置
//信息 直接把Model信息剥离 加入字典  便于通用
#define k_UserID       @"userID"          //邀请人ID
#define k_UserName     @"userName"        //邀请人姓名
#define k_userAvatar   @"userAvatar"      //邀请人头像
#define k_from         @"from"            //邀请人来源
#define k_chatRoomMessage @"chatRoomMessage" //聊天室消息免打扰
//2016.3.22 dong
#define K_avaterPHImage @"login_head"     //头像默认头像
#define K_newsPHImage @"news_lost"     //新闻头像默认头像
#define k_begImage      @"750×750BG"        //默认背景图像
#define K_groupPHImage  @"group_head"     //群组默认头像
#define K_nopicture     @"nopicture"      //新闻聊天图片未加载等待图
#define K_defineImage   ImageNamed(@"pic_lost")// [UIImage imageWithColor:RGBAssistColor]
#define k_systemPhoto   @"msg_notice_pic2"//系统通知头像
#define k_Aapplication   @"msg_application_pic"    //申请消息头像
#define K_memberData    @"member_data"    //成员列表
#define K_uid           @"uid"            //名字
#define K_nickname      @"nickname"       //名字
#define K_avatar        @"avatar"         //头像
#define K_birth         @"birth"          //年龄
#define K_gender        @"gender"         //性别
#define K_lng           @"lng"            //经度
#define K_lat           @"lat"            //纬度
#define K_addr          @"addr"           //地址
//2016.4.12 dong
#define K_MESSAGE_ATTR_ISNOTICE @"noticeType" //通知类型，1=举报2=管理员禁言某个用户  有按钮点击类型
#define K_MESSAGE_NOTICE_ATTR_ISDEAL           @"isDeal" //是否已经处理过了   1代表同意  2代表拒绝
#define K_MESSAGE_NOTICE_ATTR_DATA           @"data"   //该通知的数据，是个jsonObject类型
#define K_MESSAGE_NOTICE_ATTR_BODY           @"message_body"   //该通知的消息描述

#define K_roomName           @"room_name"   //房间名
#define K_noticeRoomName      @"notice_roomName"//房间名消息用的
#define K_roomTopicName           @"room_topic_name"   //房间名
#define k_lastMessage         @"k_lastMessage"  //最后一条消息
#define k_roomPoto           @"room_Poto"   //房间头像
#define K_roomChannel           @"room_Channel"   //房间频道
#define K_createUserSendMessage @"create_user_send_message"//以创建人的身份发送一条假消息判断
#define K_MESSAGE_CUSTOM_ISNOTICE @"customNoticeType" //通知类型，0=有新人加入群组 1=被任命管理员2=被举报成功  3=被管理员禁言 纯通知  int   5=加入聊天室  6=离开聊天室    8=禁言 9=解除   

//2016.4.21 dong
#define K_MESSAGE_CMD_NOTICE @"cmdNotice" //透传通知 int


#define K_CHANGE_CONTROLLER_NOTICE3 @"changeControllerNotice3" //切换页面通知
#define K_LOAD_CONTROLLER_NOTICE @"loadControllerNotice" //重新加载聊天室
#define K_LEAVE_CONTROLLER_NOTICE @"leaveControllerNotice" //离开聊天室
#define K_CHANGE_MESSAGE_NOTICE @"changeMessageControllerNotice" //消息来了
#define K_REFRESH_FRIENDLIST @"refreshfriendlist"//刷新好友列表
#define K_TIME_NOTICE @"timeNotice" //时间通知
#define k_MYGROUPREFCHLIST @"mygrouprefchlist" //刷新我的群组列表通知
#define k_DELEGATEWINDOWS @"delegateWindows"//消除windows窗口方法
//非好友的信息
#define K_MESSAGE_ATTR_TOUID @"to_uid" //用户id int
#define K_MESSAGE_ATTR_FROM @"chat_from" //用户id int 聊天来源 
#define K_MESSAGE_ATTR_TOAVATRA @"to_avatar" //头像地址
#define K_MESSAGE_ATTR_TONICKNAME @"to_nickname" //昵称
//导航栏左上角item图片
#define K_NAVITEMMESSAGE @"k_navitemmessage"
#define K_NAVITEMMESSAGEA @"k_navitemmessageA"
#define K_NAVITEMNOMESSAGE @"k_navitemnomessage"
#define K_NAVITEMNOMESSAGEB @"k_navitemnomessageB"
//分享群组
#define K_MESSAGE_ATTR_MESSAGE_TYPE @"message_type" //通知类型 4=分享群组  特殊类型4=分享群组，7=新闻
#define K_RefreshGroupList @"RefreshGroupList"//刷新群组列表内容
#define K_MESSAGE_ATTR_GROUP_ID @"group_id" //群组ID int 
#define K_MESSAGE_ATTR_GROUP_AVATAR @"group_avatar" //群组头像
#define K_MESSAGE_ATTR_GROUP_NAME @"group_name"//群组名称
#define K_MESSAGE_ATTR_GROUP_DESC @"group_desc"//群组描述
#define K_MESSAGE_ATTR_GROUP_CONTENT @"share_content" //分享时输入的文字
#define K_ChatShareMessage @"chatRoom_share"   //聊天室分享
#define K_ErrorMsg  @"网络连接失败"  //请求失败
//2016.3.23 gao
#define k_member @"is_member"//标识是否加入群组

//2016.5.11 dong
#define K_RoomHistory @"room_history" //历史聊天室
#define K_EmExpressionId @"em_expression_id" //GiF图id
#define K_EmIsBigExpression @"em_is_big_expression" //是否是大图
#define K_dayFirstMessage   @"dayFirstMessage" //每天第一次发言
#define K_ErrorLog  @"error_log"  //错误日志
//2016.6.13 dong//新闻聊天相关
#define K_MESSAGE_ATTR_NEWS_IMGURL @"news_imgurl" ////新闻图片url
#define K_MESSAGE_ATTR_NEWS_TITLE @"news_title" //新闻标题
#define K_MESSAGE_ATTR_NEWS_ID   @"news_id" //新闻ID
#define K_MESSAGE_ATTR_NEWS_URL @"news_url"///新闻url
#define K_MESSAGE_ATTR_NEWS_WIDTH @"news_width"///新闻图片的宽度
#define K_MESSAGE_ATTR_NEWS_HEIGHT @"news_height"///新闻图片的高度
#define K_MESSAGE_ATTR_NEWS_LOADIMG @"news_loadImg" //新闻加载图片
#define K_MESSAGE_ATTR_NEWS_TYPE @"news_type"//新闻类型

//视频录制
#define K_FileName_Record    @"FileName_Record"   //文件名录制
#define K_FileName_RecordVideoName    @"FileName_RecordVideoName"   //文件名录制视频名
#define K_FileName_RecordVideoTag    @"K_FileName_RecordVideoTag"   //文件名录制视频名Tag


//2016.7.21 dong
#define K_LeaveChatRoom @"LeaveChatRoom"//离开聊天室
#define K_chatRoomEndTime @"chatRoomEndTime"//进入后台在返回前台时 发现聊天室结束了
#define K_chatRoomEndTimeTou @"chatRoomEndTimetou"
#define K_btnSize 18  //按钮字体
#define K_PackUpNews @"PackUpNews"//新闻收起通知
#define K_PutDownNews @"PutDownNews"//新闻放下
#define k_getOutGroup @"getoutgroup"//被提出群组

//聊天室新闻收动画
#define k_PackUpNewS @"packupnews"//收起新闻
#define k_PutDownNewS @"putdownnews"//放下新闻

#define k_PackUpNewSGroup @"packupnewsgroup"//群组收起新闻
#define k_PutDownNewSGroup @"putdownnewsgroup"//群组放下新闻
#define K_REFRESHNEWS @"refreshnews"//新闻刷新
#define K_GOURP_DELETE @"group_delete" //群组被解散

//刷新话题聊天页面数据
#define K_RELOADDATATOPICCHATLIST @"k_reloaddatatopicchatlist"//刷新话题聊天列表通知
#define K_RELOADDATANewCHATLIST @"k_reloaddatanewchatlist"//刷新话题聊天列表通知
#define K_REMOVETOPDATA @"k_removetopdata"//删除置顶话题聊天室通知
#define K_TOPIC_BOOL  @"topic_bool"  //是否是话题聊天室
#define K_TOPMESSAGENUMBER @"k_topmessagenumber" //刷新置顶话题聊天室消息条数
#define K_NEWSMESSAGENUMBER @"k_newsmessagenumber"//刷新右上角聊天室消息条数
#define K_NONET @"k_nonet"//没有网络
#define K_HAVENET @"k_havenet" //没有网络
#define K_IntentNet @"intentNet" //网络key
#define K_CHAT_ROOM_KEY  @"chat_room_key"  //聊天室key
#define K_PUSHNEWCHATVIEW @"PushNewChatView" //跳转新闻聊天室
#define K_RefreshNewList @"RefreshNewList"//刷新新闻列表

#define K_RELOAD_CONTROLLER_TOPIC @"reload_controller_topic" //重新加载页面
#define K_RELOAD_CONTROLLER_SQUARE @"reload_controller_square" //重新加载页面
#define K_RELOAD_CONTROLLER_MESSAGE @"reload_controller_square" //重新加载页面 从消息界面 跳入的
#define K_CID_TOPIC @"cid"//感兴趣id
#define K_CID_AGREE @"agree" //感兴趣同意
#define K_PAN_NOTICE_YES @"pan_notice_yes" //手势通知
#define K_PAN_NOTICE_NO @"pan_notice_no" //手势通知
#define K_Unblock_User @"unblock_user" //取消屏蔽用户
#define K_Unforbid_User @"unforbid_user" //取消禁言用户

//搜索群组

#define K_searchGroupPush @"groupPush"//搜索群组跳转代理

#define k_pushAlone          @"pushAlone"             //跳入单聊
#define k_friendAlone          @"friendAlone"             //跳入单聊


#define k_forbidTime        3600         //禁言时间

#define K_fontPingfang @"PingFangSC-Regular"  //苹果字体

//角色
#define K_RoleAvatar @"role_avatar"//角色头像
#define K_RoleName @"role_name" ////带编号的角色名
#define K_RoleRealname @"role_realname"//真正的角色名
#endif
