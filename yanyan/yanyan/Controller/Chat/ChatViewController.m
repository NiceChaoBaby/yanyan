                                                      //
//  ChatViewController.m
//  chat
//
//  Created by dong on 16/3/8.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "ChatViewController.h"


//#import "TBActionSheet.h"
//#import "FriendListModel.h"
////#import "EaseMessageModel.h"
//#import "LookUserViewController.h"
//#import "GroupMemberViewController.h"
//#import "GroupMemberModel.h"
//#import "ChatMemberListModel.h"
//#import "ShareView.h"
//#import "BlickListModel.h"
//#import "RoleDataViewController.h"
//#import "AnswerModel.h"
//#import "optionsView.h"
//#import "WaitingFigureView.h"
//#import "NewsModel.h"
@interface ChatViewController()
//()<UIAlertViewDelegate,EMClientDelegate,EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource,TBActionSheetDelegate,CustomMessageTableViewCellDelegate>
//{
//    BOOL m_flash;//判断是否在执行倒计时动画 如果在执行 则先不执行其他动画
//    UILabel * m_WelcomeLabel; //欢迎语Lable
//    BOOL m_net;//判断加载了网络请求以后 才允许执行Star  不然一进来先执行ViewWillApaer的star 在执行网络请求的star 动画要走两遍
//    NSString * m_id;//聊天室ID 当看聊天室详情的时候有用
//    NSMutableArray * m_blockListArray;
//   BOOL m_push;//处理同时推页面
// 
//}


//@property(nonatomic,strong)optionsView *m_actionSheet;
//@property(nonatomic,strong)NSString *m_userId;
////@property(nonatomic,strong)NSString * m_roomeName;
//@property(nonatomic,strong)UIView * m_view;
//@property(nonatomic,strong)NSString *m_topicDesc;//话题描述
//@property(nonatomic,strong)NSString *m_topicUrl;//话题头像
//@property(nonatomic,assign)double m_topicJoinTime;//加入话题聊天室的时间
//@property(nonatomic,strong)UIView * m_topicTimeView;//提示时间还有多久Name
//@property(nonatomic,strong) NSMutableArray * m_chatRoomData;//聊天室人数详情
//@property(nonatomic,strong) NSMutableArray *m_arrTitle;//举报,加好友类标题
//@property(nonatomic,strong)  UIButton *rightButton1;

@end

@implementation ChatViewController



