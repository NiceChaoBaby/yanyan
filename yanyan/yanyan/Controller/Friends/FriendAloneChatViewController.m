//
//  FriendAloneChatViewController.m
//  chat
//
//  Created by dong on 16/3/24.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "FriendAloneChatViewController.h"
//#import "LookUserViewController.h"
////#import "TopcicChatRoomDetailsViewController.h"
//#import "WaitingFigureView.h"
@interface FriendAloneChatViewController ()
//<UIAlertViewDelegate, EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource,EMClientDelegate>

@end

@implementation FriendAloneChatViewController

//- (void)viewDidLoad
//
//{
//    self.m_singleChat = YES;//当进入 写上单聊标识
//    [self searchFriend];
//    [self initData];
//    
//    [super viewDidLoad];
//    //注册结束聊天通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//     
//                                             selector:@selector(ClickleftState)
//     
//                                                 name:K_endAloneChat object:nil];
//    self.title=self.m_friendListModel.m_nickname;
//    self.delegate=self;
//    [self initSetNav];
//    [self initView];
//  
//    // Do any additional setup after loading the view.
//}
///**
// *  查找本地存储的好友信息
// */
//-(void)searchFriend
//{
////    if(!self.m_friendListModel)
////    {
////        NSMutableArray *arr= [self myFriendListLocalRead];
////        for (int i=0; i<arr.count; i++)
////        {
////            FriendListModel *listModel=[arr safeObjectAtIndex:i];
////            if ([listModel.m_easeUname isEqualToString:self.m_aConversationId]) {
////                self.m_friendListModel=listModel;
////            }
////        }
//    
//        //陌生人 
//        if (!self.m_friendListModel)
//        {
//            self.m_friendListModel=[[FriendListModel alloc] init];
//            self.m_friendListModel.m_nickname=self.m_noticeModel.m_title;
//            self.m_friendListModel.m_easeUname=self.m_noticeModel.m_conversationId;
//            self.m_friendListModel.m_avatar=self.m_noticeModel.m_avatar;
//            self.m_friendListModel.m_fuid=self.m_noticeModel.m_uid;
//            NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//            [accountDefaults setObject:[NSString stringWithFormat:@"%@",self.m_noticeModel.m_from] forKey:K_noticeRoomName];
//        }
////    }
//    
//}
///**
// *  这部分必须放到[super viewDidLoad];前面因为我是用storyboard做的界面初始化不一样
// */
//-(void)initData
//{
//   
//    //初始化数据
//    self.conversation = [[EMClient sharedClient].chatManager getConversation:self.m_friendListModel.m_easeUname type:EMConversationTypeChat createIfNotExist:YES];
//    ShareAppDelegate.m_easeID = self.m_friendListModel.m_easeUname;//记录环信好友聊天ID
//    self.messageCountOfPage = 10;
//    self.timeCellHeight = 30;
//    self.deleteConversationIfNull = YES;
//    self.scrollToBottomWhenAppear = YES;
//    self.messsagesSource = [NSMutableArray array];
//    
//    [self.conversation markAllMessagesAsRead];
//}
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
//    
//    
//    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor =RGBBgNavColor;
////    //字体颜色
////    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
////    self.navigationController.navigationBar.titleTextAttributes = dict;
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:18],
//       NSForegroundColorAttributeName:[UIColor whiteColor]}];
//
//    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
//    temporaryBarButtonItem.title = @"";
//    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
//    
//    
//    
//    //自定义导航栏左边按钮
//    UIButton *rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [rightButton1 setFrame: CGRectMake(0, 0, 32, 32)];
//    
//    [rightButton1 setImage:ImageNamed(@"chatroom_date_personal.png") forState:UIControlStateNormal];
//    [rightButton1 setImage:ImageNamed(@"chatroom_date_personal.png") forState:UIControlStateHighlighted];
//    [rightButton1 addTarget:self action:@selector(showFriendsInfo) forControlEvents:UIControlEventTouchDown];
//    
////    UIButton *rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
////    
////    [rightButton2 setFrame: CGRectMake(0, 0, 32, 32)];
////    
////    [rightButton2 setImage:ImageNamed(@"chatroom_map") forState:UIControlStateNormal];
////    [rightButton2 setImage:ImageNamed(@"chatroom_map") forState:UIControlStateHighlighted];
////    [rightButton2 addTarget:self action:@selector(showPopover:forEvent:) forControlEvents:UIControlEventTouchDown];
//    
//    
//    
//    self.navigationItem.rightBarButtonItems =[[NSArray alloc] initWithObjects: [[UIBarButtonItem alloc]initWithCustomView:rightButton1],nil];
//}
//
//-(void)initView
//{
//    self.view.backgroundColor=RGBBgChatColor;
////    self.tableView.backgroundColor=[UIColor clearColor];
//    
//    
//    
//    //self.tableView.frame=CGRectMake(0, 90, LCDW, LCDH-90+20);
//    DLog(@"%.2f--%.2f--%.2f",LCDH,self.view.frame.size.height,self.tableView.frame.size.height);
//   
//    self.showRefreshHeader = YES;
//    
////    self.tableView.frame=CGRectMake(0,0, self.tableView.frame.size.width, self.view.frame.size.height-46);
//    
//    
//    
//    [[EaseBaseMessageCell appearance] setAvatarSize:40.f];
//    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.f];
//    [[EaseBaseMessageCell appearance] setMessageNameHeight:0.f];
//    [[EaseChatBarMoreView appearance] setMoreViewBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0]];
//    [[EaseBaseMessageCell appearance]  setMessageNameIsHidden:YES];
//   
//    
//    //通过会话管理者获取已收发消息
//    [self tableViewDidTriggerHeaderRefresh];
//    
//    
//    
//    
//    [self.tableView reloadData];
//    
//}
//- (void)viewWillAppear:(BOOL)animated
//{
//    
//   
//    
//    [super viewWillAppear:animated];
//    [IQKeyboardManager sharedManager].enable = NO;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
//    [[EaseBaseMessageCell appearance]  setMessageNameIsHidden:YES];
//    if (self.conversation.type == EMConversationTypeChat) {
//        if ([[self.conversation.ext objectForKey:@"subject"] length])
//        {
//            self.title = [self.conversation.ext objectForKey:@"subject"];
//        }
//    }
//   
//    ShareAppDelegate.m_easeID =  self.m_friendListModel.m_easeUname;//记录环信好友聊天ID;
//    //设置左侧返回键
//    [self setNavtitleNumber];
//    //更新未读信息数量
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNavtitleNumber) name:K_MessageNumberNav object:nil];
//     [self.navigationController setNavigationBarHidden:NO animated:NO];
//    
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//    ShareAppDelegate.m_easeID =  nil;
//    //这里是在视图将要消失的时候让输入框回归原位  不然切换别的聊天室有可能造成输入框消失问题
//     [self.chatToolbar endEditing:YES];
//    [IQKeyboardManager sharedManager].enable = YES;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
//        [[NSNotificationCenter defaultCenter]removeObserver:self name:K_MessageNumberNav object:nil];
//    
//}
//- (void)dealloc
//{
//    //群组不做处理
//    if (self.conversation.type == EMConversationTypeChat)
//    {
//    
//    }
//    
//    [[EMClient sharedClient] removeDelegate:self];
//    [[EMClient sharedClient].chatManager removeDelegate:self];
//}
//
//#pragma mark -按钮事件
//
//
//
//
//
//-(void)showFriendsInfo
//{
//    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Friends" bundle:nil];
//    LookUserViewController * lookuser = [storyboard instantiateViewControllerWithIdentifier:@"LookUserViewController"];
//    
//  
//    
//    lookuser.m_uid=self.m_friendListModel.m_fuid;
//    lookuser.m_chatPush = YES;
//    
//    [self.navigationController pushViewController:lookuser animated:YES];
//}
//
//
//#pragma mark - UIAlertViewDelegate
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.cancelButtonIndex != buttonIndex) {
//        self.messageTimeIntervalTag = -1;
//        [self.conversation deleteAllMessages];
//        [self.dataArray removeAllObjects];
//        [self.messsagesSource removeAllObjects];
//        
//        [self.tableView reloadData];
//    }
//}
//
//
//#pragma mark - EaseMob
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
//- (void)backAction
//{
//    [[EMClient sharedClient].chatManager removeDelegate:self];
//  
////    if (self.deleteConversationIfNull) {
////        //判断当前会话是否为空，若符合则删除该会话
////        EMMessage *message = [self.conversation latestMessage];
////        if (message == nil) {
////            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId deleteMessages:NO];
////        }
////    }
//
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
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
//    else if ([sender isKindOfClass:[UIButton class]]){
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"sureToDelete", @"please make sure to delete") delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
//        [alertView show];
//    }
//}
//
//
//
//
//#pragma mark - private
//
//
//#pragma mark -  EaseMessageViewControllerDelegate
///**
// *  得到非好友的信息
// *
// *  @return
// */
//-(FriendListModel *)getNoFriendInfo
//{
//    return self.m_friendListModel;
//}
//-(void)clickInterestButton:(id<IMessageModel>)model
//{
//    
//    
//    [self FeelingsRequest:model];
//}
//-(void)clickTextButton:(id<IMessageModel>)model
//{
//    UIStoryboard * story = [UIStoryboard storyboardWithName:@"TopicChat" bundle:nil];
//    //6.26 xiong
////    TopcicChatRoomDetailsViewController  * topciChatRoom = [story instantiateViewControllerWithIdentifier:@"TopcicChatRoomDetailsViewController"];
////     int cid=[[model.message.ext objectForKey:K_CID_TOPIC] intValue];
////    topciChatRoom.m_id = [NSString stringWithFormat:@"%i",cid];
////    //        //把信息model传入话题聊天室详情
////    //        topciChatRoom.m_topicChatModel = self.m_topicChatModel;
////    [self.navigationController pushViewController:topciChatRoom animated:YES];
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///**
// *  感兴趣话题请求
// */
//-(void)FeelingsRequest:(id<IMessageModel>)model
//{
//     int cid=[[model.message.ext objectForKey:K_CID_TOPIC] intValue];
//    NSDictionary * info = [URLPath getNetInterestedCid:[NSString stringWithFormat:@"%i",cid]];
////    __weak FriendAloneChatViewController * topic = self;
//    [[AFHTTPClient share]postMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
//        NSInteger rs = [[respostData safeObjectForKey:K_rs]integerValue];
//        if (rs == 1) {
//            [SVProgressHUD dismiss];
//            //            [SVProgressHUD showSuccessWithStatus:@"感兴趣成功"];
//            [[WaitingFigureView shareInstance]addInterestView];
//            
//         
//            //记录感兴趣时间 1分钟感兴趣3次
//            [DTools StoredInterestedTimeOneMin:[self tellMeTimeTwo] KName:k_ClickTimeArray];
//            [self updateInterest:model];
//            
//        }else{
//            [SVProgressHUD showErrorWithStatus:[respostData objectForKey:k_msg]];
//        }
//        
//        
//        
//    } failed:^(NSString *errorMsg) {
//        [SVProgressHUD showErrorWithStatus:K_ErrorMsg];
//    }];
//    
//    
//    
//    
//    
//}
///**
// *  更新举报数据
// *
// *  @param messageModel
// */
//-(void)updateInterest:(id<IMessageModel>)messageModel
//{
//    
//    
//    
//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:
//              
//              @"1", K_CID_AGREE,
//              [messageModel.message.ext objectForKey:@"avatar"], @"avatar",
//               [messageModel.message.ext objectForKey:@"birth"], @"birth",
//              [NSString stringWithFormat:@"%i",[[messageModel.message.ext objectForKey:@"cid"] intValue]], @"cid",
//              [messageModel.message.ext objectForKey:@"gender"], @"gender",
//              [messageModel.message.ext objectForKey:@"nickname"],@"nickname",
//               [NSString stringWithFormat:@"%i",[[messageModel.message.ext objectForKey:@"uid"] intValue]],@"uid",
//              nil];
//    messageModel.message.ext=dic;
//    [[EMClient sharedClient].chatManager updateMessage:messageModel.message];
////    [ self.dataArray replaceObjectAtIndex:messageModel.m_indexPath.row withObject:messageModel];
////    dispatch_async(dispatch_get_main_queue(), ^{
////        
////        [self.tableView reloadData];
////        //        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArray count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
////    });
//    
//}
//
//
//
//-(void)ClickleftState
//{
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:K_endAloneChat object:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//
//
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}
//-(void)setNavtitleNumber
//{
//    UIButton * leftBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
//    
//    [leftBtn setImage:ImageNamed(@"nav_back") forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(ClickleftState) forControlEvents:UIControlEventTouchUpInside];
//    //    [leftBtn setTitle:@"    " forState:UIControlStateNormal];
//    UIBarButtonItem *negativeSpacer =  negativeSpacer  = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    UIBarButtonItem * lefBtn;
//    //未读消息数
//    [DTools refreshUnreadMessage];//刷新消息数
//    NSString * numberMessage = [self TakeAllMessageNumber];
//    if ([numberMessage integerValue] > 99) {
//        numberMessage = @"99+";
//    }
//    //如果没消息则不显示
//    if ([numberMessage integerValue] != 0 && numberMessage.length !=0) {
//        [leftBtn setFrame:CGRectMake(0, 0, 70, 40)];
//        [leftBtn setTitle:[NSString stringWithFormat:@"(%@)",numberMessage] forState:UIControlStateNormal];
//        leftBtn.titleLabel.font = [UIFont systemFamilyFontOfSize:18];
//        leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0.0, -30, 0.0,0.0);
//        negativeSpacer.width = -11;
//        lefBtn  = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//    }else{
//        [leftBtn setFrame:CGRectMake(0, 0, 40, 40)];
//        negativeSpacer.width = -11;
//        lefBtn  = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
//        
//    }
//    self.navigationItem.leftBarButtonItems = @[negativeSpacer,lefBtn];
//}
//
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