//- (void)viewDidLoad
//{
//
//    //注册UI通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingView) name:@"Havelove" object:nil];
//    //注册UI通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myLeaveChatRoom) name:K_LeaveChatRoom object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touchPhotoView) name:K_TOUCHPHOTOVIEW object:nil];
// 
//    
//   self.m_blockListArr=[[NSMutableArray alloc] init];
// 
//    //得到用户保存的aLat和aLong
//    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//    //服务器分配给用户的房间号
//    NSString *roomId=  ShareAppDelegate.m_roomId;
//      [[WaitingFigureView shareInstance]addWaitingFigureView];
////    self.m_roomeName =  self.m_titleTopic ;
//    if (!roomId)
//    {
//        [self getNetRequestChatRoomEnterlng: [accountDefaults objectForKey:UserLocationLo] lat:[accountDefaults objectForKey:UserLocationLa] addr:[accountDefaults objectForKey:UserLocationAddress]];
//    }else
//    {
//     [self getNetChatroomInfo:roomId];
//    }
//    
//
//
//        [self initViewTopicTimeView];
//
//        //  回到前台
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(didBecomeActiveNotification)
//                                                     name:UIApplicationDidBecomeActiveNotification
//                                            object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(chatRoomEndTime)
//                                                 name:K_chatRoomEndTime
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(chatRoomEndTimetou)
//                                                 name:K_chatRoomEndTimeTou
//                                               object:nil];
//    
//    //这里只有角色聊天室禁用
//    if (self.m_chatRoomType == ChatRoomTypeRolePlay) {
//    //这里禁用边缘侧滑返回  是因为会和  滑动返回冲突  边缘策划返回 不会走滑动返回的判断
//       if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//                self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//             }
//    }
//
//}
//-(void)chatRoomEndTime
//{
//    //进这个方法聊天室已经结束了  但是我如果直接吧聊天室删除了  就接不到这个通知了所以我在接到这个通知的时候是没有删除字典里的聊天室  而是在执行完这个方法之后才去删除字典里的controller
//    if([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
//    {
//        [DTools alertController:self title:nil message:@"离开聊天室时间过长，您已退出当前聊天室" handler:^(UIAlertAction *action) {
//            [self ClickleftState:nil];
//        }];
//    }
//}
//
//
//-(void)chatRoomEndTimetou
//{
//    //进这个方法聊天室已经结束了  但是我如果直接吧聊天室删除了  就接不到这个通知了所以我在接到这个通知的时候是没有删除字典里的聊天室  而是在执行完这个方法之后才去删除字典里的controller
//    if([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
//    {
//            [self ClickleftState:nil];
//    }
//}
//-(void)didBecomeActiveNotification
//{
//
//    //    话题聊天室
//    NSUserDefaults *time=[NSUserDefaults standardUserDefaults];
//    
//    if ( self.m_chatRoomType ==ChatRoomTypeRolePlay){
//        NSDate* theDate=[time objectForKey:K_RoleEndTime];
//        [self endTimeDate:theDate];
//        
//    }
//    
//}
//-(void)endTimeDate:(NSDate*)theDate
//{
//    // 获取系统当前的时间戳
//    
//    NSTimeInterval cha=[theDate timeIntervalSinceDate:[[XSDTimeCalibration share]getServerDate]];
//    if (cha<=0)
//    {
//        if([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
//        {
//            self.m_remainTime=[NSString stringWithFormat:@"%.f",cha];
//            [self deletePerformSelector];
//            [self startCompareTime];
//        }
//    }
//
//}
//-(void)loadingView
//{
//    [self initView];
//    self.delegate = self;
//    self.dataSource = self;
//   
//}
//
//
///**
// *  这部分必须放到[super viewDidLoad];前面因为我是用storyboard做的界面初始化不一样
// */
//-(void)initData
//{
//    //初始化数据
//    self.conversation = [[EMClient sharedClient].chatManager getConversation: ShareAppDelegate.m_roomId type:EMConversationTypeChatRoom createIfNotExist:YES];
//    
//   
//   
//    self.messageCountOfPage =10;
//    self.timeCellHeight = 30;
//    self.deleteConversationIfNull = YES;
//    self.scrollToBottomWhenAppear = YES;
//    self.messsagesSource = [NSMutableArray array];
//    [self.conversation markAllMessagesAsRead];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareInfo:) name:K_ChatShareMessage object:nil];
//}
//
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [IQKeyboardManager sharedManager].enable = NO;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
//    [self.navigationController setNavigationBarHidden:NO  animated:NO];
//    self.toHeight = 0;
//    
// 
//    ShareAppDelegate.isExistChatRoom=YES;
//   
//    
//    
//        if(![ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
//        {
//            [DTools alertController:self title:nil message:@"离开聊天室时间过长，您已退出当前聊天室" handler:^(UIAlertAction *action) {
//                [self ClickleftState:nil];
//            }];
//            
//        }
//  
//    
//       [[ChatTime shareInstance] chatTimeEnd];
//
//    //设置导航栏不透明
//   
//      [[EaseBaseMessageCell appearance]  setMessageNameIsHidden:NO];
//    [[EaseBaseMessageCell appearance] setMessageNameHeight:15.f];
//    self.navigationController.navigationBar.translucent = NO;
//    //修改状态栏 白色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    
//    
//    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor =RGBBgNavColor;
////    //字体颜色
////    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
////    self.navigationController.navigationBar.titleTextAttributes = dict;
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18],
//       NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    
//    
////  if (LCDW < 375 ) {
//    //注册键盘出现的通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//     
//                                             selector:@selector(keyboardWasShown:)
//     
//                                                 name:UIKeyboardWillShowNotification object:nil];
//    
//    //注册键盘消失的通知
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//     
//                                             selector:@selector(keyboardWillBeHidden:)
//     
//                                                 name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PackUpNews) name:K_PackUpNews object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PutDownNews) name:K_PutDownNews object:nil];
//      if(self.m_chatRoomType ==ChatRoomTypeRolePlay)
//      {
//           self.tableView.frame=CGRectMake(0, 0, self.tableView.frame.size.width, self.view.frame.size.height-46 -44);
//      }
//    //设置左侧返回键
//    [self setNavtitleNumber];
//    //更新未读信息数量
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNavtitleNumber) name:K_MessageNumberNav object:nil];
//   
//     self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//    //拉取黑名单
//    [self AccessBlacklist];
//   
////    [self.tableView reloadData];
//}
////拉取黑名单
//-(void)AccessBlacklist
//{
//    NSDictionary * dic = [URLPath getNetBlackListRequest];
//    [[AFHTTPClient share]postMethod:[dic objectForKey:K_URL] param:[dic objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
//        NSInteger rs = [[respostData safeObjectForKey:K_rs]integerValue];
//        if (rs == 1) {
//            NSMutableArray * array = [BlickListModel mj_objectArrayWithKeyValuesArray:[respostData objectForKey:K_data]];
//            m_blockListArray = [[NSMutableArray alloc]initWithCapacity:0];
//            [m_blockListArray addObjectsFromArray:array];
//            [DTools storageUserBlackList:m_blockListArray];//储存黑名单
////            //如果存在黑名单 则不显示
////            if ([self CompareTheBlacklist]) {
////                self.m_lowH.constant = 0;
////                self.m_optionsView.hidden = YES;
////            }else{
////                self.m_lowH.constant = 49;
////                self.m_optionsView.hidden = NO;
////            }
////            
//        }
//        
//        
//        
//        
//    } failed:^(NSString *errorMsg) {
//        [SVProgressHUD showErrorWithStatus:errorMsg];
//
//    }];
//
//}
////判断是否在黑名单列表里
//-(BOOL)CompareTheBlacklistMyUid:(int)uid
//{
//    if (m_blockListArray.count !=0) {
//        for (BlickListModel * model in m_blockListArray) {
//            if ( uid  == [model.m_id integerValue]) {
//                
//                return YES;
//                break;
//                
//            }
//        }
//    }
//    
//    
//    
//    return NO;
//    
//}
//
///**
// *  设置导航栏
// */
//-(void)initSetNav
//{
//    //设置导航栏不透明
//    
//    self.navigationController.navigationBar.translucent = NO;
//    //修改状态栏 白色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor =RGBBgNavColor;
//    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
//    temporaryBarButtonItem.title = @"";
//    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18],
//       NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    
//   
//        //自定义导航栏右边按钮
//        UIButton *rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        [rightButton2 setFrame: CGRectMake(0, 0, 32, 32)];
//       
//        [rightButton2 setImage:ImageNamed(@"chatroom_date_group.png") forState:UIControlStateNormal];
//        [rightButton2 setImage:ImageNamed(@"chatroom_date_group.png") forState:UIControlStateHighlighted];
//        if (self.m_chatRoomType==ChatRoomTypeRolePlay) {
//            [rightButton2 setImage:ImageNamed(@"group_card") forState:UIControlStateNormal];
//            [rightButton2 setImage:ImageNamed(@"group_card") forState:UIControlStateHighlighted];
//        }
//        [rightButton2 addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchDown];
//    
//        self.navigationItem.rightBarButtonItems =[[NSArray alloc] initWithObjects: [[UIBarButtonItem alloc]initWithCustomView:rightButton2], nil];
//    
//    
//}
//
//-(void)initView
//{
//  //角色扮演没有提示
//    if (self.m_chatRoomType !=ChatRoomTypeRolePlay) {
//        self.m_view  = [[UIView alloc]initWithFrame:CGRectMake(0, -50, LCDW, 50)];
//        self.m_view.backgroundColor = RGBACOLOR(255,184,44,1);
//    m_WelcomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, LCDW, 100)];
//    m_WelcomeLabel.font = [UIFont systemFontOfSize:17];
////    NSString * str = [self readRoomName];
//    m_WelcomeLabel.text = [NSString stringWithFormat:@"聊天室剩余时间%@",[self ChatFormateDate:self.m_remainTime]];
//    
//    m_WelcomeLabel.textColor = [UIColor whiteColor];
//    m_WelcomeLabel.textAlignment = NSTextAlignmentCenter;
//    m_WelcomeLabel.numberOfLines = 0;
//    [m_WelcomeLabel sizeToFit];
//    m_WelcomeLabel.frame = CGRectMake(0, 15, LCDW, CGRectGetHeight(m_WelcomeLabel.frame));
//    self.m_view.frame =CGRectMake(0, -50, LCDW, CGRectGetHeight(m_WelcomeLabel.frame)+ 30);
//    [self.m_view addSubview:m_WelcomeLabel];
//           [self.view addSubview:self.m_view];
//    }
// 
//    
//  
//   
//    [[EaseBaseMessageCell appearance] setAvatarSize:40.f];
//    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.f];
//    [[EaseBaseMessageCell appearance] setMessageNameHeight:15.f];
//    [[EaseChatBarMoreView appearance] setMoreViewBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0]];
//    [[EaseBaseMessageCell appearance]  setMessageNameIsHidden:NO];
//   
//    
//        [self BeginFlashLable];
//    
//}
//-(void)BeginFlashLable
//{
//    
//    
//    self.m_Down = YES;
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        self.m_view.frame = CGRectMake(0, 0, LCDW, CGRectGetHeight(m_WelcomeLabel.frame)+30);
//        
//        
//    } completion:^(BOOL finished) {
//        
//        //延时两秒
//        [self performSelector:@selector(delayFlash) withObject:nil afterDelay:2.0f];
//        
//    }];
//    
//}
//-(void)delayFlash
//{
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        self.m_view.frame = CGRectMake(0, -50, LCDW, 50);
//        
//        
//    } completion:^(BOOL finished) {
//        
//        self.m_view.hidden = YES;
//        
//        CGRect rect = self.tableView.frame;
//        CGFloat toHeight = self.toHeight;
//        ////        if (LCDW < 375) {
//        if (toHeight > 90) {
//            
//            rect.origin.y = 0;
//            if (self.m_chatRoomType ==ChatRoomTypeRolePlay) {
//                rect.size.height = self.view.frame.size.height - toHeight;
//            }
//            
//            self.tableView.frame = rect;
//            [self _scrollViewToBottom:NO];
//        }else{
//        
//        //          [view removeFromSuperview];
//       
//        [UIView animateWithDuration:1 animations:^{
//            
//    
//            
//        } completion:^(BOOL finished) {
//            
//            [self _scrollViewToBottom:NO];
//  
//            self.showRefreshHeader = YES;
//          
//        }];
//        }
//    }];
//}
//
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//     [self.chatToolbar endEditing:YES];
//     [IQKeyboardManager sharedManager].enable = YES;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
//
//
//   
//    [[ChatTime shareInstance] chatTimeStart];
//
//
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:K_MessageNumberNav object:nil];
//     [[NSNotificationCenter defaultCenter]removeObserver:self name:K_PackUpNews object:nil];
//      [[NSNotificationCenter defaultCenter]removeObserver:self name:K_PutDownNews object:nil];
//
//
//    
//    ShareAppDelegate.isExistChatRoom=NO;
//    
//
//   
//}
//
//#pragma mark 按钮事件s
//
//
///**
// *  发送帮禁言消息
// *
// *  @param isbanned 是否禁言
// */
//-(void)bannedSendMessage:(BOOL)isbanned
//{
//    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//    RegisteredUser *regist= [DPlistSave readUserData];
//    
// 
//    EMTextMessageBody *body2 = [[EMTextMessageBody alloc] initWithText:@""];
//    NSString *from2 = [[EMClient sharedClient] currentUsername];
//    NSDictionary *messageExt2=[[NSDictionary alloc] initWithObjectsAndKeys:
//                               regist.m_nickname,K_nickname,
//                               regist.m_avatar,K_avatar,
//                               [NSNumber numberWithInt:[regist.m_gender intValue] ],K_gender,
//                               regist.m_birth,K_birth,
//                                regist.m_signature,K_SIGNATURE_INFO,
//                               [accountDefaults objectForKey:UserLocationLo],K_lng,
//                               [accountDefaults objectForKey:UserLocationLa],K_lat,
//                               [accountDefaults objectForKey:UserLocationAddress],K_addr,
//                               [NSNumber numberWithInt:[[accountDefaults objectForKey:UserDefaultNameKey] intValue] ],K_uid,
//                               
//                               
//                               nil];
//    
//    //生成Message
//    EMMessage *message2 = [[EMMessage alloc] initWithConversationID:ShareAppDelegate.m_roomId from:from2 to:ShareAppDelegate.m_roomId body:body2 ext:messageExt2];
//    //    message.chatType = EMChatTypeChat;// 设置为单聊消息
//    message2.chatType = EMChatTypeChatRoom;// 设置为群聊消息
//    //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
//    
//    __weak typeof(self) weakself = self;
//    [self addMessageToDataSource:message2 progress:nil];
//    [[EMClient sharedClient].chatManager asyncSendMessage:message2 progress:nil completion:^(EMMessage *aMessage, EMError *aError)
//     {
//         
//         
//         
//         if (aError)
//         {
//             DLog(@"发送错误%i",aError.code);
//         }else{
//             
//             
//            
//         }
//      
//         [weakself.tableView reloadData];
//     }];
//    
//    
//
//}
//-(void)showDetail
//{
//    
//    
//    if(self.m_chatRoomType == ChatRoomTypeRolePlay){
//        
//        UIStoryboard * story = [UIStoryboard storyboardWithName:@"ChatSquare" bundle:nil];
//        RoleDataViewController  * vc = [story instantiateViewControllerWithIdentifier:@"RoleDataViewController"];
//        vc.m_roomId = self.m_RoleDataID;
//         vc.m_isChatRoomPush = YES;
//        [vc.m_dataBlockArr removeAllObjects];
//        [vc.m_dataBlockArr addObjectsFromArray:self.m_blockListArr];
//        [self.navigationController pushViewController:vc animated:YES];
//        
//
//        
//    }
//   
//}
//
//-(void)requestNet
//{
//
//    NSDictionary * info = [URLPath getNetChatRoomDataGRoomID:ShareAppDelegate.m_roomId];
//    [[AFHTTPClient share]getMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
//        NSInteger  rs = [[respostData safeObjectForKey:K_rs]integerValue];
//        if (rs == 1) {
//            
//            DLog(@"%@",respostData);
//            
//            [SVProgressHUD dismiss];
//            self.m_chatRoomData = [GroupMemberModel mj_objectArrayWithKeyValuesArray:[respostData objectForKey:K_data]];
//            //添加结束时间
//            for (int i = 0; i <self.m_chatRoomData.count ; i ++) {
//                GroupMemberModel * model = self.m_chatRoomData[i];
//                if ([model.m_isforbid boolValue])
//                {
//                    NSDate* theDate=[[XSDTimeCalibration share] getCurrentTimeAddSinceNow:model.m_remain];
//                   
//                    //取两个日期对象的时间间隔：
//                    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
//                    //                    NSTimeInterval cha=[theDate timeIntervalSinceDate:currentDate];
//                    model.m_endDate=theDate;
//                    [self.m_chatRoomData replaceObjectAtIndex:i withObject:model];
//                }
//                
//                
//            }
//
//            
//        }else{
//            
//            
//               [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//        }
//        
//        
//        
//    } failed:^(NSString *errorMsg) {
//           [SVProgressHUD showErrorWithStatus:errorMsg];
//    }];
//
//    
//    
//}
//
//
//
//
//
//
//
//-(void)myLeaveChatRoom
//{
//    
//    if (self.conversation.type == EMConversationTypeChatRoom)
//    {
//        
//        //退出聊天室，删除会话
//        if (self.isJoinedChatroom)
//        {
//            
//            
//              ShareAppDelegate.isExistChatRoom=NO;
//           
//            [[NSNotificationCenter defaultCenter] removeObserver:self];
//            
//            [[EMCDDeviceManager sharedInstance] stopPlaying];
//            [EMCDDeviceManager sharedInstance].delegate = nil;
//            
//            if (self.imagePicker){
//                [self.imagePicker dismissViewControllerAnimated:NO completion:nil];
//                self.imagePicker = nil;
//            }
//            if(self.m_chatRoomType ==ChatRoomTypeRolePlay)
//            {
//                //取消执行话题倒计时
//                [self deletePerformSelector];
//            }
//            
//            NSString *chatter = [self.conversation.conversationId copy];
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                EMError *error = nil;
//                [[EMClient sharedClient].roomManager leaveChatroom:chatter error:&error];
//                if (error !=nil) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                          DLog(@"%@离开聊天室失败",chatter);
//                    });
//                }else
//                {
//                    //当退出了聊天室 小米的推送也要注销掉
//                    [MiPushSDK unsubscribe:[NSString stringWithFormat:@"room_%@",chatter]];
//                    DLog(@"%@离开聊天室成功",chatter);
//                }
//            });
//        }
//        else
//        {
////            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId deleteMessages:YES];
//            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError) {
//                
//            }];
//            
//        }
//    }
//    
//    [[EMClient sharedClient] removeDelegate:self];
//     [[EMClient sharedClient].chatManager removeDelegate:self];
//     [[EMClient sharedClient].roomManager removeDelegate:self];
//}
//#pragma mark - 当用户点击了输入框上方的视图
///**
// *  当用户点击了输入框上方的视图
// */
//-(void)touchPhotoView
//{
//    if (self.m_chatRoomType == ChatRoomTypeRolePlay)
//    {
//        NSMutableArray * arrayyyy =  ShareAppDelegate.m_ChatNumberPeople;
//        NSMutableArray * array = [ChatMemberListModel mj_keyValuesArrayWithObjectArray:ShareAppDelegate.m_ChatNumberPeople];
//       NSMutableArray * dataArray = [GroupMemberModel mj_objectArrayWithKeyValuesArray:array];
//        //查看话题聊天室成员
//        GroupMemberViewController * member = [[GroupMemberViewController alloc] init];
//        member.m_chatRoomType = self.m_chatRoomType;
//        
//        [member.m_dataArr addObjectsFromArray:dataArray];
//        //判断如果是聊天页面跳转过来了的  肯定带有BlickList数组 将数组传入 成员管理页面
//        [member.m_dataBlockArr addObjectsFromArray:self.m_blockListArr];
//        [self.navigationController pushViewController:member animated:YES];
//
//        
//      
//        
//    }
//    
//    
//}
///**
// *  话题聊天室详情
// */
//-(void)chatData
//{
//    NSDictionary * info =   [URLPath getNetTopicChatRoomInformationEid:m_id];
//    
//    [[AFHTTPClient share]getMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
//        NSInteger rs = [[respostData safeObjectForKey:K_rs]integerValue];
//        if (rs == 1) {
//            [SVProgressHUD dismiss];
//            NSDictionary * dic = [respostData objectForKey:K_data];
//            
//            //查看话题聊天室成员
//            GroupMemberViewController * member = [[GroupMemberViewController alloc] init];
//            NSMutableArray * dataArray = [GroupMemberModel mj_objectArrayWithKeyValuesArray:[dic objectForKey:@"members"]];
//            [member.m_dataArr addObjectsFromArray:dataArray];
//            //判断如果是聊天页面跳转过来了的  肯定带有BlickList数组 将数组传入 成员管理页面
//            [member.m_dataBlockArr addObjectsFromArray:self.m_blockListArr];
//            [self.navigationController pushViewController:member animated:YES];
//        
//        }else{
//            
//           [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//            
//        }
//    } failed:^(NSString *errorMsg) {
//        [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
//    }];
//    
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}
//#pragma mark ---  点击头像按钮
///*!
// @method
// @brief 点击消息头像
// @discussion 获取用户点击头像回调
// @param viewController 当前消息视图
// @param messageModel 消息模型
// @result
// */
//- (void)messageViewController:(EaseMessageViewController *)viewController
//  didSelectAvatarMessageModel:(id<IMessageModel>)messageModel
//{
//    
//    
//    if (messageModel.isSender)
//    {
//        return;
//    }
//    if (!m_push)
//    {
//        
//        m_push = YES;
//    //    UserProfileViewController *userprofile = [[UserProfileViewController alloc] initWithUsername:messageModel.message.from];
//    //    [self.navigationController pushViewController:userprofile animated:YES];
//    //是否是当前登录者发送的消息
//
//            
//            
//          DLog(@"点击头像了");
//         [self.view endEditing:YES];
//            self.m_actionSheet = [[optionsView alloc] initWithFrame:CGRectMake(0, 0, LCDW, LCDH+20)];
//            [self.m_actionSheet setCloseBlock:^{
//                
//                m_push = NO;
//                
//            }];
//    
//    self.m_messageModel=messageModel;
//           
//            int uid=  [[self.m_messageModel.message.ext objectForKey:K_uid] intValue];
//            self.m_arrTitle=[[NSMutableArray alloc] init];
//             if( self.m_chatRoomType ==ChatRoomTypeRolePlay)
//            {
//                //    角色聊天室
//                NSUserDefaults *time=[NSUserDefaults standardUserDefaults];
//                NSDate* theDate=[time objectForKey:K_RoleEndTime];
//                // 获取系统当前的时间戳
//                NSTimeInterval cha=[theDate timeIntervalSinceDate:[[XSDTimeCalibration share]getServerDate]];
//                if (cha<=1)
//                {
//                    self.m_actionSheet.m_dataView=[self customRoleViewAction:messageModel arr:self.m_arrTitle];
//                    return;
//                }
//            }
//
//    //是否是好友
//            if (![DTools compareIsFriend:uid])
//            {
//              //判断等级是否够加好友
//                 UserOperation * userModel = [self DetermineTheUserLevelOperationType:addFriend];
//                
//                if (!userModel.m_level  && ![self CompareTheBlacklistMyUid:uid])
//                {
//                    
//                     [self.m_arrTitle addObject:@"加好友"];
//                    
//                }
//               
//            }
//            
//            //是否被我屏蔽 已屏蔽简单的发言，可在成员列表中取消屏蔽
//            if (![self compareIsBlock:uid])
//            {
//                [self.m_arrTitle addObject:@"不看用户发言"];
//            }
//
//           
//                
//                
//            if( self.m_chatRoomType ==ChatRoomTypeRolePlay)
//            {
//                 
//               [self.m_arrTitle addObject:@"发起禁言投票"];
//            }
//              
//           
//            if( self.m_chatRoomType ==ChatRoomTypeRolePlay)
//            {
//             self.m_actionSheet.m_dataView=[self customRoleViewAction:messageModel arr:self.m_arrTitle];
//            }
//        
//        }
//}
//-(UIView *)customViewAction:(id<IMessageModel>)messageModel arr:(NSArray *)arrTitle
//{
//    
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, LCDW-20, 80+arrTitle.count*50)];
//    view.backgroundColor=[UIColor whiteColor];
//    [DTools getCorner:view radius:5];
//    UIView *userView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,  LCDW-20, 80)];
//    [view addSubview:userView];
//    
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAvatar)];
//    [userView addGestureRecognizer:tap];
//    self.m_userId=[NSString stringWithFormat:@"%i",[[messageModel.message.ext objectForKey:K_uid] intValue]];
//    
//    UIImageView *avatarImage=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
//    [avatarImage sd_setImageWithURL:[NSURL URLWithString:messageModel.avatarURLPath] placeholderImage:ImageNamed(K_avaterPHImage)];
//    [DTools getCorner:avatarImage radius:50/2];
//    [userView addSubview:avatarImage];
//    
//    UILabel *nameLab=[[UILabel alloc] init];
//    nameLab.translatesAutoresizingMaskIntoConstraints = NO;
//    nameLab.textColor=[UIColor blackColor];
//    nameLab.lineBreakMode=NSLineBreakByTruncatingTail;
//    nameLab.text=[messageModel.nickname replaceUnicode];
//    nameLab.font=[UIFont systemFontOfSize:16];
//    [userView addSubview:nameLab];
//    
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:nameLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:userView attribute:NSLayoutAttributeTop multiplier:1.0 constant:22]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:nameLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:avatarImage attribute:NSLayoutAttributeRight multiplier:1.0 constant:15]];
//  
//    
//    
//    UIButton *sexBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
//    //sexBtn.frame=CGRectMake(CGRectGetMaxX(avatarImage.frame)+15,CGRectGetMaxY(nameLab.frame)+5, 50, 15);
//     sexBtn.translatesAutoresizingMaskIntoConstraints = NO;
//    
//   // DLog(@"messageModel.message.ext----------%@",messageModel.message.ext);
//    //1男 2女
//    if ([[messageModel.message.ext safeObjectForKey:K_gender] intValue] ==1)
//    {
//         [sexBtn setImage:ImageNamed(@"btn_male") forState:UIControlStateNormal];
//        [sexBtn setBackgroundColor:RGBBgMaleLabColor];
//    }else
//    {
//         [sexBtn setImage:ImageNamed(@"btn_female") forState:UIControlStateNormal];
//        [sexBtn setBackgroundColor:RGBBgFemaleLabColor];
//    }
//    NSString *age=[DTools getUserAge:[messageModel.message.ext objectForKey:K_birth]];
//    [sexBtn setTitle:age forState:UIControlStateNormal];
//     [sexBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
//    
//    [userView addSubview:sexBtn];
//    
//    
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:sexBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:userView attribute:NSLayoutAttributeTop multiplier:1.0 constant:22]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:sexBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:nameLab attribute:NSLayoutAttributeRight multiplier:1.0 constant:20]];
//    
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:sexBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:sexBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:15]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:sexBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:userView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15]];
//    
//    
//    [sexBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 0)];
//    [sexBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -4, 0, 0)];
//    
//    
//    
//    
//    //简介
//    UILabel *introductionLab=[[UILabel alloc] init];
//    introductionLab.translatesAutoresizingMaskIntoConstraints = NO;
//    introductionLab.textColor=RGBAssistColor;
//    introductionLab.lineBreakMode=NSLineBreakByTruncatingTail;
//    introductionLab.text=[[messageModel.message.ext safeObjectForKey:K_SIGNATURE_INFO] replaceUnicode];
//    introductionLab.font=[UIFont systemFontOfSize:14];
//    [userView addSubview:introductionLab];
//   // DLog(@"个人签名怎么没有呢===%@",[messageModel.message.ext safeObjectForKey:K_SIGNATURE_INFO]);
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:introductionLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:nameLab attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:introductionLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:avatarImage attribute:NSLayoutAttributeRight multiplier:1.0 constant:15]];
//    
//       [view addConstraint:[NSLayoutConstraint constraintWithItem:introductionLab attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:userView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15]];
//    
//    
//    
//    
//    
//    
//    UIView *userLine=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(userView.frame)-1,  [TBActionSheet appearance].sheetWidth, 1)];
//    userLine.backgroundColor=RGBLineColor;
//    [userView addSubview:userLine];
//    [DTools getCorner:sexBtn radius:2];
//    
//    for (int i=0; i<arrTitle.count; i++)
//    {
//        
//       
//        UIButton *sexBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
//        sexBtn.frame=CGRectMake(0,CGRectGetMaxY(userView.frame)+50*i, [TBActionSheet appearance].sheetWidth, 50);
//        sexBtn.backgroundColor=[UIColor whiteColor];
//        sexBtn.tag=i;
//        [sexBtn setTitle:[arrTitle objectAtIndex:i] forState:UIControlStateNormal];
//        if(i==arrTitle.count-1)
//        {
//            [sexBtn setTitleColor:RGBACOLOR(255, 0, 0, 1) forState:UIControlStateNormal];
//        }else
//        
//        {
//        
//            [sexBtn setTitleColor:self.view.tintColor forState:UIControlStateNormal];
//        }
//        
//        [sexBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
//        [sexBtn addTarget:self action:@selector(clickTitleAction:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:sexBtn];
//        UIView *userLine=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(sexBtn.frame)-1,  [TBActionSheet appearance].sheetWidth, 1)];
//        userLine.backgroundColor=RGBLineColor;
//        [sexBtn addSubview:userLine];
//    }
//    
//    
//    
//    
//    return view;
//}
//-(UIView *)customRoleViewAction:(id<IMessageModel>)messageModel arr:(NSArray *)arrTitle
//{
//    
//    
//    EMMessage *message=messageModel.message;
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, LCDW-20, 118+arrTitle.count*50)];
//    view.backgroundColor=[UIColor whiteColor];
//    [DTools getCorner:view radius:5];
//    UIView *userView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,  LCDW-20, 118)];
//    [view addSubview:userView];
//    
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAvatar)];
//    [userView addGestureRecognizer:tap];
//    self.m_userId=[NSString stringWithFormat:@"%i",[[messageModel.message.ext objectForKey:K_uid] intValue]];
//    
//    UIImageView *avatarImage=[[UIImageView alloc] init];
//    avatarImage.translatesAutoresizingMaskIntoConstraints = NO;
//    [avatarImage sd_setImageWithURL:[NSURL URLWithString:messageModel.avatarURLPath] placeholderImage:ImageNamed(K_avaterPHImage)];
//    [DTools getCorner:avatarImage radius:70/2];
//    [userView addSubview:avatarImage];
//    
//    UILabel *nameLab=[[UILabel alloc] init];
//    nameLab.translatesAutoresizingMaskIntoConstraints = NO;
//    nameLab.textColor=[UIColor blackColor];
//    nameLab.lineBreakMode=NSLineBreakByTruncatingTail;
//    nameLab.text=[messageModel.nickname replaceUnicode];
//    nameLab.font=[UIFont systemFamilyFontOfSize:16];
//    nameLab.textAlignment = NSTextAlignmentCenter;
//    nameLab.textColor=RGBChatTextColor;
//    [userView addSubview:nameLab];
//    
//    UIImageView *roleAvatarImage=[[UIImageView alloc] init];
//    roleAvatarImage.translatesAutoresizingMaskIntoConstraints = NO;
//    [roleAvatarImage sd_setImageWithURL:[NSURL URLWithString:[message.ext safeObjectForKey:K_RoleAvatar]] placeholderImage:ImageNamed(K_avaterPHImage)];
//    [DTools getCorner:roleAvatarImage radius:70/2];
//    [userView addSubview:roleAvatarImage];
//    
//    UILabel *roleNameLab=[[UILabel alloc] init];
//    roleNameLab.translatesAutoresizingMaskIntoConstraints = NO;
//    roleNameLab.textColor=[UIColor blackColor];
//    roleNameLab.lineBreakMode=NSLineBreakByTruncatingTail;
//    roleNameLab.textAlignment = NSTextAlignmentCenter;
////    NSString * str = [[message.ext safeObjectForKey:K_RoleRealname] replaceUnicode];
//    roleNameLab.text=[[message.ext safeObjectForKey:K_RoleRealname] replaceUnicode];//;
//    roleNameLab.font=[UIFont systemFamilyFontOfSize:16];
//    roleNameLab.textColor=RGBChatTextColor;
//    [userView addSubview:roleNameLab];
//    
//    UILabel *roleLab=[[UILabel alloc] init];
//    roleLab.translatesAutoresizingMaskIntoConstraints = NO;
//    roleLab.textColor=[UIColor blackColor];
//    roleLab.lineBreakMode=NSLineBreakByTruncatingTail;
//    roleLab.text=@"扮演";
//    roleLab.textColor=RGBBgNavColor;
//    roleLab.font=[UIFont systemFontOfSize:18];
//    [userView addSubview:roleLab];
//    
//    //扮演lab
//   // [view addConstraint:[NSLayoutConstraint constraintWithItem:roleLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:userView attribute:NSLayoutAttributeTop multiplier:1.0 constant:43]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:roleLab attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:userView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
//     [view addConstraint:[NSLayoutConstraint constraintWithItem:roleLab attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:userView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-10]];
//    //头像
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:avatarImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:userView attribute:NSLayoutAttributeTop multiplier:1.0 constant:15]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:avatarImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:roleLab attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-38]];
//     [view addConstraint:[NSLayoutConstraint constraintWithItem:avatarImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:avatarImage attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:avatarImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70]];
//    
//    //名字
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:nameLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:avatarImage attribute:NSLayoutAttributeBottom multiplier:1.0 constant:7]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:nameLab attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:avatarImage attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:nameLab attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90]];
//    
//    //头像
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:roleAvatarImage attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:userView attribute:NSLayoutAttributeTop multiplier:1.0 constant:15]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:roleAvatarImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:roleLab attribute:NSLayoutAttributeRight multiplier:1.0 constant:38]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:roleAvatarImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:roleAvatarImage attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:roleAvatarImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:70]];
//    
//    //名字
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:roleNameLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:roleAvatarImage attribute:NSLayoutAttributeBottom multiplier:1.0 constant:7]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:roleNameLab attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:roleAvatarImage attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
//    [view addConstraint:[NSLayoutConstraint constraintWithItem:roleNameLab attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:90]];
//    
//    
//    UIView *userLine=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(userView.frame)-1,  [TBActionSheet appearance].sheetWidth, 1)];
//    userLine.backgroundColor=RGBLineColor;
//    [userView addSubview:userLine];
//  
//    for (int i=0; i<arrTitle.count; i++)
//    {
//        
//        
//        UIButton *sexBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
//        sexBtn.frame=CGRectMake(0,CGRectGetMaxY(userView.frame)+50*i, [TBActionSheet appearance].sheetWidth, 50);
//        sexBtn.backgroundColor=[UIColor whiteColor];
//        sexBtn.tag=i;
//        [sexBtn setTitle:[arrTitle objectAtIndex:i] forState:UIControlStateNormal];
//        if(i==arrTitle.count-1)
//        {
//            [sexBtn setTitleColor:RGBACOLOR(255, 0, 0, 1) forState:UIControlStateNormal];
//        }else
//            
//        {
//            
//            [sexBtn setTitleColor:self.view.tintColor forState:UIControlStateNormal];
//        }
//        
//        [sexBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
//        [sexBtn addTarget:self action:@selector(clickTitleAction:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:sexBtn];
//        UIView *userLine=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(sexBtn.frame)-1,  [TBActionSheet appearance].sheetWidth, 1)];
//        userLine.backgroundColor=RGBLineColor;
//        [sexBtn addSubview:userLine];
//    }
//    
//    
//    
//    
//    return view;
//}
//-(BOOL)compareIsBlock:(int) uid
//
//{
//    
//    for ( BlockModel *blockId in self.m_blockListArr)
//    {
//        if ([blockId.m_blockUid intValue]==uid)
//        {
//            return YES;
//        }
//    }
//    return NO;
//}
//-(BOOL)compareIsForbid:(int)uid
//{
//
//    for ( ChatMemberListModel *forbid in ShareAppDelegate.m_ChatNumberPeople)
//    {
//        if ([forbid.m_id intValue]==uid)
//        {
//            if ( [forbid.m_isForbid intValue]==1) {
//                return YES;
//            }else
//            {
//                 return NO;
//            }
//            
//        }
//    }
//    return NO;
//}
//#pragma mark - 点击头像手势
//-(void)clickAvatar
//{
//    DLog(@"点击了头像");
//    [self.view resignFirstResponder];
//    [self.m_actionSheet removePopUpView];
//    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Friends" bundle:nil];
//    LookUserViewController * lookuser = [storyboard instantiateViewControllerWithIdentifier:@"LookUserViewController"];
//    lookuser.m_from = [NSString stringWithFormat:@"聊天室『%@』",[self readRoomName]];
//    lookuser.m_uid=self.m_userId;
//    [self.navigationController pushViewController:lookuser animated:YES];
//    
//    
//}
//#pragma mark - TBActionSheetDelegate
//
//- (void)actionSheet:(TBActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    m_push = NO;
//    NSLog(@"click button:%ld",(long)buttonIndex);
//    
//}
//-(void)clickTitleAction:(UIButton *)sender
//{
//      m_push = NO;
//    [self.m_actionSheet removePopUpView];
//    
//    
//    NSString *str= [self.m_arrTitle objectAtIndex:sender.tag];
//    if ([str isEqualToString:@"加好友"])
//    {
//        //申请添加好友
//        [self getNetFriendApply:[self.m_messageModel.message.ext objectForKey:K_uid]];
//        
//    }  else  if ([str isEqualToString:@"不看用户发言"])
//    {
//        //聊天室屏蔽用户
//        
//        [self getNetChatroomBlock: ShareAppDelegate.m_roomId mid:[self.m_messageModel.message.ext objectForKey:K_uid]name: [self.m_messageModel.message.ext objectForKey:K_nickname]];
//    }
//    else  if ([str isEqualToString:@"禁言"])
//    {
//         [self getNetTopicChatRoomSilenceUsersEid:ShareAppDelegate.m_roomId Mid:[self.m_messageModel.message.ext objectForKey:K_uid]];
//    }
//    else  if ([str isEqualToString:@"发起禁言投票"])
//    {
//        [self bannedVote];
//    }
//   
//}
//
//-(void)bannedVote
//{
//    UIAlertController * alert = [UIAlertController  alertControllerWithTitle:@"3人同意将禁言该用户1小时" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction * action = [UIAlertAction actionWithTitle:@"暴力色情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [self getNetChatroomTipoff: ShareAppDelegate.m_roomId mid:[self.m_messageModel.message.ext objectForKey:K_uid] reason:@"暴力色情"];
//        
//        action.enabled = NO;
//        
//    }];
//    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"人身攻击" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        
//        [self getNetChatroomTipoff: ShareAppDelegate.m_roomId mid:[self.m_messageModel.message.ext objectForKey:K_uid] reason:@"人身攻击"];
//        
//        action.enabled = NO;
//    }];
//    
//    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"广告骚扰" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [self getNetChatroomTipoff: ShareAppDelegate.m_roomId mid:[self.m_messageModel.message.ext objectForKey:K_uid] reason:@"广告骚扰"];
//        
//        action.enabled = NO;
//    }];
//    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"谣言及虚假消息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [self getNetChatroomTipoff: ShareAppDelegate.m_roomId mid:[self.m_messageModel.message.ext objectForKey:K_uid] reason:@"谣言及虚假消息"];
//        
//        action.enabled = NO;
//        
//    }];
//    UIAlertAction * action4 = [UIAlertAction actionWithTitle:@"政治敏感" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        
//        [self getNetChatroomTipoff: ShareAppDelegate.m_roomId mid:[self.m_messageModel.message.ext objectForKey:K_uid] reason:@"政治敏感"];
//        
//        action.enabled = NO;
//    }];
//    
//    UIAlertAction * action5 = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [self getNetChatroomTipoff: ShareAppDelegate.m_roomId mid:[self.m_messageModel.message.ext objectForKey:K_uid] reason:@"其他"];
//        
//        action.enabled = NO;
//    }];
//    
//    UIAlertAction * action6 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:action];
//    [alert addAction:action1];
//    [alert addAction:action2];
//    [alert addAction:action3];
//    [alert addAction:action4];
//    [alert addAction:action5];
//    [alert addAction:action6];
//    [self presentViewController:alert animated:YES completion:nil];
//}
//#pragma mark - 获取消息我自己自定义cell
///*!
// @method
// @brief 通知类型-一行字或多行字显示用到的
// @discussion 用户根据messageModel判断是否显示自定义cell,返回nil显示默认cell,否则显示用户自定义cell
// @param tableView 当前消息视图的tableView
// @param messageModel 消息模型
// @result 返回用户自定义cell
// */
//- (NoticeMessageTableViewCell *)messageNoticeViewController:(UITableView *)tableView
//                                        cellForMessageModel:(id<IMessageModel>)messageModel indexPath:(NSIndexPath *)indexPath
//{
//    // 加载Xib
//    
//    int noticeType=[[messageModel.message.ext safeObjectForKey:K_MESSAGE_CUSTOM_ISNOTICE]intValue];
//    if (noticeType==19||noticeType==100||noticeType==101||[[messageModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue]==8||[[messageModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue]==9)
//    {
//        static NSString * identifer1 = @"NoticeMessageTableViewCell";
//        UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
//        
//        [tableView registerNib:nib forCellReuseIdentifier:identifer1];
//        
//        NoticeMessageTableViewCell * customMessageCell = (NoticeMessageTableViewCell * )[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
//        customMessageCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [customMessageCell.m_bgView setBackgroundColor:RGBAssistColor];
//        customMessageCell.m_titleLab.textColor=[UIColor whiteColor];
//        customMessageCell.m_titleLab.tag = 555;
//        if ([[messageModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue]==8)
//        {
//            
//             customMessageCell.m_titleLab.text=@"创建人开启全体禁言";
//            
//        }else   if ([[messageModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue]==9)
//        {
//            
//            customMessageCell.m_titleLab.text=@"创建人解除全体禁言";
//            
//        }else
//        {
//          
//              NSString *body=  [messageModel.message.ext objectForKey:K_MESSAGE_NOTICE_ATTR_BODY];
//                body=[body replaceUnicode];
////            case 19:// 聊天室用户被禁言
//          
//            switch (noticeType)
//            {
//                
//                case 19:// 聊天室用户被禁言
//                {
//                    
//                    customMessageCell.m_titleLab.text=body;
//                }
//                 break;
//                case 100:// 您发起了对某个用户的禁言投票
//                {
//                    
//                    customMessageCell.m_titleLab.text=body;
//                }
//                      break;
//                case 101:// 您对某个用户的禁言
//                {
//                    
//                    customMessageCell.m_titleLab.text=body;
//                }
//                break;
//            }
//        }
//        
//        //高度计算公式
//        CGSize size = [customMessageCell.m_titleLab.text sizeWithGCFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT,MAXFLOAT)];
//        if(size.width>250)
//        {
//            size = [customMessageCell.m_titleLab.text sizeWithGCFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(250,MAXFLOAT)];
//        }
//        customMessageCell.m_labWidthConstraint.constant=size.width+20;
//       // DLog(@"size-----%@",NSStringFromCGSize(size));
//       
//
//        
//        
//        return customMessageCell;
//        
//    }else
//    {
//        return nil;
//    }
//    
//}
///*!
// @method
// @brief 举报是否同意有点击按钮
// @discussion 用户根据messageModel判断是否显示自定义cell,返回nil显示默认cell,否则显示用户自定义cell
// @param tableView 当前消息视图的tableView
// @param messageModel 消息模型
// @result 返回用户自定义cell
// */
//- (CustomMessageTableViewCell *)messageCustomViewController:(UITableView *)tableView
//                                        cellForMessageModel:(id<IMessageModel>)messageModel indexPath:(NSIndexPath *)indexPath
//{
//    // 加载Xib 18:// 聊天室举报用户
//   //DLog(@"CustomMessageTableViewCell=.ext%@",messageModel.message.ext);
//    if ([[messageModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_ISNOTICE] isNull])
//    {
//        static NSString * identifer1 = @"CustomMessageTableViewCell";
//        UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
//        
//        [tableView registerNib:nib forCellReuseIdentifier:identifer1];
//        
//        CustomMessageTableViewCell * customMessageCell = (CustomMessageTableViewCell * )[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
//        customMessageCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        customMessageCell.delegate=self;
//        customMessageCell.m_messageCellModel=messageModel;
//        [customMessageCell refreshData:ChatTypeC];
//        
//        
//        return customMessageCell;
//        
//    }else
//    {
//        return nil;
//    }
//    
//}
///*!
// @method
// @brief 分享群组
// @discussion 用户根据messageModel判断是否显示自定义cell,返回nil显示默认cell,否则显示用户自定义cell
// @param tableView 当前消息视图的tableView
// @param messageModel 消息模型
// @result 返回用户自定义cell
// */
//- (CustomShareTableViewCell *)shareCustomViewController:(UITableView *)tableView
//                                    cellForMessageModel:(id<IMessageModel>)messageModel indexPath:(NSIndexPath *)indexPath
//{
//    // 加载Xib
//   // DLog(@"CustomMessageTableViewCell=.ext%@",messageModel.message.ext);
//    if ([[messageModel.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue]==4)
//    {
//        static NSString * identifer1 = @"CustomShareTableViewCell";
//        UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
//        
//        [tableView registerNib:nib forCellReuseIdentifier:identifer1];
//        
//        CustomShareTableViewCell * customMessageCell = (CustomShareTableViewCell * )[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
//        customMessageCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        //        customMessageCell.delegate=self;
//        //        customMessageCell.m_messageCellModel=messageModel;
//        //        [customMessageCell refreshData:ChatTypeG];
//        [customMessageCell.m_avatarImageView sd_setImageWithURL:[NSURL URLWithString:[messageModel.message.ext safeObjectForKey:K_avatar]] placeholderImage:ImageNamed(K_avaterPHImage)];
//        
//        customMessageCell.m_titleLab.text=[NSString stringWithFormat:@"分享群名称:%@",[messageModel.message.ext safeObjectForKey:K_name]];
//        customMessageCell.m_contentLab.text=[messageModel.message.ext safeObjectForKey:k_msg];
//        return customMessageCell;
//        
//    }else
//    {
//        return nil;
//    }
//    
//}
//
///*!
// @method
// @brief 判断消息自定义
// @discussion
// @param viewController 当前消息视图
// @param message 要发送已读回执的message
// @param messageModel 消息模型
// @result
// */
//- (BOOL)isCustomMessageFormessageViewController:(EaseMessageViewController *)viewController
//                                   messageModel:(id<IMessageModel>)messageModel indexPath:(NSIndexPath *)indexPath
//{
//    BOOL flag = NO;
//// DLog(@"BOOL=.ext%@",messageModel.message.ext);
//    if ([[messageModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_ISNOTICE] isNull])
//    {
//        flag= YES;
//    }
//   
//
//    return flag;
//}
///*!
// @method
// @brief 判断消息自定义
// @discussion
// @param viewController 当前消息视图
// @param message 要发送已读回执的message
// @param messageModel 消息模型
// @result
// */
//- (CGFloat)isNoticeMessageFormessageViewController:(EaseMessageViewController *)viewController
//                                   messageModel:(id<IMessageModel>)messageModel indexPath:(NSIndexPath *)indexPath
//{
//   
//    int noticeType=[[messageModel.message.ext safeObjectForKey:K_MESSAGE_CUSTOM_ISNOTICE]intValue];
//    if (noticeType==19||noticeType==100||noticeType==101||[[messageModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue]==8||[[messageModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue]==9)
//    {
//       
//            NSString *bodyStr;
//            if ([[messageModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue]==8)
//            {
//                
//               bodyStr=@"创建人开启全体禁言";
//                
//            }else   if ([[messageModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue]==9)
//            {
//                
//                bodyStr=@"创建人解除全体禁言";
//                
//            }else
//            {
//                //            NSDictionary *dic=[messageModel.message.ext objectForKey:K_MESSAGE_NOTICE_ATTR_DATA];
//                NSString *body=  [messageModel.message.ext objectForKey:K_MESSAGE_NOTICE_ATTR_BODY];
//                
//                //            case 19:// 聊天室用户被禁言
//                 body=[body replaceUnicode];
//                switch (noticeType)
//                {
//                        
//                    case 19:// 聊天室用户被禁言
//                    {
//                        
//                       bodyStr=body;
//                    }
//                        break;
//                    case 100:// 您发起了对某个用户的禁言投票
//                    {
//                        
//                        bodyStr=body;
//                    }
//                        break;
//                    case 101:// 您对某个用户的禁言
//                    {
//                        
//                        bodyStr=body;
//                    }
//                        break;
//                }
//            }
//    
//   
//    
//  
//        if (messageModel.cellHeight>0)
//        {
//           return messageModel.cellHeight;
//        }else
//        {
//            //高度计算公式
//            CGSize size = [bodyStr sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT,MAXFLOAT)];
//            if(size.width>250)
//            {
//                size =  [bodyStr sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(250,MAXFLOAT)];
//            }
//            messageModel.cellHeight=size.height+50;
//            //DLog(@"size-----%@",NSStringFromCGSize(size));
//           return messageModel.cellHeight;
//        }
//    }else
//    {
//        return 0;
//    }
//
//}
//#pragma mark - 自定义cell CustomMessageTableViewCellDelegate
///**
// *  不同意 */
//
//-(void)clickDisagree:(id<IMessageModel>)messageModel
//{
//    DLog(@"不同意");
//    [self updateTipoff:messageModel agree:NO];
//    
//    
//}
//- (EMChatType)_messageTypeFromConversationType
//{
//    EMChatType type = EMChatTypeChat;
//    switch (self.conversation.type) {
//        case EMConversationTypeChat:
//            type = EMChatTypeChat;
//            break;
//        case EMConversationTypeGroupChat:
//            type = EMChatTypeGroupChat;
//            break;
//        case EMConversationTypeChatRoom:
//            type = EMChatTypeChatRoom;
//            break;
//        default:
//            break;
//    }
//    return type;
//}
///**
// *  同意
// */
//-(void)clickAgree:(id<IMessageModel>)messageModel
//{
//    DLog(@"同意");
//    NSDictionary *dic=[messageModel.message.ext objectForKey:K_MESSAGE_NOTICE_ATTR_DATA];
//    [self getNetGroupAgreeGag:[dic safeObjectForKey:@"tipoff_id"]message:messageModel ];
//    
//}
//#pragma mark -网络请求
///**
// *  聊天室同意举报用户
// *
// *  @param tipoffId 举报记录id
// *
// *  @return
// */
//- (void)getNetGroupAgreeGag:(NSString *)fuid message:(id<IMessageModel>)messageModel
//{
//    NSDictionary *info =[URLPath getNetChatroomAgreetipoffP:fuid];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//    __weak ChatViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData) {
//        
//        
//        DLog(@"成功--pid-%@",respostData);
//        int rs=[[respostData safeObjectForKey:K_rs] intValue];
//        if (rs==1)
//        {
//            
//            [weakSelf updateTipoff:messageModel agree:YES];
//            [SVProgressHUD showSuccessWithStatus:[respostData objectForKey:k_msg]];
//        }else
//        {
//            [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//        }
//        
//    } failed:^(NSString *errorMsg)
//     
//     {
//        [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
//         
//     }];
//}
///**
// *  更新举报数据
// *
// *  @param messageModel 
// *  @param isAgree 是否同意 1同意  2拒绝
// */
//-(void)updateTipoff:(id<IMessageModel>)messageModel agree:(BOOL) isAgree
//{
//    NSDictionary *dic;
//    if (isAgree) {
//       dic= [[NSDictionary alloc] initWithObjectsAndKeys:
//         
//         @"1",K_MESSAGE_ATTR_ISNOTICE,
//         @"1",K_MESSAGE_NOTICE_ATTR_ISDEAL,
//         [messageModel.message.ext objectForKey:K_MESSAGE_NOTICE_ATTR_DATA],K_MESSAGE_NOTICE_ATTR_DATA,
//              [messageModel.message.ext objectForKey:K_MESSAGE_NOTICE_ATTR_BODY],K_MESSAGE_NOTICE_ATTR_BODY,
//         nil];
//    }else
//    {
//        dic= [[NSDictionary alloc] initWithObjectsAndKeys:
//              
//              @"1",K_MESSAGE_ATTR_ISNOTICE,
//              @"2",K_MESSAGE_NOTICE_ATTR_ISDEAL,
//              [messageModel.message.ext objectForKey:K_MESSAGE_NOTICE_ATTR_DATA],K_MESSAGE_NOTICE_ATTR_DATA,
//               [messageModel.message.ext objectForKey:K_MESSAGE_NOTICE_ATTR_BODY],K_MESSAGE_NOTICE_ATTR_BODY,
//              nil];
//    }
//    
//    messageModel.message.ext =dic;
//    // 更新消息
//    BOOL bo=  [[EMClient sharedClient].chatManager updateMessage:messageModel.message];
//    
//    DLog(@"更新消息===%i",bo);
//    [ self.dataArray replaceObjectAtIndex:messageModel.m_indexPath.row withObject:messageModel];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//        [self.tableView reloadData];
////        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArray count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    });
//
//}
///**
// * 申请添加好友
// */
//- (void)getNetFriendApply:(NSString *)fuid
//{
//   
//    
//    NSString * str;
//    if ([self readRoomName] != nil) {
//        
//        if ( self.m_chatRoomType ==ChatRoomTypeRolePlay) {
//         
//             str = [NSString stringWithFormat:@"聊天室『%@』",[self readRoomName]];
//        }
//    }
//     NSDictionary *info =[URLPath getNetAddFriendfuidP:fuid extra:nil from:str];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//    __weak ChatViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData) {
//        
//        
//        DLog(@"成功--pid-%@",respostData);
//        int rs=[[respostData safeObjectForKey:K_rs] intValue];
//        if (rs==1)
//        {
//            //提示框
//            UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"已发送好友申请" preferredStyle:UIAlertControllerStyleAlert];
//            //上面控制提示框的内容和标题
//            //下面控制提示框的按钮动作
//            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//            //将内容标题加上动作 cancel
//            [alert addAction:cancel];
//            //然后在视图上显示提示框
//            [weakSelf presentViewController:alert animated:YES completion:nil];
//
//        }else
//        {
//            [weakSelf showHint:[respostData objectForKey:k_msg]];
//        }
//
//    } failed:^(NSString *errorMsg)
//     
//     {
//        [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
//         
//     }];
//}
///**
// *  聊天室屏蔽用户
// *
// *  @param roomId 聊天室id
// *  @param mid    被屏蔽成员
// *
// */
//- (void)getNetChatroomBlock:(NSString *)roomId mid:(NSString *)mid name:(NSString *)name
//{
//         [SVProgressHUD show];
//    NSDictionary *info =[URLPath getNetChatroomBlockP:roomId mid:mid];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//    __weak ChatViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData) {
//        
//        
//        DLog(@"成功--pid-%@",respostData);
//        int rs=[[respostData safeObjectForKey:K_rs] intValue];
//        if (rs==1)
//        {
//            BlockModel *blockModel=[[BlockModel alloc]init];
//            //这样写是避免后面会当nsstring 类型去比较是否相同  就会崩溃
//            int a = [[respostData objectForKey:K_data] intValue];
//            blockModel.m_blockUid = [NSString stringWithFormat:@"%i",a];
//            [weakSelf.m_blockListArr addObject:blockModel];
//            NSString *message=[NSString stringWithFormat:@"已经屏蔽 %@ 的发言，可在成员列表中取消屏蔽",name];
//            [DTools alertController:weakSelf title:nil message:message handler:^(UIAlertAction *action) {
//                
//            }];
//            [SVProgressHUD dismiss];
//        }else
//        {
//        
//            [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//        }
//        
//    } failed:^(NSString *errorMsg)
//     
//     {
//        [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
//         
//     }];
//}
///**
// *  聊天室举报用户
// *
// *  @param roomId 聊天室id
// *  @param mid    被举报人id
// *
// */
//-(void )getNetChatroomTipoff:(NSString *)roomId mid:(NSString *)mid reason:(NSString *)reason
//{
//         [SVProgressHUD show];
//    NSDictionary *info =[URLPath getNetChatroomTipoffP:roomId mid:mid reason:reason];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//    __weak ChatViewController *weakSelf = self;
//    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData) {
//        
//        
//        DLog(@"成功--pid-%@",respostData);
//        int rs=[[respostData safeObjectForKey:K_rs] intValue];
//  
//        if (rs==1)
//        {
//            NSDictionary *data=[respostData objectForKey:K_data];
//            NSString *bodyStr=[NSString stringWithFormat:@"你发起了对用户 %@ 举报，30分钟内%@人同意将禁言该用户一个小时",[data objectForKey:@"to_username"],[data objectForKey:@"need_num"]];
//            NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:
//                               
//                               @"100",K_MESSAGE_CUSTOM_ISNOTICE,
//                               bodyStr,K_MESSAGE_NOTICE_ATTR_BODY,
//                               data,K_MESSAGE_NOTICE_ATTR_DATA,
//                               nil];
//            
//            EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:@"聊天室举报"];
//            NSString *from = [[EMClient sharedClient] currentUsername];
//            
//            //生成Message
//            EMMessage *message = [[EMMessage alloc] initWithConversationID:self.conversation.conversationId from:from to:self.conversation.conversationId body:body ext:dic];
//            message.chatType = EMChatTypeChatRoom;// 设置为单聊消息
//            //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
//            //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
//           
//                [weakSelf addMessageToDataSource:message progress:nil];
//                
//            // 保存消息
//            BOOL bo=  [[EMClient sharedClient].chatManager importMessages:@[message]];
//            
//            DLog(@"保存消息===%i",bo);
//        
//            [SVProgressHUD dismiss];
//
//        }else
//        {
//            [SVProgressHUD dismiss];
//            [DTools alertController:weakSelf title:nil message:[respostData objectForKey:k_msg] handler:^(UIAlertAction *action) {
//                
//            }];
//        }
//
//        
//    } failed:^(NSString *errorMsg)
//     
//     {
//         [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
//         
//     }];
//}
///**
// *  获取要进入的聊天室信息
// *
// *  @param lng  经度
// *  @param lat  纬度
// *  @param addr 地址
// *
// *
// */
//-(void )getNetRequestChatRoomEnterlng:(NSString *)lng lat:(NSString *)lat addr:(NSString *)addr
//{
//
//    NSDictionary *info =[URLPath getNetRequestChatRoomEnterlngG:lng lat:lat addr:addr];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//        __weak ChatViewController *weakSelf = self;
//    [[AFHTTPClient share] getMethod:url param:param success:^(NSDictionary *respostData) {
//        
//        
//        DLog(@"成功--pid-%@",respostData);
//        int rs=[[respostData safeObjectForKey:K_rs] intValue];
//       
//         NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//        if (rs==1)
//        {
//           
//            //服务器分配给用户的房间号
//            //[accountDefaults setObject:[respostData objectForKey:k_room_id] forKey:k_room_id];
//            //房间name
//            [weakSelf strongRoomName:[respostData objectForKey:K_roomName]];
//
//         
//             ShareAppDelegate.m_roomId=[respostData objectForKey:k_room_id];
//            [accountDefaults setObject:@"native" forKey:k_roomPoto];
//          
//           
//            weakSelf.m_groupForbidModel=[GroupForbidModel mj_objectWithKeyValues:[respostData objectForKey:@"forbid_info"]];
//            NSDate* theDate=[[XSDTimeCalibration share] getCurrentTimeAddSinceNow:[weakSelf.m_groupForbidModel.m_remainTime  floatValue]];
//            weakSelf.m_groupForbidModel.m_endTime=theDate;
//            NSMutableArray *arr=[respostData objectForKey:@"block_list"];
//            NSMutableArray *arr2=[ BlockModel mj_objectArrayWithKeyValuesArray:arr];
//            [weakSelf.m_blockListArr removeAllObjects];
//            [weakSelf.m_blockListArr addObjectsFromArray:arr2];
//           
//            [ShareAppDelegate.m_ChatNumberPeople removeAllObjects];
//            [ShareAppDelegate.m_ChatNumberPeople addObjectsFromArray:[ChatMemberListModel mj_objectArrayWithKeyValuesArray:[respostData objectForKey:@"member_list"]]];
//          
////            ImageNamed(@"native");
//
//            //判断自己在不在 不在就把自己加上
//            NSString * userID = [self giveMeUid];
//            for (int i = 0; i <ShareAppDelegate.m_ChatNumberPeople.count ; i ++) {
//                ChatMemberListModel * model = ShareAppDelegate.m_ChatNumberPeople[i];
//                if ([model.m_id integerValue] == [userID integerValue]) {
//                    break;
//                }else if (i == ShareAppDelegate.m_ChatNumberPeople.count -1){
//                    
//                    ChatMemberListModel * model = [[ChatMemberListModel alloc]init];
//                    RegisteredUser *regist= [DPlistSave readUserData];
//                    model.m_id = regist.m_id;
//                    model.m_avatar = regist.m_avatar;
//                    model.m_nickname = regist.m_nickname;
//                    model.m_easeUname = regist.m_uname;
//                    model.m_endDate=weakSelf.m_groupForbidModel.m_endTime;
//                    model.m_isForbid=weakSelf.m_groupForbidModel.m_isforbid;
//                    model.m_remainTime=[weakSelf.m_groupForbidModel.m_remainTime floatValue];
//                    [ShareAppDelegate.m_ChatNumberPeople addObject:model];
//                }
//            }
//            
//            if (ShareAppDelegate.m_ChatNumberPeople.count == 0) {
//                ChatMemberListModel * model = [[ChatMemberListModel alloc]init];
//                RegisteredUser *regist= [DPlistSave readUserData];
//                model.m_id = regist.m_id;
//                model.m_avatar = regist.m_avatar;
//                model.m_nickname = regist.m_nickname;
//                model.m_easeUname = regist.m_uname;
//                model.m_endDate=weakSelf.m_groupForbidModel.m_endTime;
//                model.m_isForbid=weakSelf.m_groupForbidModel.m_isforbid;
//                model.m_remainTime=[weakSelf.m_groupForbidModel.m_remainTime floatValue];
//                [ShareAppDelegate.m_ChatNumberPeople addObject:model];
//            }
//            
//            /**
//             *  刷新聊天框上面的头像
//             */
//            [[NSNotificationCenter defaultCenter]postNotificationName:K_PEOPLEPHOTORELOATDATA object:nil];
//            
//
//            [weakSelf initData];
//            [super viewDidLoad];
//            [weakSelf initSetNav];
//
//        }else
//        {
//            //有网加入失败
//            [weakSelf initSetNav];
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"加入聊天室失败,是否重新加入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
//            DLog(@"%@",[respostData objectForKey:k_msg]);
////            return;
//        }
//        
//        
//    } failed:^(NSString *errorMsg)
//     
//     {
//       //没网
//         
//         [weakSelf initSetNav];
//         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"加入聊天室失败,是否重新加入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                 [alert show];
//         DLog(@"%@",K_ErrorMsg);
//
//         
//     }];
//}
//
//
//
//
///**
// *  得到聊天室信息
// *
// *  @param roomId 环信聊天室ID
// *
// *
// */
//-(void )getNetChatroomInfo:(NSString *)roomId
//{
//    NSDictionary *info =[URLPath getNetChatroomInfoG:roomId];
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//    __weak ChatViewController *weakSelf = self;
//    [[AFHTTPClient share] getMethod:url param:param success:^(NSDictionary *respostData) {
//        
//        
//        DLog(@"成功--pid-%@",respostData);
//        int rs=[[respostData safeObjectForKey:K_rs] intValue];
//        
//        if (rs==1)
//        {
//            
//            if (weakSelf.m_chatRoomType ==ChatRoomTypeRolePlay)
//            {
////
//                
//                weakSelf.m_groupForbidModel=[GroupForbidModel mj_objectWithKeyValues:[respostData objectForKey:@"forbid_info"]];
//                NSDate* theDate=[[XSDTimeCalibration share] getCurrentTimeAddSinceNow:[weakSelf.m_groupForbidModel.m_remainTime  floatValue]];
//                weakSelf.m_groupForbidModel.m_endTime=theDate;
//                NSMutableArray *arr=[respostData objectForKey:@"block_list"];
//                NSMutableArray *arr2=[ BlockModel mj_objectArrayWithKeyValuesArray:arr];
//                [ShareAppDelegate.m_ChatNumberPeople removeAllObjects];
//                [ShareAppDelegate.m_ChatNumberPeople addObjectsFromArray:[ChatMemberListModel mj_objectArrayWithKeyValuesArray:[respostData objectForKey:@"member_list"]]];
//                NSString *remainTime=[respostData objectForKey:@"remain_time"];//剩余的秒数
//                weakSelf.m_remainTime =remainTime;
//                [weakSelf startCompareTime];
//                m_net = YES;//执行了网络请求  当返回视图时ViewWillAper就可以执行Star了
//                //进入后台用
//                NSDate* newsDate=[[XSDTimeCalibration share] getCurrentTimeAddSinceNow:[remainTime floatValue]];
//                NSUserDefaults *newsTime=[NSUserDefaults standardUserDefaults];
//                 [newsTime setObject:newsDate forKey:K_NewsEndTime];
//                if (weakSelf.m_chatRoomType==ChatRoomTypeRolePlay) {
//                     [newsTime setObject:newsDate forKey:K_RoleEndTime];
//                }
//               
//                
//                 NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//                
//                  if (weakSelf.m_chatRoomType==ChatRoomTypeRolePlay) {
//                      
//    weakSelf.m_shareGroupOrChatRoom.m_title = [NSString stringWithFormat:@"我在[%@]聊天室当主演，快来和我演对手戏啊。剧组帅哥、美女、盒饭管够！",[weakSelf readRoomName]];//分享标题
//       weakSelf.m_shareGroupOrChatRoom.m_shareUrl = [NSString stringWithFormat:@"http://chat.leiyu.tv/index.php?ac=share&op=role&id=%@",self.m_RoleDataID];//分享出去的网址
//                        AnswerModel * model =[ShareAppDelegate.m_ActorsAuditio safeObjectForKey:ShareAppDelegate.m_roomId];
//                      NSLog(@"%@ ----- dic %@",ShareAppDelegate.m_roomId,ShareAppDelegate.m_ActorsAuditio);
//                      //分享角色扮演聊天室的头像  用的是自己选择角色的头像
//                      weakSelf.m_shareGroupOrChatRoom.m_img = model.m_rolemodel.m_avatar;//分享出去头像
//                  }else{
//    weakSelf.m_shareGroupOrChatRoom.m_title = [NSString stringWithFormat:@"我加入了聊天室『%@』，快来【言言】，一起聊啊！",[weakSelf readRoomName]];//分享标题
//    weakSelf.m_shareGroupOrChatRoom.m_shareUrl = [NSString stringWithFormat:@"http://chat.leiyu.tv/index.php?ac=share&op=topic&id=%@",[respostData objectForKey:@"id"]];//分享出去的网址
//                //聊天广场获取不到头像
//                weakSelf.m_shareGroupOrChatRoom.m_img     =   [accountDefaults objectForKey:k_roomPoto];//分享出去头像
//                  }
//                
//                NSLog(@"%@", weakSelf.m_shareGroupOrChatRoom.m_shareUrl);
//                //聊天广场没有副标题
//                weakSelf.m_shareGroupOrChatRoom.m_summary = @"我发现个很有趣的聊天app——言言，这里有话题与新闻聊天室，快来一起聊！";//副标题
//                
//                
//                //判断自己在不在 不在就把自己加上
//                NSString * userID = [weakSelf giveMeUid];
//                for (int i = 0; i <ShareAppDelegate.m_ChatNumberPeople.count ; i ++) {
//                    ChatMemberListModel * model = ShareAppDelegate.m_ChatNumberPeople[i];
//                    if ([model.m_id integerValue] == [userID integerValue]) {
//                        break;
//                    }else if (i == ShareAppDelegate.m_ChatNumberPeople.count -1){
//                        
//                        ChatMemberListModel * model = [[ChatMemberListModel alloc]init];
//                        RegisteredUser *regist= [DPlistSave readUserData];
//                        model.m_id = regist.m_id;
//                        model.m_avatar = regist.m_avatar;
//                        model.m_nickname = regist.m_nickname;
//                        model.m_easeUname = regist.m_uname;
//                        model.m_gender = regist.m_gender;
//                        NSDictionary * dic = [respostData objectForKey:@"forbid_info"];
//                        model.m_endDate=[[XSDTimeCalibration share] getCurrentTimeAddSinceNow:[[dic objectForKey:@"remain_time"] floatValue]];
//                        model.m_isForbid=[dic objectForKey:@"is_forbid"];
//                         model.m_remainTime=[weakSelf.m_groupForbidModel.m_remainTime floatValue];
//                        
//                        if (weakSelf.m_chatRoomType ==ChatRoomTypeRolePlay)
//                        {
//                        AnswerModel * ansmodel =[ShareAppDelegate.m_ActorsAuditio safeObjectForKey:ShareAppDelegate.m_roomId];
//                            model.m_roleNmuber = [ansmodel.m_rolemodel.m_roleNumber intValue];//编号
//                            model.m_Rolename = ansmodel.m_rolemodel.m_rname;//名字
//                            model.m_Roleavatar = ansmodel.m_rolemodel.m_avatar;//头像
//                        }
//                        
//                        [ShareAppDelegate.m_ChatNumberPeople addObject:model];
//                    }
//                }
//                if (ShareAppDelegate.m_ChatNumberPeople.count == 0) {
//                    ChatMemberListModel * model = [[ChatMemberListModel alloc]init];
//                    RegisteredUser *regist= [DPlistSave readUserData];
//                    model.m_id = regist.m_id;
//                    model.m_avatar = regist.m_avatar;
//                    model.m_nickname = regist.m_nickname;
//                    model.m_easeUname = regist.m_uname;
//                    model.m_gender = regist.m_gender;
//                    NSDictionary * dic = [respostData objectForKey:@"forbid_info"];
//                    model.m_endDate=[[XSDTimeCalibration share] getCurrentTimeAddSinceNow:[[dic objectForKey:@"remain_time"] floatValue]];
//                    
//                    model.m_isForbid=[dic objectForKey:@"is_forbid"];
//                     model.m_remainTime=[weakSelf.m_groupForbidModel.m_remainTime floatValue];
//                    
//                    if (weakSelf.m_chatRoomType ==ChatRoomTypeRolePlay)
//                    {
//                        AnswerModel * ansmodel =[ShareAppDelegate.m_ActorsAuditio safeObjectForKey:ShareAppDelegate.m_roomId];
//                        model.m_roleNmuber = [ansmodel.m_rolemodel.m_roleNumber intValue];//编号
//                        model.m_Rolename = ansmodel.m_rolemodel.m_rname;//名字
//                        model.m_Roleavatar = ansmodel.m_rolemodel.m_avatar;//头像
//                    }
//                    
//
//                    
//                    [ShareAppDelegate.m_ChatNumberPeople addObject:model];
//                }
//                
//            
//                /**
//                 *  刷新聊天框上面的头像
//                 */
//                [[NSNotificationCenter defaultCenter]postNotificationName:K_PEOPLEPHOTORELOATDATA object:nil];
//                [weakSelf.m_blockListArr removeAllObjects];
//                [weakSelf.m_blockListArr addObjectsFromArray:arr2];
//                
//              
//            }
//            
//          
//            
//            [weakSelf initData];
//            [super viewDidLoad];
//            [weakSelf initSetNav];
//            
//
//        }else
//        {
// 
//            [weakSelf initSetNav];
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"加入聊天室失败,是否重新加入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alert show];
//            DLog(@"%@",[respostData objectForKey:k_msg]);
//            //            return;
//        }
//        
//        
//    } failed:^(NSString *errorMsg)
//     
//     {
//         
//         
//         [weakSelf initSetNav];
//         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"加入聊天室失败,是否重新加入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//         [alert show];
//         DLog(@"%@",K_ErrorMsg);
//
//         
//     }];
//}
//
//
//
///**
// *  话题聊天室创建人直接禁言某个用户：
// *
// *  @param eid 环信聊天室ID
// *  @param mid 被禁言用户ID
// */
//
//-(void )getNetTopicChatRoomSilenceUsersEid:(NSString *)eid Mid:(NSString *)mid
//{
//   
//        NSDictionary * info =[URLPath getNetTopicChatRoomSilenceUsersEid:eid Mid:mid];
//   
//    
//    NSString *url = [info objectForKey:K_URL];
//    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
//    
//    __weak ChatViewController *weakSelf = self;
//    [[AFHTTPClient share] getMethod:url param:param success:^(NSDictionary *respostData) {
//        
//        
//        DLog(@"成功--pid-%@",respostData);
//        int rs=[[respostData safeObjectForKey:K_rs] intValue];
//        
//        if (rs==1)
//        {
//            
//            
//            NSDictionary *data=[respostData objectForKey:K_data];
//            NSString *bodyStr=[NSString stringWithFormat:@"您对 %@ 禁言1小时",[data objectForKey:@"to_nickname"]];
//            NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:
//                               
//                               @"101",K_MESSAGE_CUSTOM_ISNOTICE,
//                               bodyStr,K_MESSAGE_NOTICE_ATTR_BODY,
//                               data,K_MESSAGE_NOTICE_ATTR_DATA,
//                               nil];
//            
//            // DLog(@"message.ext%@",message.ext);//@"聊天室举报 101"
//            EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:bodyStr];
//            NSString *from = [[EMClient sharedClient] currentUsername];
//            
//            //生成Message
//            EMMessage *message = [[EMMessage alloc] initWithConversationID:self.conversation.conversationId from:from to:self.conversation.conversationId body:body ext:dic];
//            message.chatType = EMChatTypeChatRoom;// 设置为单聊消息
//            //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
//            //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
//            
//            [weakSelf addMessageToDataSource:message progress:nil];
//            
//            // 保存消息
//            BOOL bo=  [[EMClient sharedClient].chatManager importMessages:@[message]];
//            
////            DLog(@"保存消息===%i",bo);
//
//           
//    
//            DLog(@"%@",ShareAppDelegate.m_ChatNumberPeople);
//            //添加结束时间
//            for (int i = 0; i <ShareAppDelegate.m_ChatNumberPeople.count ; i ++) {
//                ChatMemberListModel * model = ShareAppDelegate.m_ChatNumberPeople[i];
//                if ([model.m_id intValue]==[mid intValue])
//                {
//                    model.m_isForbid=@"1";
//                    NSDate* theDate=[[XSDTimeCalibration share] getCurrentTimeAddSinceNow:k_forbidTime];
//                    //
//                    //取两个日期对象的时间间隔：
//                    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
//                    //                    NSTimeInterval cha=[theDate timeIntervalSinceDate:currentDate];
//                    model.m_endDate=theDate;
//                    [ShareAppDelegate.m_ChatNumberPeople replaceObjectAtIndex:i withObject:model];
//                }
//                
//                
//            }
//            
//        }else
//        {
//            
//            DLog(@"%@",[respostData objectForKey:k_msg]);
//            [DTools alertController:weakSelf title:nil message:[respostData objectForKey:k_msg] handler:^(UIAlertAction *action) {
//                
//            }];
//        }
//        
//        
//    } failed:^(NSString *errorMsg)
//     
//     {
//         
//         
//                  DLog(@"%@",K_ErrorMsg);
//
//         
//     }];
//}
//
//
//#pragma mark - EMClientDelegate
//
//- (void)didLoginFromOtherDevice
//{
//    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
//        [self.imagePicker stopVideoCapture];
//    }
//}
//
//- (void)didRemovedFromServer
//{
//    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
//        [self.imagePicker stopVideoCapture];
//    }
//}
//
//#pragma mark - action
////
////- (void)backAction
////{
////    [[EMClient sharedClient].chatManager removeDelegate:self];
////    [[EMClient sharedClient].roomManager removeDelegate:self];
////    [[ChatDemoHelper shareHelper] setChatVC:nil];
////    
////    if (self.deleteConversationIfNull) {
////        //判断当前会话是否为空，若符合则删除该会话
////        EMMessage *message = [self.conversation latestMessage];
////        if (message == nil) {
////            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId deleteMessages:NO];
////        }
////    }
////    
////    [self.navigationController popViewControllerAnimated:YES];
////}
//
////- (void)showGroupDetailAction
////{
////    [self.view endEditing:YES];
////    if (self.conversation.type == EMConversationTypeGroupChat) {
////        ChatGroupDetailViewController *detailController = [[ChatGroupDetailViewController alloc] initWithGroupId:self.conversation.conversationId];
////        [self.navigationController pushViewController:detailController animated:YES];
////    }
////    else if (self.conversation.type == EMConversationTypeChatRoom)
////    {
////        ChatroomDetailViewController *detailController = [[ChatroomDetailViewController alloc] initWithChatroomId:self.conversation.conversationId];
////        [self.navigationController pushViewController:detailController animated:YES];
////    }
////}
//
//- (void)deleteAllMessages:(id)sender
//{
//    if (self.dataArray.count == 0) {
//        [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
//        return;
//    }
//    
//    if ([sender isKindOfClass:[NSNotification class]]) {
//        NSString *groupId = (NSString *)[(NSNotification *)sender object];
//        BOOL isDelete = [groupId isEqualToString:self.conversation.conversationId];
//        if (self.conversation.type != EMConversationTypeChat && isDelete) {
//            self.messageTimeIntervalTag = -1;
//            [self.conversation deleteAllMessages];
//            [self.messsagesSource removeAllObjects];
//            [self.dataArray removeAllObjects];
//            
//            [self.tableView reloadData];
//            [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
//        }
//    }
//    
//    else if ([sender isKindOfClass:[UIButton class]]){
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"sureToDelete", @"please make sure to delete") delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
//        [alertView show];
//    }
//}
////
////- (void)transpondMenuAction:(id)sender
////{
////    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
////        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
////        ContactListSelectViewController *listViewController = [[ContactListSelectViewController alloc] initWithNibName:nil bundle:nil];
////        listViewController.messageModel = model;
////        [listViewController tableViewDidTriggerHeaderRefresh];
////        [self.navigationController pushViewController:listViewController animated:YES];
////    }
////    self.menuIndexPath = nil;
////}
//
//- (void)copyMenuAction:(id)sender
//{
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
//        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
//        pasteboard.string = model.text;
//    }
//    
//    self.menuIndexPath = nil;
//}
//
//- (void)deleteMenuAction:(id)sender
//{
//    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
//        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
//        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:self.menuIndexPath.row];
//        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:self.menuIndexPath, nil];
//        
//        [self.conversation deleteMessageWithId:model.message.messageId];
//        [self.messsagesSource removeObject:model.message];
//        
//        if (self.menuIndexPath.row - 1 >= 0) {
//            id nextMessage = nil;
//            id prevMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row - 1)];
//            if (self.menuIndexPath.row + 1 < [self.dataArray count]) {
//                nextMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row + 1)];
//            }
//            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
//                [indexs addIndex:self.menuIndexPath.row - 1];
//                [indexPaths addObject:[NSIndexPath indexPathForRow:(self.menuIndexPath.row - 1) inSection:0]];
//            }
//        }
//        
//        [self.dataArray removeObjectsAtIndexes:indexs];
//        [self.tableView beginUpdates];
//        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
//        [self.tableView endUpdates];
//        
//        if ([self.dataArray count] == 0) {
//            self.messageTimeIntervalTag = -1;
//        }
//    }
//    
//    self.menuIndexPath = nil;
//}
//
//#pragma mark - notification
//- (void)exitGroup
//{
//    [self.navigationController popToViewController:self animated:NO];
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//- (void)insertCallMessage:(NSNotification *)notification
//{
//    id object = notification.object;
//    if (object) {
//        EMMessage *message = (EMMessage *)object;
//        [self addMessageToDataSource:message progress:nil];
//        [[EMClient sharedClient].chatManager importMessages:@[message]];
//    }
//}
//
//- (void)handleCallNotification:(NSNotification *)notification
//{
//    id object = notification.object;
//    if ([object isKindOfClass:[NSDictionary class]]) {
//        //开始call
//        self.isViewDidAppear = NO;
//    } else {
//        //结束call
//        self.isViewDidAppear = YES;
//    }
//}
//
//#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex)
//    {
//        case 0:
//        {
//          
//            [ShareAppDelegate.m_chatRoomDict removeObjectForKey:K_CHAT_ROOM_KEY];
//            [[WaitingFigureView shareInstance]dissMessView];
//            [self.navigationController popViewControllerAnimated:NO];
//        }
//            break;
//        case 1:
////            [[NSNotificationCenter defaultCenter]postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
//            
//            
//            [self.navigationController popViewControllerAnimated:NO];
//            if (self.isMessageJoin)
//            {
//                  [[NSNotificationCenter defaultCenter]postNotificationName:K_RELOAD_CONTROLLER_MESSAGE object:nil];
//            }else
//            {
//                if ( self.m_chatRoomType ==ChatRoomTypeRolePlay)
//                {
//                    //发送重新加载页面通知
//                
//                    
//                    [[NSNotificationCenter defaultCenter]postNotificationName:K_RELOAD_CONTROLLER_SQUARE object:self.m_listModel];
//                }
//                
//
//            
//            }
//            
//            
//            
//            
//            break;
//        default:
//            break;
//    }
//}
//
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark  -- 监控键盘方法
//
////键盘出现
//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    
//  
//   
//    
//}
//
////键盘消失
//-(void)keyboardWillBeHidden:(NSNotification*)aNotification
//{
//   
//    
//}
//
//
//
//
//#pragma mark - GestureRecognizer
//
////// 点击背景隐藏
////-(void)keyBoardHidden:(UITapGestureRecognizer *)tapRecognizer
////{
////    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
////        [self.chatToolbar endEditing:YES];
////    }
////}
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//
//
//
//
//
//#pragma mark -- TopicTimeViewInit
//
//-(void)initViewTopicTimeView
//{
//    
//    self.m_topicTimeView = [[UIView alloc] initWithFrame:CGRectMake(0,-50, LCDW, 50)];
//    self.m_topicTimeView.backgroundColor = RGBACOLOR(255,184,44,1);
//    //创建标题
//    self.m_title=[[UILabel alloc] initWithFrame:self.m_topicTimeView.bounds];
//    self.m_title.backgroundColor=[UIColor clearColor];
//    self.m_title.font = [UIFont systemFontOfSize:17];
//    self.m_title.textColor = [UIColor whiteColor];
//    self.m_title.textAlignment = NSTextAlignmentCenter;
//    [self.m_topicTimeView addSubview:self.m_title];
//    [self.view addSubview: self.m_topicTimeView];
//    
//
//
//}
//
//
///**
// *  比较时间
// */
//-(void)startCompareTime
//{
//    double remainTime=[self.m_remainTime floatValue];
//    
//    if (!m_net && remainTime < 5)
//    {
//        remainTime = 5;
//    }
//    if(remainTime >=10*60)
//    {
//        self.m_isTime10=YES;
//        [self performSelector:@selector(compareTime10) withObject:@"xiong_10" afterDelay:(remainTime-10*60)];
//        
//    } if(remainTime >=5*60)
//    {
//        self.m_isTime5=YES;
//        [self performSelector:@selector(compareTime5) withObject:@"xiong_5" afterDelay:(remainTime-5*60)];
//    }
//    if(remainTime >=60)
//    {
//        self.m_isTime1=YES;
//        [self performSelector:@selector(compareTime1) withObject:@"xiong_1" afterDelay:(remainTime-60)];
//    }
//    if(remainTime >=0)
//    {
//        self.m_isTime0=YES;
//        [self performSelector:@selector(compareTimeEnd) withObject:@"xiong_0" afterDelay:(remainTime)];
//    }
//    
//}
//-(void)compareTimeEnd
//{
//   
//    //这段代码控制聊天室时间到了不让创建人发言
//    //自定义导航栏右边按钮
//    UIButton *rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [rightButton2 setFrame: CGRectMake(0, 0, 32, 32)];
//    
//    [rightButton2 setImage:ImageNamed(@"chatroom_date_group.png") forState:UIControlStateNormal];
//    [rightButton2 setImage:ImageNamed(@"chatroom_date_group.png") forState:UIControlStateHighlighted];
//    [rightButton2 addTarget:self action:@selector(showDetail) forControlEvents:UIControlEventTouchDown];
//    self.navigationItem.rightBarButtonItems =[[NSArray alloc] initWithObjects: [[UIBarButtonItem alloc]initWithCustomView:rightButton2], nil];
//
//    m_flash = YES;
//    self.m_title.text=@"聊天室已结束";
//    
//    self.m_topicTimeView.frame=CGRectMake(0,-50, LCDW, 50);
//    [self.view bringSubviewToFront:self.m_topicTimeView];
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.m_topicTimeView.frame=CGRectMake(0,0, LCDW, 50);
//        
//    } completion:^(BOOL finished) {
//        
//        m_flash = NO;
//        [self.chatToolbar endEditing:YES];
//        EaseChatToolbar *toolbar = (EaseChatToolbar*)self.chatToolbar;
//        toolbar.m_title.text=@"聊天室已结束";
//        toolbar.inputTextView.text=@"";
//        toolbar.inputTextView.placeHolder=@"";
//        [toolbar.m_topicForbitView setHidden:NO];
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(compareTimeEnd) object:@"xiong_0"];//可以取消成功.
//        
//    }];
//}
//
//
//
//
//-(void)compareTime1
//{
//    
//      m_flash = YES;
//    self.m_title.text=@"聊天室将于1分钟后到时";
//    self.m_topicTimeView.frame=CGRectMake(0,-50, LCDW, 50);
//     [self.view bringSubviewToFront:self.m_topicTimeView];
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.m_topicTimeView.frame=CGRectMake(0,0, LCDW, 50);
//        
//    } completion:^(BOOL finished) {
//        
//         [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(compareTime1) object:@"xiong_1"];//可以取消成功。
//       [self performSelector:@selector(dissMessWindowView) withObject:nil afterDelay:3];
//        
//    }];
//    
//    
//    
//    
//}
//-(void)compareTime5
//{
//    
//      m_flash = YES;
//    self.m_title.text=@"聊天室将于5分钟后到时";
//  
//    
//    self.m_topicTimeView.frame=CGRectMake(0,-50, LCDW, 50);
//    [self.view bringSubviewToFront:self.m_topicTimeView];
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.m_topicTimeView.frame=CGRectMake(0,0, LCDW, 50);
//        
//    } completion:^(BOOL finished) {
//         [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(compareTime5) object:@"xiong_5"];//可以取消成功。
//        [self performSelector:@selector(dissMessWindowView) withObject:nil afterDelay:3];
//    }];
//    
//    
//    
//}
//-(void)compareTime10
//{
//    
//      m_flash = YES;
//    self.m_title.text=@"聊天室将于10分钟后到时";
// 
//    self.m_topicTimeView.frame=CGRectMake(0,-50, LCDW, 50);
//    [self.view bringSubviewToFront:self.m_topicTimeView];
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        self.m_topicTimeView.frame=CGRectMake(0,0, LCDW, 50);
//        
//    } completion:^(BOOL finished) {
//        
//          [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(compareTime10) object:@"xiong_10"];//可以取消成功。
//       [self performSelector:@selector(dissMessWindowView) withObject:nil afterDelay:3];
//    }];
//    
//    
//    
//}
//-(void)dissMessWindowView
//{
//     [self.view bringSubviewToFront:self.m_topicTimeView];
//    [UIView animateWithDuration:0.3 animations:^{
//        self.m_topicTimeView.frame=CGRectMake(0,-50, LCDW, 50);
//    }];
//
//}
///**
// *  时间差
// *
// *  @param times 时间
// *
// *  @return 剩余时间
// */
//-(float)getTime:(NSString *)times
//{
//    
//    //创建日期格式化对象
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    NSDate *date=[[XSDTimeCalibration share]getServerDate];
//    NSString *curdate=[dateFormatter stringFromDate:date];
//    //创建了两个日期对象
//    NSDate *date1=[dateFormatter dateFromString:curdate];
//    NSDate *date2=[dateFormatter dateFromString:times];
//    
//    
//    //取两个日期对象的时间间隔：
//    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
//    NSTimeInterval cha=[date2 timeIntervalSinceDate:date1];
//    
//    return cha;
//}
//
//-(void)dissMessView
//{
//    //    [self resignKeyWindow];
//    
//    [self.m_topicTimeView removeFromSuperview];
//    self.m_topicTimeView.hidden = YES;
//    
//   
//}
///**
// *  取消定时器
// */
//-(void)deletePerformSelector
//{
//    if (self.m_isTime0)
//    {
//        self.m_isTime0=NO;
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(compareTimeEnd) object:@"xiong_0"];//可以取消成功。
//    }
//    if (self.m_isTime10)
//    {
//        self.m_isTime10=NO;
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(compareTime10) object:@"xiong_10"];//可以取消成功。
//    }
//    if (self.m_isTime5)
//    {
//        self.m_isTime5=NO;
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(compareTime5) object:@"xiong_5"];//可以取消成功。
//    }
//    if (self.m_isTime1)
//    {
//        self.m_isTime1=NO;
//        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(compareTime1) object:@"xiong_1"];//可以取消成功。
//    }  
//}
//-(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
//    int ci;
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *dt1 = [[NSDate alloc] init];
//    NSDate *dt2 = [[NSDate alloc] init];
//    dt1 = [df dateFromString:date01];
//    dt2 = [df dateFromString:date02];
//    NSComparisonResult result = [dt1 compare:dt2];
//    switch (result)
//    {
//            //date02比date01大
//        case NSOrderedAscending: ci=1; break;
//            //date02比date01小
//        case NSOrderedDescending: ci=-1; break;
//            //date02=date01
//        case NSOrderedSame: ci=0; break;
//        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
//    }
//    return ci;
//}
//
//-(void)ClickleftState:(UIButton *)btn
//{
//
//
//   
//
//    if (self.m_chatRoomType == ChatRoomTypeRolePlay) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }else{
//    [self.navigationController popViewControllerAnimated:YES];
//    }
//}
//-(void)setNavtitleNumber
//{
//    UIButton * leftBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
//   
//    [leftBtn setImage:ImageNamed(@"nav_back") forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(ClickleftState:) forControlEvents:UIControlEventTouchUpInside];
//    [leftBtn setExclusiveTouch:YES];
////    [leftBtn setTitle:@"    " forState:UIControlStateNormal];
//    UIBarButtonItem *negativeSpacer  = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    UIBarButtonItem * lefBtn;
//    //未读消息数
//    [DTools refreshUnreadMessage];//刷新消息数
//    NSString * numberMessage = [self TakeAllMessageNumber];
//    if ([numberMessage integerValue] > 99) {
//        numberMessage = @"99+";
//    }
//   
//    //如果没消息则不显示
//    if ([numberMessage integerValue] != 0 && numberMessage.length !=0) {
//         [leftBtn setFrame:CGRectMake(0, 0, 70, 40)];
//        [leftBtn setTitle:[NSString stringWithFormat:@"(%@)",numberMessage] forState:UIControlStateNormal];
//        leftBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//        leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, -30, 0.0,0.0);
//        negativeSpacer.width = -11;
//        lefBtn  = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    }else{
//         [leftBtn setFrame:CGRectMake(0, 0, 40, 40)];
//        negativeSpacer.width = -11;
//        lefBtn  = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//        
//    }
//    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lefBtn];
//}
//
//
///**
// *  分享群信息
// *
// *  @param model
// *  @param content
// */
//-(void)shareInfo:(NSNotification *)noti
//{
//    EMMessage *message=(EMMessage *)noti.object;
//    
//    
//    
//    
//   
//         [self addMessageToDataSource:message progress:nil];
//    
//    
//}


@end
