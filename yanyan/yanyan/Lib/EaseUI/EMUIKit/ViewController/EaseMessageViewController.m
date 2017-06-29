//
//  EaseMessageViewController.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/26.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseMessageViewController.h"

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "NSDate+Category.h"
#import "EaseMessageReadManager.h"
#import "EaseEmotionManager.h"
#import "EaseEmoji.h"
#import "EaseEmotionEscape.h"
#import "EaseCustomMessageCell.h"
#import "UIImage+GIF.h"
#import "ShareView.h"
#define KHintAdjustY    50
#define K_DefineRefreshNews     180
#import "ForbidModel.h"
#import "BeenForbidModel.h"
#import "UnForbidModel.h"
#import "ChatTipoffModel.h"
#import "TipoffModel.h"

#import "VideoViewController.h"
#import "ShutupModel.h"
#import "NoticeMessageView.h"

#import "WaitingFigureView.h"
#import "ChoosePhotosViewController.h"
#import "TZAssetModel.h"
#import "AnswerModel.h"
@implementation EaseAtTarget
- (instancetype)initWithUserId:(NSString*)userId andNickname:(NSString*)nickname
{
    if (self = [super init]) {
        _userId = [userId copy];
        _nickname = [nickname copy];
    }
    return self;
}
@end
@interface EaseMessageViewController ()<EaseMessageCellDelegate,CustomMessageTableViewCellDelegate,UIAlertViewDelegate,VideoViewControllerDelegate,UIGestureRecognizerDelegate,EMGroupManagerDelegate,ChoosePhotosDelegate>
{
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    UILongPressGestureRecognizer *_lpgr;
    dispatch_queue_t _messageQueue;
    NSMutableArray *_atTargets;
//    int a;
}

@property (strong, nonatomic) id<IMessageModel> playingVoiceModel;
@property (nonatomic) BOOL isKicked;
@property (nonatomic) BOOL isPlayingAudio;
@property(nonatomic,assign) int m_timeNumber;
@property (nonatomic, strong) NSMutableArray *atTargets;
@property (nonatomic,strong)UIButton * m_Btn;//新消息提示图
@property(nonatomic,strong) NoticeMessageView *m_noticeMessageHeaderView ;
//@property(nonatomic,strong)NSLock * m_theLock;//线程锁
@property (nonatomic) BOOL isBecomeActive;//是否去过后台  默认NO
@end

@implementation EaseMessageViewController

@synthesize conversation = _conversation;
@synthesize deleteConversationIfNull = _deleteConversationIfNull;
@synthesize messageCountOfPage = _messageCountOfPage;
@synthesize timeCellHeight = _timeCellHeight;
@synthesize messageTimeIntervalTag = _messageTimeIntervalTag;
@synthesize right;

//-(NSLock *)m_theLock
//{
//    if (!_m_theLock) {
//        _m_theLock = [[NSLock alloc]init];
//    }
//    
//    return _m_theLock;
//}

-(NSMutableArray *)m_blockListArr

{
    if (!_m_blockListArr) {
        _m_blockListArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    }
    return _m_blockListArr;
}
-(NSMutableArray *)m_imageArray
{
    if (!_m_imageArray) {
        _m_imageArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _m_imageArray;
    
}

- (instancetype)initWithConversationChatter:(NSString *)conversationChatter
                           conversationType:(EMConversationType)conversationType
{
    if ([conversationChatter length] == 0) {
        return nil;
    }
    
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _conversation = [[EMClient sharedClient].chatManager getConversation:conversationChatter type:conversationType createIfNotExist:YES];
        
        _messageCountOfPage = 10;
        _timeCellHeight = 30;
        _deleteConversationIfNull = YES;
        _scrollToBottomWhenAppear = YES;
        _messsagesSource = [NSMutableArray array];
       EMError *error;
        [_conversation markAllMessagesAsRead:&error];
    }
    
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.m_Down = YES;
  
  
    //    a = 0;
// Do any additional setup after loading the view.
   self.view.backgroundColor=RGBBgChatColor;
    self.tableView.backgroundColor=RGBBgChatColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [[EMClient sharedClient].roomManager removeDelegate:self];
//注册代理
    [EMCDDeviceManager sharedInstance].delegate = self;
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
  
//初始化数据

     _messageQueue = dispatch_queue_create("hyphenate.com", NULL);
    
//    self.frostedViewController.panGestureEnabled=NO;
    //注册登录监听状态通知 重新载入聊天室视图
    [[NSNotificationCenter defaultCenter]postNotificationName:K_PAN_NOTICE_NO object:nil];
    
    self.m_noticeHeight=25;
    
    [[EaseBaseMessageCell appearance] setSendMessageVoiceAnimationImages:@[[UIImage imageNamed:@"chat_sender_audio_playing_full"], [UIImage imageNamed:@"chat_sender_audio_playing_000"], [UIImage imageNamed:@"chat_sender_audio_playing_001"], [UIImage imageNamed:@"chat_sender_audio_playing_002"], [UIImage imageNamed:@"chat_sender_audio_playing_003"]]];
    [[EaseBaseMessageCell appearance] setRecvMessageVoiceAnimationImages:@[[UIImage imageNamed:@"chat_receiver_audio_playing_full"],[UIImage imageNamed:@"chat_receiver_audio_playing000"], [UIImage imageNamed:@"chat_receiver_audio_playing001"], [UIImage imageNamed:@"chat_receiver_audio_playing002"], [UIImage imageNamed:@"chat_receiver_audio_playing003"]]];
    //初始化页面
    CGFloat chatbarHeight = [EaseChatToolbar defaultHeight:self.conversation.type];
    EMConversationType barType = self.conversation.type;
    
    self.chatToolbar = [[EaseChatToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - chatbarHeight, self.view.frame.size.width, chatbarHeight) type:barType];
    self.chatToolbar.backgroundColor = RGBBgChatColor;
   
    self.chatToolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    
    
    //右边新消息条数提示
    self.m_Btn = [[UIButton alloc]initWithFrame:CGRectMake(LCDW - 70, (LCDH - 70 - 46 - 44), 70, 70)];
    self.m_Btn.backgroundColor = [UIColor clearColor];
    [self.m_Btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.m_Btn setImage:ImageNamed(@"bubble") forState:UIControlStateNormal];
    [self.view addSubview:self.m_Btn];
    self.m_Btn.hidden = YES;
    //有新消息通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMessage) name:K_NewMessage object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NONewMessage) name:K_NONEWMessage object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cmdMessage:) name:K_CmdMessage object:nil];

    
    
    //初始化手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardHidden:)];
    [self.tableView addGestureRecognizer:tap];
    tap.delegate=self;
    _lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    _lpgr.minimumPressDuration = 0.5;
    [self.tableView addGestureRecognizer:_lpgr];
    
    
     self.m_ChatRoom2 = self.conversation.type;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(concelTimer) name:@"concelTimer" object:nil];
    if (self.conversation.type == EMConversationTypeChatRoom)
    {
       
             
        
        [self joinChatroom:self.conversation.conversationId];

    }else if (self.conversation.type==EMConversationTypeGroupChat)
    {
       
         [self performSelector:@selector(changeNews) withObject:[NSNumber numberWithBool:YES] afterDelay:5];
         [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
        //  后台切入前台  此方法会造成UI卡顿
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didBecomeActive)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
    }
   
    if(self.conversation.type==EMConversationTypeChat)
    {
        self.m_noticeMessageHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"NoticeMessageView" owner:self options:nil] firstObject];
        
        self.m_noticeMessageHeaderView.m_titleLab.backgroundColor= RGBAssistColor;
        self.m_noticeMessageHeaderView.m_bgView.backgroundColor=  RGBBgChatColor;
        self.m_noticeMessageHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.m_noticeMessageHeaderView.m_titleLab.lineBreakMode = NSLineBreakByWordWrapping;
        self.m_noticeMessageHeaderView.m_titleLab.numberOfLines = 0;//上面两行设置多行显示
       
    }
//       self.tableView.tableHeaderView=nil;
  
    self.isBecomeActive=NO;
   //从做往右滑动手势注册
    self.right=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goBack:)];
    
    self.right.direction=UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.right];


}

/**
 设置来源消息的值

 @param str    消息数据
 @param isHide 是否显示消息
 */
-(void)setnoticeMessageViewText:(NSString *)str isHide:(BOOL)isHide
{
    if (isHide) {
         self.tableView.tableHeaderView=nil;
        
    }else
    {
        
        
        //必须打空格才能有效果且必须设置NSMutableParagraphStyle 要不然后面没效果
        NSString *title=[NSString stringWithFormat:@"来自%@",str];
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        paragraphStyle.alignment = NSTextAlignmentCenter;
//        //前部间距
//        [paragraphStyle setHeadIndent:10];
//        //后部间距
//        [paragraphStyle setTailIndent:10];
//        
//        //        [self.m_noticeMessageHeaderView setHidden:YES];
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
//        self.m_noticeMessageHeaderView.m_titleLab.attributedText = attributedString;
          self.m_noticeMessageHeaderView.m_titleLab.text = [title replaceUnicode];
         CGSize size = [ self.m_noticeMessageHeaderView.m_titleLab sizeThatFits:CGSizeMake(MAXFLOAT,MAXFLOAT)];
        float width=size.width;
        if(width>250)
        {
            width=250;
            size = [ self.m_noticeMessageHeaderView.m_titleLab sizeThatFits:CGSizeMake(250,MAXFLOAT)];
            width=size.width;
        }
        self.m_noticeMessageHeaderView.m_labConstraintWidth.constant=width+20;
        [DTools getCorner:self.m_noticeMessageHeaderView.m_titleLab radius:5];
        if([str isNull])
        {
            self.m_noticeMessageHeaderView.frame=CGRectMake(0, 0, width+20, size.height+20);
            self.tableView.tableHeaderView=self.m_noticeMessageHeaderView;
        }
    }
    
    
}
#pragma mark - 点击事件 新消息

-(void)touchBtn:(UIButton *)btn
{
    self.m_Btn.hidden = YES;
    //让TableView滚动到底部
    [self  _scrollViewToBottom:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:K_CHANGEFREAMALL object:nil];
    
    
}
#pragma mark -通知处理
/**
 *  有新消息方法
 */
-(void)newMessage
{
    [[NSNotificationCenter defaultCenter]postNotificationName:K_CHANGEFREAMNOALL object:nil];
    self.m_Btn.hidden = NO;
    
}
/**
 *  没有新消息方法 为的是滑动到底部自动消失
 */
-(void)NONewMessage
{
    self.m_Btn.hidden = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:K_CHANGEFREAMALL object:nil];

}
/**
 *  透传过来的消息
 */
-(void)cmdMessage:(NSNotification *)notification
{
    NSDictionary *dic=(NSDictionary *)notification.object;
   // DLog(@"cmdMessage=====来啦===%@",dic);
    EMMessage *message=[dic objectForKey:K_cmdMessageNotice];
    NSString *str=[dic objectForKey:K_cmdType];
    switch ([str intValue]) {
        
         case 18:
         case 19:
        {
            if (self.conversation.type==EMConversationTypeChatRoom)
            {
                if([self.conversation.conversationId isEqualToString:message.conversationId])
                {
                    [self addMessageToDataSource:message progress:nil];
                }
            }

        }
         break;//聊天室
        
         case 8:
         case 9:
         case 11:
         case 13:
         case 21:
         case 27:
        {
            if (self.conversation.type==EMConversationTypeGroupChat)
            {
                if([self.conversation.conversationId isEqualToString:message.conversationId])
                {
                    [self addMessageToDataSource:message progress:nil];
                }
            }
            
        }
        break;//群组
        
        default:
        break;
    }

}
- (void)setupEmotion
{
    if ([self.dataSource respondsToSelector:@selector(emotionFormessageViewController:)]) {
        
        NSArray* emotionManagers = [self.dataSource emotionFormessageViewController:self];
        [self.faceView setEmotionManagers:emotionManagers];
        
    } else {
        
        NSMutableArray *emotions = [NSMutableArray array];
        for (NSString *name in [EaseEmoji allEmoji])
        {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
            
        }
        EaseEmotion *emotion = [emotions objectAtIndex:0];
        EaseEmotionManager *manager= [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:emotion.emotionId]];
        [self.faceView setEmotionManagers:@[manager]];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
 
  
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[EMCDDeviceManager sharedInstance] stopPlaying];
    [EMCDDeviceManager sharedInstance].delegate = nil;
    
    if (_imagePicker){
        [_imagePicker dismissViewControllerAnimated:NO completion:nil];
        _imagePicker = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    
    
    
    self.isViewDidAppear = YES;
    
    [[EaseSDKHelper shareHelper] setIsShowingimagePicker:NO];
    
//    if (self.scrollToBottomWhenAppear)
//    {
//        [self _scrollViewToBottom:NO];
//    }
//    self.scrollToBottomWhenAppear = YES;
//    
    
//    self.m_isChatInterface = YES;
    
    if ([self.dataArray count] != 0) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArray count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
//    [self.tableView reloadData];
//    if (!self.m_Down) {
//
//        //    通知显示右下角新消息的提示
//        [[NSNotificationCenter defaultCenter]postNotificationName:K_NewMessage object:nil];
//        
//    }else{
//        //让新消息消失
//        //        [[NSNotificationCenter defaultCenter]postNotificationName:K_NONEWMessage object:nil];
//        //    }
//        //让新消息消失
//        [[NSNotificationCenter defaultCenter]postNotificationName:K_NONEWMessage object:nil];
//    }
    
       
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.isViewDidAppear = NO;
//     self.m_isChatInterface = NO;
//    [_conversation markAllMessagesAsRead];
    [[EMCDDeviceManager sharedInstance] disableProximitySensor];
}

#pragma mark - chatroom

- (void)saveChatroom:(EMChatroom *)chatroom
{
    NSString *chatroomName = chatroom.subject ? chatroom.subject : @"";
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[EMClient sharedClient] currentUsername]];
    NSMutableDictionary *chatRooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
    if (![chatRooms objectForKey:chatroom.chatroomId])
    {
        [chatRooms setObject:chatroomName forKey:chatroom.chatroomId];
        [ud setObject:chatRooms forKey:key];
        [ud synchronize];
    }
}

- (void)joinChatroom:(NSString *)chatroomId
{
   
   
    __weak typeof(self) weakSelf = self;
//    [self showHudInView:self.view hint:NSLocalizedString(@"chatroom.joining",@"Joining the chatroom")];
//    [SVProgressHUD showWithStatus:@"加入中..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        EMChatroom *chatroom = [[EMClient sharedClient].roomManager joinChatroom:chatroomId error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        if (weakSelf) {
                EaseMessageViewController *strongSelf = weakSelf;
//                [strongSelf hideHud];
                
                
    
                
    if (error != nil) {
//                    [strongSelf showHint:[NSString stringWithFormat:NSLocalizedString(@"chatroom.joinFailed",@"join chatroom \'%@\' failed"), chatroomId]];
                    
                    //聊天室人数已满
                    if (error.code  == EMErrorChatroomMembersFull) {
              
                //当人数已满发送通知自动跳转下一个聊天室
                [[NSNotificationCenter defaultCenter]postNotificationName:KNOTIFICATION_CHANGEROOM object:nil];
                //当搜索房间人数已满  发送通知
                [[NSNotificationCenter defaultCenter]postNotificationName:KNOTIFICATION_SEARCHCHATROOM object:nil];
                        
                    }else{
                    
                    
                    
               //   DLog(@"加入聊天室失败,是否重新加入---%ui----%@",error.code,error.errorDescription);
//                        NSString *str=[NSString stringWithFormat:@"",error.code,error.errorDescription];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"加入聊天室失败,是否重新加入" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [alert show];
                    return; 
                    }
                    

    }
    else
    {
         if (self.m_chatRoomType != ChatRoomTypeTopic)
         {
         [ShareAppDelegate.m_topDataArray removeAllObjects];
    
         }
        //6.26 xiong
//        [MiPushSDK subscribe:[NSString stringWithFormat:@"room_%@",chatroomId]];//设置小米推送标识
        // DLog(@"加入聊天室成功");
        //获取系统当前的时间戳
        NSDate* dat = [[XSDTimeCalibration share] getServerDate];
        
        NSTimeInterval a=[dat timeIntervalSince1970];
        self.m_joinRoomTime=a;
        
        strongSelf.isJoinedChatroom = YES;
        [strongSelf saveChatroom:chatroom];
                    //通知加载UI
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"Havelove" object:nil];
                    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
              [[WaitingFigureView shareInstance]dissMessView];
       
        
         [[EMClient sharedClient].roomManager addDelegate:self delegateQueue:nil];

       
        
       
        
                    
        
                   

        
        NSString *uidStr=[self readRoomName];
        self.title=uidStr;
        [accountDefaults setObject:[NSString stringWithFormat:@"聊天室『%@』",uidStr] forKey:K_noticeRoomName];
    
        
                    
        
                    
                }
                
            }  else
            {
                if (!error || (error.code == EMErrorChatroomAlreadyJoined)) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        EMError *leaveError;
                        [[EMClient sharedClient].roomManager leaveChatroom:chatroomId error:&leaveError];
                        [[EMClient sharedClient].chatManager  deleteConversation:chatroomId isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError) {
                            
                        }];

                    });
                }
            }
        });
    });
}
#pragma mark - 定时器
/**
 *  取消新闻切换定时
 */
-(void)concelTimer
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeChatRoomNews) object:[NSNumber numberWithBool:YES]];//可以取消成功。
}
/**
 *  取消群组新闻切换定时
 */
-(void)concelGroupTimer
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeNews) object:[NSNumber numberWithBool:YES]];//可以取消成功。
}
-(void)changeNews
{
    DLog(@"群组新闻倒计时---");
    [self getNetGetNewsGroupIDG:self.conversation.conversationId];
    
}
-(void)changeChatRoomNews
{
    DLog(@"聊天室新闻倒计时---");
//     [self getNetGetNewsGroupIDG:self.conversation.conversationId];
}


#pragma mark - EMChatManagerChatroomDelegate

- (void)didReceiveUserJoinedChatroom:(EMChatroom *)aChatroom
                            username:(NSString *)aUsername
{
    
    //DLog(@"%@  --  %@",aChatroom,aUsername);
  
         [self DetermineUser:aUsername type:addChatRoom chatRoomid:aChatroom.chatroomId];
    
   // DLog(@"+++++++++_______+++++++++++  接收到有用户加入聊天室");
 
}

//请求加入人的详情
-(void)RequestUserInfo:(NSDictionary *)info
{
   
    
    [[AFHTTPClient share]getMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
        
        
        int rs = [[respostData safeObjectForKey:K_rs]intValue];
        if (rs == 1) {
            
//            a++;
//            DLog(@"鬼鬼鬼鬼鬼鬼鬼鬼鬼鬼鬼鬼鬼鬼鬼%d",a);
//            NSMutableArray * array = [ChatMemberListModel mj_objectWithKeyValues:[respostData objectForKey:K_data]];
            // DLog(@"%@",ShareAppDelegate.m_ChatNumberPeople);
            ChatMemberListModel * model = [ChatMemberListModel mj_objectWithKeyValues:[respostData objectForKey:K_data]];
                                      
           model.m_endDate =[[XSDTimeCalibration share] getCurrentTimeAddSinceNow:model.m_remainTime];
            [ShareAppDelegate.m_ChatNumberPeople addObject:model];
            
           // DLog(@"%@",ShareAppDelegate.m_ChatNumberPeople);
            [[NSNotificationCenter defaultCenter]postNotificationName:K_PEOPLEPHOTORELOATDATA object:nil];
//            [self.m_theLock unlock];//解锁
        }
        
        
    } failed:^(NSString *errorMsg) {
//         [self.m_theLock unlock];//解锁
    }];

    
}
//判断并加入信息数据
-(void)DetermineUser:(NSString *)userName type:(PeopleChat)type  chatRoomid:(NSString *)chatRoomid
{
   
   
    if (type == addChatRoom) {
       
     //   DLog(@"zaa");
//       dispatch_async(dispatch_get_global_queue(0,0), ^{
        for (int i = 0; i < ShareAppDelegate.m_ChatNumberPeople.count; i ++) {
            
            ChatMemberListModel * model = ShareAppDelegate.m_ChatNumberPeople[i];
           // DLog(@"%lu",(unsigned long)ShareAppDelegate.m_ChatNumberPeople.count);
            if ([model.m_easeUname isEqualToString:userName]) {
                break;
            }else if (i == ShareAppDelegate.m_ChatNumberPeople.count -1){
                 //上锁
//                [self.m_theLock lock];
                //请求加入人的详情
                [self RequestUserInfo:[URLPath getNetChatRoomUserData:userName Erid:chatRoomid]];
            }
        }
        
//       });
        
    }else if (type == leaveChatRoom){
        
        for (int i = 0; i < ShareAppDelegate.m_ChatNumberPeople.count; i ++) {
            
            ChatMemberListModel * model = ShareAppDelegate.m_ChatNumberPeople[i];
            if ([model.m_easeUname isEqualToString:userName]) {
                [ShareAppDelegate.m_ChatNumberPeople removeObjectAtIndex:i];
                [[NSNotificationCenter defaultCenter]postNotificationName:K_PEOPLEPHOTORELOATDATA object:nil];
                break;
             }
        }
    
}
}



- (void)didReceiveUserLeavedChatroom:(EMChatroom *)aChatroom
                            username:(NSString *)aUsername
{
 
   // DLog(@"%@  ---  %@",aChatroom,aUsername);
   //  DLog(@"+++++++++_______+++++++++++  接收到有用户离开聊天室");
    [self DetermineUser:aUsername type:leaveChatRoom chatRoomid:aChatroom.chatroomId];
    
//    CGRect frame = self.chatToolbar.frame;
//    [self showHint:[NSString stringWithFormat:NSEaseLocalizedString(@"chatroom.leave", @"\'%@\'leave chatroom\'%@\'"), aUsername, aChatroom.chatroomId] yOffset:-frame.size.height + KHintAdjustY];
}

- (void)didReceiveKickedFromChatroom:(EMChatroom *)aChatroom
                              reason:(EMChatroomBeKickedReason)aReason
{
  //  DLog(@"%@  ---  %u",aChatroom,aReason);
   // DLog(@"++++++++++_______+++++++++++   接收到被踢出聊天室");
    
    if ([_conversation.conversationId isEqualToString:aChatroom.chatroomId])
    {
//        if(self.m_isTopicChatRoom)
//        {
            if (aReason==EMChatroomBeKickedReasonDestroyed) {
                 [self.chatToolbar endEditing:YES];
                EaseChatToolbar *toolbar = (EaseChatToolbar*)self.chatToolbar;
                toolbar.m_title.text=@"聊天室已结束";
                toolbar.inputTextView.text=@"";
                toolbar.inputTextView.placeHolder=@"";
                [toolbar.m_topicForbitView setHidden:NO];
                
            }
        
//        }
    }
}
#pragma mark - EMGroupManagerDelegate   群组代理

#pragma mark - getter

- (UIImagePickerController *)imagePicker
{
    if (_imagePicker == nil) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.modalPresentationStyle= UIModalPresentationOverFullScreen;
        _imagePicker.delegate = self;
    }
    
    return _imagePicker;
}
-(NSMutableArray*)atTargets
{
    if (!_atTargets) {
        _atTargets = [NSMutableArray array];
    }
    return _atTargets;
}
#pragma mark - setter

- (void)setIsViewDidAppear:(BOOL)isViewDidAppear
{
    _isViewDidAppear =isViewDidAppear;
    if (_isViewDidAppear)
    {
        NSMutableArray *unreadMessages = [NSMutableArray array];
        for (EMMessage *message in self.messsagesSource)
        {
            if ([self _shouldSendHasReadAckForMessage:message read:NO])
            {
                [unreadMessages addObject:message];
            }
        }
        if ([unreadMessages count])
        {
            [self _sendHasReadResponseForMessages:unreadMessages isRead:YES];
        }
        EMError *error;
        [_conversation markAllMessagesAsRead:&error];
    }
}

- (void)setChatToolbar:(EaseChatToolbar *)chatToolbar
{
    [_chatToolbar removeFromSuperview];
    
    _chatToolbar = chatToolbar;
    if (_chatToolbar) {
        [self.view addSubview:_chatToolbar];
    }
    
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = self.view.frame.size.height - _chatToolbar.frame.size.height;
    self.tableView.frame = tableFrame;
    if ([chatToolbar isKindOfClass:[EaseChatToolbar class]]) {
        [(EaseChatToolbar *)self.chatToolbar setDelegate:self];
        self.chatBarMoreView = (EaseChatBarMoreView*)[(EaseChatToolbar *)self.chatToolbar moreView];
        self.faceView = (EaseFaceView*)[(EaseChatToolbar *)self.chatToolbar faceView];
        self.recordView = (EaseRecordView*)[(EaseChatToolbar *)self.chatToolbar recordView];
    }
}

- (void)setDataSource:(id<EaseMessageViewControllerDataSource>)dataSource
{
    _dataSource = dataSource;
    
    [self setupEmotion];
}

- (void)setDelegate:(id<EaseMessageViewControllerDelegate>)delegate
{
    _delegate = delegate;
}

#pragma mark - private helper

- (void)_scrollViewToBottom:(BOOL)animated
{
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset;
        offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:animated];
    }
}

- (BOOL)_canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                bCanRecord = granted;
            }];
        }
    }
    
    return bCanRecord;
}

- (void)_showMenuViewController:(UIView *)showInView
                   andIndexPath:(NSIndexPath *)indexPath
                    messageType:(EMMessageBodyType)messageType
{
    if (_menuController == nil) {
        _menuController = [UIMenuController sharedMenuController];
    }
    
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:NSEaseLocalizedString(@"delete", @"Delete") action:@selector(deleteMenuAction:)];
    }
    
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:NSEaseLocalizedString(@"copy", @"Copy") action:@selector(copyMenuAction:)];
    }
    
    if (messageType == EMMessageBodyTypeText) {
        [_menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem]];
    } else {
        [_menuController setMenuItems:@[_deleteMenuItem]];
    }
    [_menuController setTargetRect:showInView.frame inView:showInView.superview];
    [_menuController setMenuVisible:YES animated:YES];
}

- (void)_stopAudioPlayingWithChangeCategory:(BOOL)isChange
{
    //停止音频播放及播放动画
    [[EMCDDeviceManager sharedInstance] stopPlaying];
    [[EMCDDeviceManager sharedInstance] disableProximitySensor];
    [EMCDDeviceManager sharedInstance].delegate = nil;
    
    //    MessageModel *playingModel = [self.EaseMessageReadManager stopMessageAudioModel];
    //    NSIndexPath *indexPath = nil;
    //    if (playingModel) {
    //        indexPath = [NSIndexPath indexPathForRow:[self.dataSource indexOfObject:playingModel] inSection:0];
    //    }
    //
    //    if (indexPath) {
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [self.tableView beginUpdates];
    //            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    //            [self.tableView endUpdates];
    //        });
    //    }
}

- (NSURL *)_convert2Mp4:(NSURL *)movUrl
{
    NSURL *mp4Url = nil;
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        NSString *mp4Path = [NSString stringWithFormat:@"%@/%d%d.mp4", [EMCDDeviceManager dataPath], (int)[[NSDate date] timeIntervalSince1970], arc4random() % 100000];
        mp4Url = [NSURL fileURLWithPath:mp4Path];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        dispatch_semaphore_t wait = dispatch_semaphore_create(0l);
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed: {
                    NSLog(@"failed, error:%@.", exportSession.error);
                } break;
                case AVAssetExportSessionStatusCancelled: {
                    NSLog(@"cancelled.");
                } break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"completed.");
                } break;
                default: {
                    NSLog(@"others.");
                } break;
            }
            dispatch_semaphore_signal(wait);
        }];
        long timeout = dispatch_semaphore_wait(wait, DISPATCH_TIME_FOREVER);
        if (timeout) {
            NSLog(@"timeout.");
        }
        if (wait) {
            //dispatch_release(wait);
            wait = nil;
        }
    }
    
    return mp4Url;
}

- (EMChatType)_messageTypeFromConversationType
{
    EMChatType type = EMChatTypeChat;
    switch (self.conversation.type) {
        case EMConversationTypeChat:
            type = EMChatTypeChat;
            break;
        case EMConversationTypeGroupChat:
            type = EMChatTypeGroupChat;
            break;
        case EMConversationTypeChatRoom:
            type = EMChatTypeChatRoom;
            break;
        default:
            break;
    }
    return type;
}

- (void)_downloadMessageAttachments:(EMMessage *)message
{
    __weak typeof(self) weakSelf = self;
    void (^completion)(EMMessage *aMessage, EMError *error) = ^(EMMessage *aMessage, EMError *error) {
        if (!error)
        {
            [weakSelf _reloadTableViewDataWithMessage:message];
        }
        else
        {
            [weakSelf showHint:NSEaseLocalizedString(@"message.thumImageFail", @"thumbnail for failure!")];
        }
    };
    
    EMMessageBody *messageBody = message.body;
    if ([messageBody type] == EMMessageBodyTypeImage) {
        EMImageMessageBody *imageBody = (EMImageMessageBody *)messageBody;
        if (imageBody.thumbnailDownloadStatus > EMDownloadStatusSuccessed)
        {
            //下载缩略图
            [[[EMClient sharedClient] chatManager] downloadMessageThumbnail:message progress:nil completion:completion];
        }
    }
    else if ([messageBody type] == EMMessageBodyTypeVideo)
    {
        EMVideoMessageBody *videoBody = (EMVideoMessageBody *)messageBody;
        if (videoBody.thumbnailDownloadStatus > EMDownloadStatusSuccessed)
        {
            //下载缩略图
            [[[EMClient sharedClient] chatManager] downloadMessageThumbnail:message progress:nil completion:completion];
        }
    }
    else if ([messageBody type] == EMMessageBodyTypeVoice)
    {
        EMVoiceMessageBody *voiceBody = (EMVoiceMessageBody*)messageBody;
        if (voiceBody.downloadStatus > EMDownloadStatusSuccessed)
        {
            //下载语言
            [[EMClient sharedClient].chatManager downloadMessageAttachment:message progress:nil completion:completion];
        }
    }
}

- (BOOL)_shouldSendHasReadAckForMessage:(EMMessage *)message
                                   read:(BOOL)read
{
    NSString *account = [[EMClient sharedClient] currentUsername];
    if (message.chatType != EMChatTypeChat || message.isReadAcked || [account isEqualToString:message.from] || ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) || !self.isViewDidAppear)
    {
        return NO;
    }
    
    EMMessageBody *body = message.body;
    if (((body.type == EMMessageBodyTypeVideo) ||
         (body.type == EMMessageBodyTypeVoice) ||
         (body.type == EMMessageBodyTypeImage)) &&
        !read)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}


- (void)_sendHasReadResponseForMessages:(NSArray*)messages
                                 isRead:(BOOL)isRead
{
    NSMutableArray *unreadMessages = [NSMutableArray array];
    for (NSInteger i = 0; i < [messages count]; i++)
    {
        EMMessage *message = messages[i];
        BOOL isSend = YES;
        if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewController:shouldSendHasReadAckForMessage:read:)]) {
            isSend = [_dataSource messageViewController:self
                         shouldSendHasReadAckForMessage:message read:isRead];
        }
        else{
            isSend = [self _shouldSendHasReadAckForMessage:message
                                                      read:isRead];
        }
        
        if (isSend)
        {
            [unreadMessages addObject:message];
        }
    }
    
    if ([unreadMessages count])
    {
        for (EMMessage *message in unreadMessages)
        {
            [[EMClient sharedClient].chatManager sendMessageReadAck:message completion:nil];
        }
    }
}

- (BOOL)_shouldMarkMessageAsRead
{
    BOOL isMark = YES;
    if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewControllerShouldMarkMessagesAsRead:)]) {
        isMark = [_dataSource messageViewControllerShouldMarkMessagesAsRead:self];
    }
    else{
        if (([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) || !self.isViewDidAppear)
        {
            isMark = NO;
        }
    }
    
    return isMark;
}

- (void)_videoMessageCellSelected:(id<IMessageModel>)model
{
    _scrollToBottomWhenAppear = NO;
    
    EMVideoMessageBody *videoBody = (EMVideoMessageBody*)model.message.body;
    
    //判断本地路劲是否存在
    NSString *localPath = [model.fileLocalPath length] > 0 ? model.fileLocalPath : videoBody.localPath;
    if ([localPath length] == 0) {
        [self showHint:NSEaseLocalizedString(@"message.videoFail", @"video for failure!")];
        return;
    }
    
    dispatch_block_t block = ^{
        //发送已读回执
        [self _sendHasReadResponseForMessages:@[model.message]
                                       isRead:YES];
        
        NSURL *videoURL = [NSURL fileURLWithPath:localPath];
        MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
        [moviePlayerController.moviePlayer prepareToPlay];
        moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [self presentMoviePlayerViewControllerAnimated:moviePlayerController];
    };
    
    __weak typeof(self) weakSelf = self;
//    void (^completion)(EMMessage *aMessage, EMError *error) = ^(EMMessage *aMessage, EMError *error) {
//        if (!error)
//        {
//            [weakSelf _reloadTableViewDataWithMessage:aMessage];
//        }
//        else
//        {
//            [weakSelf showHint:NSEaseLocalizedString(@"message.thumImageFail", @"thumbnail for failure!")];
//        }
//    };
    
//    if (videoBody.thumbnailDownloadStatus == EMDownloadStatusFailed || ![[NSFileManager defaultManager] fileExistsAtPath:videoBody.thumbnailLocalPath]) {
//        [self showHint:@"begin downloading thumbnail image, click later"];
//        [[EMClient sharedClient].chatManager asyncDownloadMessageThumbnail:model.message progress:nil completion:completion];
//        return;
//    }
    
    if (videoBody.downloadStatus == EMDownloadStatusSuccessed && [[NSFileManager defaultManager] fileExistsAtPath:localPath])
    {
        block();
        return;
    }
    
    [self showHudInView:self.view hint:NSEaseLocalizedString(@"message.downloadingVideo", @"downloading video...")];
    [[EMClient sharedClient].chatManager downloadMessageAttachment:model.message progress:nil completion:^(EMMessage *message, EMError *error) {
        [weakSelf hideHud];
        if (!error) {
            block();
        }else{
            [weakSelf showHint:NSEaseLocalizedString(@"message.videoFail", @"video for failure!")];
        }
    }];
}

- (void)_imageMessageCellSelected:(id<IMessageModel>)model
{
    __weak EaseMessageViewController *weakSelf = self;
    EMImageMessageBody *imageBody = (EMImageMessageBody*)[model.message body];
    
    if ([imageBody type] == EMMessageBodyTypeImage) {
        if (imageBody.thumbnailDownloadStatus == EMDownloadStatusSuccessed) {
            if (imageBody.downloadStatus == EMDownloadStatusSuccessed)
            {
                //发送已读回执
                [weakSelf _sendHasReadResponseForMessages:@[model.message] isRead:YES];
                NSString *localPath = model.message == nil ? model.fileLocalPath : [imageBody localPath];
                if (localPath && localPath.length > 0) {
                    UIImage *image = [UIImage imageWithContentsOfFile:localPath];
                    
                    if (image)
                    {
                        [[EaseMessageReadManager defaultManager] showBrowserWithImages:@[image]];
                    }
                    else
                    {
                        NSLog(@"Read %@ failed!", localPath);
                    }
                    return;
                }
            }
            [weakSelf showHudInView:weakSelf.view hint:NSEaseLocalizedString(@"message.downloadingImage", @"downloading a image...")];

              [[EMClient sharedClient].chatManager downloadMessageAttachment:model.message progress:nil completion:^(EMMessage *message, EMError *error) {
            
                [weakSelf hideHud];
                if (!error) {
                    //发送已读回执
                    [weakSelf _sendHasReadResponseForMessages:@[model.message] isRead:YES];
                    NSString *localPath = message == nil ? model.fileLocalPath : [(EMImageMessageBody*)message.body localPath];
                    if (localPath && localPath.length > 0) {
                        UIImage *image = [UIImage imageWithContentsOfFile:localPath];
                        //                                weakSelf.isScrollToBottom = NO;
                        if (image)
                        {
                            [[EaseMessageReadManager defaultManager] showBrowserWithImages:@[image]];
                        }
                        else
                        {
                            NSLog(@"Read %@ failed!", localPath);
                        }
                        return ;
                    }
                }
                [weakSelf showHint:NSEaseLocalizedString(@"message.imageFail", @"image for failure!")];
            }];
        }else{
            //获取缩略图
            [[EMClient sharedClient].chatManager downloadMessageThumbnail:model.message progress:nil completion:^(EMMessage *message, EMError *error) {
                if (!error) {
                    [weakSelf _reloadTableViewDataWithMessage:model.message];
                }else{
                    [weakSelf showHint:NSEaseLocalizedString(@"message.thumImageFail", @"thumbnail for failure!")];
                }
            }];
        }
    }
}

- (void)_audioMessageCellSelected:(id<IMessageModel>)model
{
    _scrollToBottomWhenAppear = NO;
    EMVoiceMessageBody *body = (EMVoiceMessageBody*)model.message.body;
    EMDownloadStatus downloadStatus = [body downloadStatus];
    if (downloadStatus == EMDownloadStatusDownloading) {
        [self showHint:NSEaseLocalizedString(@"message.downloadingAudio", @"downloading voice, click later")];
        return;
    }
    else if (downloadStatus == EMDownloadStatusFailed)
    {
        [self showHint:NSEaseLocalizedString(@"message.downloadingAudio", @"downloading voice, click later")];
        [[EMClient sharedClient].chatManager downloadMessageAttachment:model.message progress:nil completion:NULL];
        return;
    }
    
    // 播放音频
    if (model.bodyType == EMMessageBodyTypeVoice) {
        //发送已读回执
        [self _sendHasReadResponseForMessages:@[model.message] isRead:YES];
        __weak EaseMessageViewController *weakSelf = self;
        BOOL isPrepare = [[EaseMessageReadManager defaultManager] prepareMessageAudioModel:model updateViewCompletion:^(EaseMessageModel *prevAudioModel, EaseMessageModel *currentAudioModel) {
            if (prevAudioModel || currentAudioModel) {
                [weakSelf.tableView reloadData];
            }
        }];
        
        if (isPrepare) {
            _isPlayingAudio = YES;
            __weak EaseMessageViewController *weakSelf = self;
            [[EMCDDeviceManager sharedInstance] enableProximitySensor];
            [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:model.fileLocalPath completion:^(NSError *error) {
                [[EaseMessageReadManager defaultManager] stopMessageAudioModel];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                    weakSelf.isPlayingAudio = NO;
                    [[EMCDDeviceManager sharedInstance] disableProximitySensor];
                });
            }];
        }
        else{
            _isPlayingAudio = NO;
        }
    }
}

#pragma mark - pivate data

- (void)_loadMessagesBefore:(NSString*)messageId
                      count:(NSInteger)count
                     append:(BOOL)isAppend
{
    __weak typeof(self) weakSelf = self;
    if(!_messageQueue)
    {
        _messageQueue = dispatch_queue_create("hyphenate.com", NULL);
    }
//    dispatch_async(_messageQueue, ^{
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *moreMessages = nil;
        if (weakSelf.dataSource && [weakSelf.dataSource respondsToSelector:@selector(messageViewController:loadMessageFromTimestamp:count:)]) {
//            moreMessages = [weakSelf.dataSource messageViewController:weakSelf loadMessageFromTimestamp:timestamp count:count];
        }
        else
        {
//            moreMessages = [weakSelf.conversation loadMoreMessagesFromId:messageId limit:(int)count];报错3.0.1-3.1.4
            moreMessages = [weakSelf.conversation loadMoreMessagesFromId:messageId limit:(int)count direction:EMMessageSearchDirectionUp];
            
        }
       
        if ([moreMessages count] == 0) {
            return;
        }
        
        //格式化消息
        NSArray *formattedMessages = [weakSelf formatMessages:moreMessages];
        
        if ([formattedMessages count] == 0) {
            return;
        }
        
        
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger scrollToIndex = 0;
        if (isAppend) {
            [weakSelf.messsagesSource insertObjects:moreMessages atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [moreMessages count])]];
            
            //合并消息
            id object = [weakSelf.dataArray firstObject];
            if ([object isKindOfClass:[NSString class]])
            {
                NSString *timestamp = object;
                [formattedMessages enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id model, NSUInteger idx, BOOL *stop) {
                    if ([model isKindOfClass:[NSString class]] && [timestamp isEqualToString:model])
                    {
                        [weakSelf.dataArray removeObjectAtIndex:0];
                        *stop = YES;
                    }
                }];
            }
            scrollToIndex = [weakSelf.dataArray count];
            [weakSelf.dataArray insertObjects:formattedMessages atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [formattedMessages count])]];
        }
        else{
            [weakSelf.messsagesSource removeAllObjects];
            [weakSelf.messsagesSource addObjectsFromArray:moreMessages];
            
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.dataArray addObjectsFromArray:formattedMessages];
        }
        
        EMMessage *latest = [weakSelf.messsagesSource lastObject];
        weakSelf.messageTimeIntervalTag = latest.timestamp;
        if ([weakSelf.dataArray count] == 0) {
            return;
        }
        //刷新页面
      
            [weakSelf.tableView reloadData];
            
              //  DLog(@"dataArray--%lu===scrollToIndex--%li",(unsigned long)self.dataArray.count,(long)scrollToIndex);
         if (!self.m_Down || self.conversation.type == EMConversationTypeChat || self.conversation.type == EMConversationTypeGroupChat) {
                 [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArray count] - scrollToIndex - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
         }
        
        });
        
        //从数据库导入时重新下载没有下载成功的附件
        for (EMMessage *message in moreMessages)
        {
            [weakSelf _downloadMessageAttachments:message];
        }
        
        //发送已读回执
        [weakSelf _sendHasReadResponseForMessages:moreMessages
                                       isRead:NO];
    });
}

#pragma mark - GestureRecognizer

// 点击背景隐藏
-(void)keyBoardHidden:(UITapGestureRecognizer *)tapRecognizer
{
    if (tapRecognizer.state == UIGestureRecognizerStateEnded) {
        [self.chatToolbar endEditing:YES];
////如果屏幕是375一下的机型在隐藏键盘的时候让新闻下拉下来 375 = 苹果6的尺寸 为了让6以前的机型能看到的屏更多些
//    if (LCDW < 375) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:k_PutDownNewS object:nil];
//        [[NSNotificationCenter defaultCenter]postNotificationName:k_PutDownNewSGroup object:nil];
//    }
    
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan && [self.dataArray count] > 0)
    {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        BOOL canLongPress = NO;
        if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewController:canLongPressRowAtIndexPath:)]) {
            canLongPress = [_dataSource messageViewController:self
                                   canLongPressRowAtIndexPath:indexPath];
        }
        
        if (!canLongPress) {
          
            return;
            
        }
        
        if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewController:didLongPressRowAtIndexPath:)]) {
            [_dataSource messageViewController:self
                    didLongPressRowAtIndexPath:indexPath];
        }
        
        else{
            id object = [self.dataArray objectAtIndex:indexPath.row];
            if (![object isKindOfClass:[NSString class]]) {
                EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                [cell becomeFirstResponder];
                _menuIndexPath = indexPath;
                [self _showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
            }
        }
    }
}

#pragma mark - Table view data source
- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    
//    if (self.m_isChatInterface) {
    
//        if (self.m_ChatRoom2==EMConversationTypeChatRoom) {
            /**
             *  这里是判断是否TableView滑到底了
             */
            
            
            
            CGPoint contentOffsetPoint = self.tableView.contentOffset;
            CGRect frame = self.tableView.frame;
            
         //   DLog(@"contentOffsetPoint.y = %f",contentOffsetPoint.y);
         //   DLog(@"self.tableView.contentSize.height = %f",self.tableView.contentSize.height);
         //   DLog(@"frame.size.height = %f",frame.size.height);
            //  if ( self.tableView.contentSize.height >self.tableView.frame.size.height) {
            
            if ((self.tableView.contentSize.height > self.tableView.frame.size.height) &&( (contentOffsetPoint.y + self.m_lastCellHigh)>= (self.tableView.contentSize.height - frame.size.height)) )
            {
                //        DLog(@"contentOffsetPoint.y = %f     --   %f",contentOffsetPoint.y,(self.tableView.contentSize.height - frame.size.height));
                //        DLog(@"或者  self.tableView.contentSize.height = %f      +++++   frame.size.height = %f   ",frame.size.height);
               // NSLog(@"在");
                self.m_Down = YES;
                if (self.m_ChatRoom2!=EMConversationTypeChat) {
                    //        //让TableView滚动到底部
                    //        [self.tableView setContentOffset:CGPointMake(0,self.tableView.contentSize.height - self.tableView.frame.size.height +44) animated:YES];
                    //让新消息消失
                    [[NSNotificationCenter defaultCenter]postNotificationName:K_NONEWMessage object:nil];
                }
               // NSLog(@"scroll to the end");
            }else  if ((self.tableView.contentSize.height - frame.size.height)-contentOffsetPoint.y > self.m_lastCellHigh){
              //  DLog(@"%f",self.tableView.contentSize.height - frame.size.height );
             //   DLog(@"%f",contentOffsetPoint.y);
                
                
                self.m_Down = NO;
               // NSLog(@"不");
                
            }else{
                
                //NSLog(@"见了鬼！！！");
            }
            //DLog(@"---------   %f",scrollView.contentOffset.y);
//        }
//    }
    
    //    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}
//-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
////    if (indexPath.row == self.dataArray.count-1) {
////          self.m_Down = YES;
////        [self _scrollViewToBottom:NO];
////    }else{
////         self.m_Down = NO;
////    }
//    
////    CGPoint contentOffsetPoint = self.tableView.contentOffset;
////    CGRect frame = self.tableView.frame;
////    if ((self.tableView.contentSize.height > self.tableView.frame.size.height) &&( (contentOffsetPoint.y + self.m_lastCellHigh)>= (self.tableView.contentSize.height - frame.size.height)) )
////    {
////        //        DLog(@"contentOffsetPoint.y = %f     --   %f",contentOffsetPoint.y,(self.tableView.contentSize.height - frame.size.height));
////        //        DLog(@"或者  self.tableView.contentSize.height = %f      +++++   frame.size.height = %f   ",frame.size.height);
////        NSLog(@"在");
////        //                self.m_Down = YES;
////        if (self.m_ChatRoom2!=EMConversationTypeChat) {
////            //        //让TableView滚动到底部
////            //        [self.tableView setContentOffset:CGPointMake(0,self.tableView.contentSize.height - self.tableView.frame.size.height +44) animated:YES];
////            //让新消息消失
////            [[NSNotificationCenter defaultCenter]postNotificationName:K_NONEWMessage object:nil];
////        }
////        NSLog(@"scroll to the end");
////    }
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataArray objectAtIndex:indexPath.row];
    
    //时间cell
    if ([object isKindOfClass:[NSString class]]) {
        NSString *TimeCellIdentifier = [EaseMessageTimeCell cellIdentifier];
        EaseMessageTimeCell *timeCell = (EaseMessageTimeCell *)[tableView dequeueReusableCellWithIdentifier:TimeCellIdentifier];
        
        if (timeCell == nil) {
            timeCell = [[EaseMessageTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TimeCellIdentifier];
            timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        timeCell.title = object;
        return timeCell;
    }
   
    else{
       
        id<IMessageModel> model = object;
        if (_delegate && [_delegate respondsToSelector:@selector(messageViewController:cellForMessageModel:)]) {
            UITableViewCell *cell = [_delegate messageViewController:tableView cellForMessageModel:model];
            if (cell) {
                if ([cell isKindOfClass:[EaseMessageCell class]]) {
                    EaseMessageCell *emcell= (EaseMessageCell*)cell;
                    if (emcell.delegate == nil) {
                        emcell.delegate = self;
                    }
                }
                return cell;
            }
        }
        
//        if (_delegate && [_delegate respondsToSelector:@selector(shareCustomViewController:cellForMessageModel:indexPath:)])
//        {
//            CustomShareTableViewCell * customMessageCell = (CustomShareTableViewCell*)[_delegate shareCustomViewController:tableView cellForMessageModel:model indexPath:indexPath];
//            if (customMessageCell)
//            {
//                return customMessageCell;
//            }
//        }
        if (_delegate && [_delegate respondsToSelector:@selector(messageCustomViewController:cellForMessageModel:indexPath:)])
        {
            CustomMessageTableViewCell * customMessageCell = (CustomMessageTableViewCell*)[_delegate messageCustomViewController:tableView cellForMessageModel:model indexPath:indexPath];
            if (customMessageCell)
            {
                return customMessageCell;
            }
            
        }

     
        if (_delegate && [_delegate respondsToSelector:@selector(messageNoticeViewController:cellForMessageModel:indexPath:)])
        {
            NoticeMessageTableViewCell * noticeMessageCell = (NoticeMessageTableViewCell*)[_delegate messageNoticeViewController:tableView cellForMessageModel:model indexPath:indexPath];
            if (noticeMessageCell)
            {
                return noticeMessageCell;
            }
            
            
        }


        
        
        
        if (_dataSource && [_dataSource respondsToSelector:@selector(isEmotionMessageFormessageViewController:messageModel:)]) {
            BOOL flag = [_dataSource isEmotionMessageFormessageViewController:self messageModel:model];
            if (flag) {
                NSString *CellIdentifier = [EaseCustomMessageCell cellIdentifierWithModel:model];
                //发送cell
                EaseCustomMessageCell *sendCell = (EaseCustomMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                // Configure the cell...
                if (sendCell == nil) {
                    sendCell = [[EaseCustomMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
                    sendCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                if (_dataSource && [_dataSource respondsToSelector:@selector(emotionURLFormessageViewController:messageModel:)]) {
                    EaseEmotion *emotion = [_dataSource emotionURLFormessageViewController:self messageModel:model];
                    if (emotion) {
                        model.image = [UIImage sd_animatedGIFNamed:emotion.emotionOriginal];
                        model.fileURLPath=emotion.emotionOriginal;
//                        model.fileURLPath = emotion.emotionOriginalURL;
                    }
                }
                
              
               
                sendCell.model = model;
                sendCell.delegate = self;
                return sendCell;
            }
        }
       
        NSString *CellIdentifier = [EaseMessageCell cellIdentifierWithModel:model];
        NSString *cellIdentifier2= [NSString stringWithFormat:@"%@-%@",CellIdentifier,self.conversation.conversationId];
  
        EaseBaseMessageCell *sendCell = (EaseBaseMessageCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        //6.26 xiong
//        if(self.m_adminIdArr.count>0)
//        {
//            [model.m_adminIdArr removeAllObjects];
//            [model.m_adminIdArr addObjectsFromArray: self.m_adminIdArr];
//        }
//        
//        
//        model.m_topicOwnerId=self.m_ownerId;
       
        // Configure the cell...
        if (sendCell == nil) {
            sendCell = [[EaseBaseMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2 model:model];
            sendCell.selectionStyle = UITableViewCellSelectionStyleNone;
            sendCell.delegate = self;
        }
      //  DLog(@"didReceiveMessages---%@",model.message.ext);
        
        
        //判断是否显示陌生人来源
        if (self.conversation.type==EMConversationTypeChat&&indexPath.row==1) {
            
            BOOL isFriend=[DTools compareIsFriend:[[model.message.ext objectForKey:K_uid] intValue]];
            if(!model.isSender&&!isFriend)
            {
                NSString *str=[model.message.ext objectForKey:K_MESSAGE_ATTR_FROM];
                [self setnoticeMessageViewText:str isHide:NO];
            }
            if (!model.isSender&&isFriend) {
                [self setnoticeMessageViewText:@"" isHide:YES];
            }
        }
        
       sendCell.model = model;
         sendCell.m_indexPath=indexPath;
        return sendCell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if ([object isKindOfClass:[NSString class]]) {
        return self.timeCellHeight;
    }
    else{
        
        id<IMessageModel> model = object;
        model.m_indexPath=indexPath;
        
        if (_delegate && [_delegate respondsToSelector:@selector(messageViewController:heightForMessageModel:withCellWidth:)]) {
            CGFloat height = [_delegate messageViewController:self heightForMessageModel:model withCellWidth:tableView.frame.size.width];
            if (height) {
                if (indexPath.row == self.dataArray.count-1)
                {
                    self.m_lastCellHigh = height;
                }
                return height;
            }
        }
        
        if (_dataSource && [_dataSource respondsToSelector:@selector(isCustomMessageFormessageViewController:messageModel:indexPath:)])
        {
            BOOL flag = [_dataSource isCustomMessageFormessageViewController:self messageModel:model indexPath:indexPath];
            if (flag) {
                if (indexPath.row == self.dataArray.count-1)
                {
                    self.m_lastCellHigh = 122;
                }
                return 122;
            }
        }
        if (_dataSource && [_dataSource respondsToSelector:@selector(isNoticeMessageFormessageViewController:messageModel:indexPath:)]) {
            CGFloat height = [_dataSource isNoticeMessageFormessageViewController:self messageModel:model indexPath:indexPath];
            if (height>0)
            {
                if (indexPath.row == self.dataArray.count-1)
                {
                    self.m_lastCellHigh = height;
                }
                return height;
            }
        }
        if (_dataSource && [_dataSource respondsToSelector:@selector(isEmotionMessageFormessageViewController:messageModel:)]) {
            BOOL flag = [_dataSource isEmotionMessageFormessageViewController:self messageModel:model];
            if (flag) {
                if (indexPath.row == self.dataArray.count-1)
                {
                    self.m_lastCellHigh =  [EaseCustomMessageCell cellHeightWithModel:model];
                }
                return [EaseCustomMessageCell cellHeightWithModel:model];
            }
        }
        
        //在计算高度的时候  如果这里不赋值 则他会进入不是群组的气泡约束  以至于有时候发的字间距是对的 有时候就间距不对
        //6.26 xiong
//        if(self.m_adminIdArr.count>0)
//        {
//            [model.m_adminIdArr removeAllObjects];
//            [model.m_adminIdArr addObjectsFromArray: self.m_adminIdArr];
//        }
//        
//        model.m_topicOwnerId=self.m_ownerId;
      
        if (indexPath.row == self.dataArray.count-1)
        {
            self.m_lastCellHigh =  [EaseBaseMessageCell cellHeightWithModel:model];
        }

        return [EaseBaseMessageCell cellHeightWithModel:model];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.menuIndexPath = indexPath;
}
//- ( UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    
//    
//    
//    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"NoticeMessageTableViewCell" owner:nil options:nil];
//    
//    // Find the view among nib contents (not too hard assuming there is only one view in it).
//   NoticeMessageTableViewCell * customMessageCell = [nibContents lastObject];
//    
////     self.m_noticeHeight=45;
//    
//     customMessageCell.m_titleLab.text=@"来源于哪哪哪";
//    return customMessageCell;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 45;
//}
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *videoURL = info[UIImagePickerControllerMediaURL];
        // video url:
        // file:///private/var/mobile/Applications/B3CDD0B2-2F19-432B-9CFA-158700F4DE8F/tmp/capture-T0x16e39100.tmp.9R8weF/capturedvideo.mp4
        // we will convert it to mp4 format
        NSURL *mp4 = [self _convert2Mp4:videoURL];
        NSFileManager *fileman = [NSFileManager defaultManager];
        if ([fileman fileExistsAtPath:videoURL.path]) {
            NSError *error = nil;
            [fileman removeItemAtURL:videoURL error:&error];
            if (error) {
                NSLog(@"failed to remove file, error:%@.", error);
            }
        }
        [self sendVideoMessageWithURL:mp4];
        
    }else{
        
        NSURL *url = info[UIImagePickerControllerReferenceURL];
        if (url == nil) {
            UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
            [self sendImageMessage:orgImage];
        } else {
            if ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0f) {
                PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
                [result enumerateObjectsUsingBlock:^(PHAsset *asset , NSUInteger idx, BOOL *stop){
                    if (asset) {
                        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:nil resultHandler:^(NSData *data, NSString *uti, UIImageOrientation orientation, NSDictionary *dic){
                            if (data.length > 10 * 1000 * 1000) {
                                [self showHint:@"图片太大了，换个小点的"];
                                return;
                            }
                            if (data != nil) {
                                [self sendImageMessageWithData:data compressionRatio:0.6];
                            } else {
                                [self showHint:@"图片太大了，换个小点的"];
                            }
                        }];
                    }
                }];
            } else {
                ALAssetsLibrary *alasset = [[ALAssetsLibrary alloc] init];
                [alasset assetForURL:url resultBlock:^(ALAsset *asset) {
                    if (asset) {
                        ALAssetRepresentation* assetRepresentation = [asset defaultRepresentation];
                        Byte* buffer = (Byte*)malloc((size_t)[assetRepresentation size]);
                        NSUInteger bufferSize = [assetRepresentation getBytes:buffer fromOffset:0.0 length:(NSUInteger)[assetRepresentation size] error:nil];
                       // Byte* buffer = (Byte*)malloc([assetRepresentation size]);
                     //   NSUInteger bufferSize = [assetRepresentation getBytes:buffer fromOffset:0.0 length:[assetRepresentation size] error:nil];
                        NSData* fileData = [NSData dataWithBytesNoCopy:buffer length:bufferSize freeWhenDone:YES];
                        if (fileData.length > 10 * 1000 * 1000) {
                            [self showHint:@"图片太大了，换个小点的"];
                            return;
                        }
                        [self sendImageMessageWithData:fileData compressionRatio:0.6];
                    }
                } failureBlock:NULL];
            }
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.isViewDidAppear = YES;
    [[EaseSDKHelper shareHelper] setIsShowingimagePicker:NO];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    self.isViewDidAppear = YES;
    [[EaseSDKHelper shareHelper] setIsShowingimagePicker:NO];
}

#pragma mark - EaseMessageCellDelegate
-(void)messageTextButton:(id<IMessageModel>)model :(NSIndexPath *)indexPath :(UIButton *)sender
{
        if ([DTools compareTouch:[self tellMeTimeTwo]KName:k_ClickTimeArray] )
        {
            
            model.m_isSelect=NO;
            if(sender.selected==NO)
            {
                sender.selected=YES;
                [sender setBackgroundColor:RGBACOLOR(179, 179, 179, 1) ];
                sender.userInteractionEnabled=NO;
                model.m_isSelect=YES;
            }
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
            
            if([self.delegate respondsToSelector:@selector(clickInterestButton:)])
            {
                [self.delegate clickInterestButton:model];
            }

        }
        else{
            UIAlertController * alert  = [UIAlertController alertControllerWithTitle:@"提示：" message:@"点的太快了，休息一会" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    
            [alert addAction:action];
    
            [self presentViewController:alert animated:YES completion:nil];
            //            [SVProgressHUD showInfoWithStatus:InterestedMessage];
            //             [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];//设置提示框背景
            DLog(@"时间还未到");
    
        }
   
    
    
}

- (void)messageCellSelected:(id<IMessageModel>)model
{
    if (_delegate && [_delegate respondsToSelector:@selector(messageViewController:didSelectMessageModel:)]) {
        BOOL flag = [_delegate messageViewController:self didSelectMessageModel:model];
        if (flag) {
            [self _sendHasReadResponseForMessages:@[model.message] isRead:YES];
            return;
        }
    }
  
  
        
    switch (model.bodyType) {
        case EMMessageBodyTypeText:
        {
            int cid=[[model.message.ext objectForKey:K_CID_TOPIC] intValue];
            if(cid>0)
            {
                if ([self.delegate respondsToSelector:@selector(clickTextButton:)])
                {
                    [self.delegate clickTextButton:model];
                }
                
            }
        }
            break;
        case EMMessageBodyTypeImage:
        {
            _scrollToBottomWhenAppear = NO;
            [self _imageMessageCellSelected:model];
        }
            break;
        case EMMessageBodyTypeLocation:
        {
//             [self _locationMessageCellSelected:model];
        }
            break;
        case EMMessageBodyTypeVoice:
        {
            [self _audioMessageCellSelected:model];
        }
            break;
        case EMMessageBodyTypeVideo:
        {
            [self _videoMessageCellSelected:model];

        }
            break;
        case EMMessageBodyTypeFile:
        {
            _scrollToBottomWhenAppear = NO;
            [self showHint:@"Custom implementation!"];
        }
            break;
        default:
            break;
    
    }
}

- (void)statusButtonSelcted:(id<IMessageModel>)model withMessageCell:(EaseMessageCell*)messageCell
{
    if ((model.messageStatus != EMMessageStatusFailed) && (model.messageStatus != EMMessageStatusPending))
    {
        return;
    }
    
    __weak typeof(self) weakself = self;
    [[[EMClient sharedClient] chatManager] resendMessage:model.message progress:nil completion:^(EMMessage *message, EMError *error) {
        
        if (!error) {
            //这里判断消息类型 7为
            int   a = [[model.message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue];
            if (a == 7) {
                
                [weakself getNetshareNewsUrl:[model.message.ext objectForKey:K_MESSAGE_ATTR_NEWS_URL]];
                
            }
            [weakself _refreshAfterSentMessage:message];
        }
        else {
            [weakself.tableView reloadData];
        }
        
    }];
    
    [self.tableView reloadData];
}

- (void)avatarViewSelcted:(id<IMessageModel>)model
{
    if (_delegate && [_delegate respondsToSelector:@selector(messageViewController:didSelectAvatarMessageModel:)]) {
        [_delegate messageViewController:self didSelectAvatarMessageModel:model];
        
        return;
    }
    
    _scrollToBottomWhenAppear = NO;
}

#pragma mark - EMChatToolbarDelegate

- (void)chatToolbarDidChangeFrameToHeight:(CGFloat)toHeight
{
    self.toHeight = toHeight;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.tableView.frame;
        
////        if (LCDW < 375) {
        if (toHeight > 90) {
            
            rect.origin.y = 0;
            if (self.conversation.type == EMConversationTypeChat || self.conversation.type == EMConversationTypeChatRoom) {
                rect.size.height = self.view.frame.size.height - toHeight;
            }else{
            //6.26 xiong
//            rect.size.height = self.view.frame.size.height - toHeight-self.newsHeight + 125 -10;
            }
            
        }else{
//            self.m_Down = NO;
            if ( self.m_chatRoomType == ChatRoomTypeRolePlay) {
                
                //这里减去15是为了贴合新闻框
                rect.origin.y =0 ;
                //Y轴减去了15 高度就要加上15
                rect.size.height = self.view.frame.size.height - toHeight;
                
            }else{
                
                 if (self.conversation.type == EMConversationTypeChat ) {
                     //这里减去15是为了贴合新闻框
                     rect.origin.y =0;
                     //Y轴减去了15 高度就要加上15
                     rect.size.height = self.view.frame.size.height - 46;

                     
                 }
                
            }
           
        }

        NSLog(@"-----gc------------ %f",toHeight);
        
        
        self.tableView.frame = rect;
         
    }];
//    //如果屏幕是375一下的机型在弹出键盘的时候让新闻推上去 375 = 苹果6的尺寸 为了让6以前的机型能看到的屏更多些
//    if (LCDW < 375) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:k_PackUpNewS object:nil];
//        [[NSNotificationCenter defaultCenter]postNotificationName:k_PackUpNewSGroup object:nil];
//    }
    
    //让TableView滚动到底部
    [self  _scrollViewToBottom:YES];
   
}

- (void)inputTextViewWillBeginEditing:(EaseTextView *)inputTextView
{
    if (_menuController == nil) {
        _menuController = [UIMenuController sharedMenuController];
    }
    [_menuController setMenuItems:nil];
}

- (void)didSendText:(NSString *)text
{
    if (text && text.length > 0) {
        text=[[WordFilter sharedInstance] wordSensitivefilter:text];
        [self sendTextMessage:text];
        [self.atTargets removeAllObjects];
    }
}
- (BOOL)didInputAtInLocation:(NSUInteger)location
{
    if ([self.delegate respondsToSelector:@selector(messageViewController:selectAtTarget:)] && self.conversation.type == EMConversationTypeGroupChat) {
        location += 1;
        __weak typeof(self) weakSelf = self;
        [self.delegate messageViewController:self selectAtTarget:^(EaseAtTarget *target) {
            __strong EaseMessageViewController *strongSelf = weakSelf;
            if (strongSelf && target) {
                if ([target.userId length] || [target.nickname length]) {
                    [strongSelf.atTargets addObject:target];
                    NSString *insertStr = [NSString stringWithFormat:@"%@ ", target.nickname ? target.nickname : target.userId];
                    EaseChatToolbar *toolbar = (EaseChatToolbar*)strongSelf.chatToolbar;
                    NSMutableString *originStr = [toolbar.inputTextView.text mutableCopy];
                    NSUInteger insertLocation = location > originStr.length ? originStr.length : location;
                    [originStr insertString:insertStr atIndex:insertLocation];
                    toolbar.inputTextView.text = originStr;
                    toolbar.inputTextView.selectedRange = NSMakeRange(insertLocation + insertStr.length, 0);
                    [toolbar.inputTextView becomeFirstResponder];
                }
            }
            else if (strongSelf) {
                EaseChatToolbar *toolbar = (EaseChatToolbar*)strongSelf.chatToolbar;
                [toolbar.inputTextView becomeFirstResponder];
            }
        }];
        EaseChatToolbar *toolbar = (EaseChatToolbar*)self.chatToolbar;
        toolbar.inputTextView.text = [NSString stringWithFormat:@"%@@", toolbar.inputTextView.text];
        [toolbar.inputTextView resignFirstResponder];
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)didDeleteCharacterFromLocation:(NSUInteger)location
{
    EaseChatToolbar *toolbar = (EaseChatToolbar*)self.chatToolbar;
    if ([toolbar.inputTextView.text length] == location + 1) {
        //delete last character
        NSString *inputText = toolbar.inputTextView.text;
        NSRange range = [inputText rangeOfString:@"@" options:NSBackwardsSearch];
        if (range.location != NSNotFound) {
            if (location - range.location > 1) {
                NSString *sub = [inputText substringWithRange:NSMakeRange(range.location + 1, location - range.location - 1)];
                for (EaseAtTarget *target in self.atTargets) {
                    if ([sub isEqualToString:target.userId] || [sub isEqualToString:target.nickname]) {
                        inputText = range.location > 0 ? [inputText substringToIndex:range.location] : @"";
                        toolbar.inputTextView.text = inputText;
                        toolbar.inputTextView.selectedRange = NSMakeRange(inputText.length, 0);
                        [self.atTargets removeObject:target];
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}

- (void)didSendText:(NSString *)text withExt:(NSDictionary*)ext
{
    if ([ext objectForKey:EASEUI_EMOTION_DEFAULT_EXT]) {
        EaseEmotion *emotion = [ext objectForKey:EASEUI_EMOTION_DEFAULT_EXT];
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(emotionExtFormessageViewController:easeEmotion:)]) {
            NSDictionary *ext = [self.dataSource emotionExtFormessageViewController:self easeEmotion:emotion];
            [self sendTextMessage:emotion.emotionTitle withExt:ext];
        } else {
            [self sendTextMessage:emotion.emotionTitle withExt:@{MESSAGE_ATTR_EXPRESSION_ID:emotion.emotionId,MESSAGE_ATTR_IS_BIG_EXPRESSION:@(YES)}];
        }
        return;
    }
    if (text && text.length > 0) {
        [self sendTextMessage:text withExt:ext];
    }
}

/**
 *  按下录音按钮开始录音
 */
- (void)didStartRecordingVoiceAction:(UIView *)recordView
{
    if (![self justIsMessage]||![DTools isCanUseMicrophone])
    {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(messageViewController:didSelectRecordView:withEvenType:)]) {
        [self.delegate messageViewController:self didSelectRecordView:recordView withEvenType:EaseRecordViewTypeTouchDown];
    } else {
        if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
            [(EaseRecordView *)self.recordView recordButtonTouchDown];
        }
    }
    
    if ([self _canRecord]) {
        EaseRecordView *tmpView = (EaseRecordView *)recordView;
       // tmpView.center = self.view.center;
        //2016.3.18 dong
         tmpView.center = CGPointMake(self.view.center.x, self.view.center.y/2);
        [self.view addSubview:tmpView];
        [self.view bringSubviewToFront:recordView];
        int x = arc4random() % 100000;
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSString *fileName = [NSString stringWithFormat:@"%d%d",(int)time,x];
        
        [[EMCDDeviceManager sharedInstance] asyncStartRecordingWithFileName:fileName completion:^(NSError *error)
         {
             if (error) {
                 NSLog(@"%@",NSEaseLocalizedString(@"message.startRecordFail", @"failure to start recording"));
             }
         }];
    }
}

/**
 *  手指向上滑动取消录音
 */
- (void)didCancelRecordingVoiceAction:(UIView *)recordView
{
    [[EMCDDeviceManager sharedInstance] cancelCurrentRecording];
    if ([self.delegate respondsToSelector:@selector(messageViewController:didSelectRecordView:withEvenType:)])
    {
        [self.delegate messageViewController:self didSelectRecordView:recordView withEvenType:EaseRecordViewTypeTouchUpOutside];
    } else {
        if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
            [(EaseRecordView *)self.recordView recordButtonTouchUpOutside];
        }
        [self.recordView removeFromSuperview];
    }
}

/**
 *  松开手指完成录音
 */
- (void)didFinishRecoingVoiceAction:(UIView *)recordView
{
    if ([self.delegate respondsToSelector:@selector(messageViewController:didSelectRecordView:withEvenType:)]) {
        [self.delegate messageViewController:self didSelectRecordView:recordView withEvenType:EaseRecordViewTypeTouchUpInside];
    } else {
        if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
            [(EaseRecordView *)self.recordView recordButtonTouchUpInside];
        }
        [self.recordView removeFromSuperview];
    }
    __weak typeof(self) weakSelf = self;
    [[EMCDDeviceManager sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
        if (!error) {

            
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
            if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
            {
                //无权限
               [self didCancelRecordingVoiceAction:nil];
               
               
            }else
            {
                    [weakSelf sendVoiceMessageWithLocalPath:recordPath duration:aDuration];
            }
            
            
           
            


           
        }
        else {
            [weakSelf showHudInView:self.view hint:NSEaseLocalizedString(@"media.timeShort", @"The recording time is too short")];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf hideHud];
            });
        }
    }];
}

- (void)didDragInsideAction:(UIView *)recordView
{
    if ([self.delegate respondsToSelector:@selector(messageViewController:didSelectRecordView:withEvenType:)]) {
        [self.delegate messageViewController:self didSelectRecordView:recordView withEvenType:EaseRecordViewTypeDragInside];
    } else {
        if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
            [(EaseRecordView *)self.recordView recordButtonDragInside];
        }
    }
}

- (void)didDragOutsideAction:(UIView *)recordView
{
    if ([self.delegate respondsToSelector:@selector(messageViewController:didSelectRecordView:withEvenType:)]) {
        [self.delegate messageViewController:self didSelectRecordView:recordView withEvenType:EaseRecordViewTypeDragOutside];
    } else {
        if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
            [(EaseRecordView *)self.recordView recordButtonDragOutside];
        }
    }
}
-(BOOL)justIsMessage
{
    if ([DTools whetherGlobalSilence])
    {
        return NO;
    }
    //===============发送消息
    if(self.conversation.type  == EMChatTypeChatRoom)
    {
        if ([self.m_groupForbidModel.m_isforbid boolValue])
        {
         
            
            
            
            
            
            NSTimeInterval cha=[self.m_groupForbidModel.m_endTime timeIntervalSinceDate:[[XSDTimeCalibration share]getServerDate]];
            NSTimeInterval chaTime=cha/60.00;
            //向上取整
            if (0<(chaTime-(int)chaTime))
            {
                chaTime++;
            }
            if (chaTime>0)
            {
                NSString *str=[NSString stringWithFormat:@"发送失败，您已被禁言，剩余%i分钟",(int)chaTime];
                UtilAlert(@"提示",str);
                return NO;
            }else
            {
                if (self.conversation.type  == EMChatTypeGroupChat) {
                    [self getNetGroupGagTimeout:self.m_groupId];
                }else
                {
                    [self getNetChatroomForbidtimeout:self.conversation.conversationId];
                }
                
            }
            
        }
    }

    return YES;
}
#pragma mark - EaseChatBarMoreViewDelegate   拍照 图片 视频 分享 点击事件

- (void)moreView:(EaseChatBarMoreView *)moreView didItemInMoreViewAtIndex:(NSInteger)index
{
       
    if ([self.delegate respondsToSelector:@selector(messageViewController:didSelectMoreView:AtIndex:)]) {
        [self.delegate messageViewController:self didSelectMoreView:moreView AtIndex:index];
        return;
   
    }
}

//图片
- (void)moreViewPhotoAction:(EaseChatBarMoreView *)moreView
{
   
    
   if (![self justIsMessage]||![DTools isCanUsePhotos])
   {
        return;
    }

    // 隐藏键盘
    [self.chatToolbar endEditing:YES];
    
//
//    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
//    [self presentViewController:self.imagePicker animated:YES completion:NULL];
       
         // 弹出照片选择
        [self takePhoto];
    
    self.isViewDidAppear = NO;
    [[EaseSDKHelper shareHelper] setIsShowingimagePicker:YES];
   
}
/**
 *  视频
 *
 *  @param moreView
 */
- (void)moreViewVideoAction:(EaseChatBarMoreView *)moreView
{
    if (![self justIsMessage]||![DTools isCanUseCamera]) {
        return;
    }
    if (![DTools isCanUseMicrophone])
    {
        return;
    }
  

    UIStoryboard  *  storyboard = [UIStoryboard  storyboardWithName:@"VideoRecording" bundle:nil];
    
    
    VideoViewController * video = [storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:video];
//    nav.navigationBar.barTintColor=RGBBgNavColor;
    video.delegate=self;
      [self.navigationController presentViewController:video animated:YES completion:nil];
//    // 隐藏键盘
//    [self.chatToolbar endEditing:YES];
//    UtilAlert(@"提示", @"正在开发中");

}



//拍照
- (void)moreViewTakePicAction:(EaseChatBarMoreView *)moreView
{
    
    if (![self justIsMessage]||![DTools isCanUseCamera]) {
        return;
    }
   
    // 隐藏键盘
    [self.chatToolbar endEditing:YES];
    
#if TARGET_IPHONE_SIMULATOR
    [self showHint:NSEaseLocalizedString(@"message.simulatorNotSupportCamera", @"simulator does not support taking picture")];
#elif TARGET_OS_IPHONE
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    [self presentViewController:self.imagePicker animated:YES completion:NULL];
    
    self.isViewDidAppear = NO;
    [[EaseSDKHelper shareHelper] setIsShowingimagePicker:YES];
#endif
    
}



/**
 分享
 @param moreView <#moreView description#>
 */
- (void)moreViewShareAction:(EaseChatBarMoreView*)moreView
{
    if (![self justIsMessage]) {
        return;
    }
    //6.26 xiong
//    if ([self.m_shareGroupOrChatRoom.m_img isNull]) {
//        CGSize newsize = CGSizeMake(80, 80);
//        NSData * data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:self.m_shareGroupOrChatRoom.m_img]];
//        
//        UIImage * image = [[UIImage alloc]initWithData:data];
//        UIGraphicsBeginImageContext(newsize);
//        [image drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
//        UIImage * newimage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
////        NSData * data1 =UIImagePNGRepresentation(newimage);
////        data1=[data1 compressToMaxDataSizeKBytes:15];
////        UIImage * image1 = [[UIImage alloc]initWithData:data1];
////        NewsModel * m_shareGroupOrChatRoom =self.m_shareGroupOrChatRoom;
//        [[ShareView shareInstance]ShareViewWindowModel:self.m_shareGroupOrChatRoom image:newimage isGroupShar:NO];
//    
//    }else{
//        
//        
//        [[ShareView shareInstance]ShareViewWindowModel:self.m_shareGroupOrChatRoom image:ImageNamed(@"share_bot") isGroupShar:NO];
//    }
    
    
}


- (void)moreViewAudioCallAction:(EaseChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self.chatToolbar endEditing:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_CALL object:@{@"chatter":self.conversation.conversationId, @"type":[NSNumber numberWithInt:0]}];
}

- (void)moreViewVideoCallAction:(EaseChatBarMoreView *)moreView
{
    // 隐藏键盘
    [self.chatToolbar endEditing:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_CALL object:@{@"chatter":self.conversation.conversationId, @"type":[NSNumber numberWithInt:1]}];
}
#pragma mark -VideoViewControllerDelegate


-(void)concel
{
    
}
-(void)VideoViewSure:(NSURL *)url
{
    
    [self sendVideoMessageWithURL:url];
//    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//    int videoTag=[[accountDefaults objectForKey:K_FileName_RecordVideoTag] intValue];
//    
//    
//    
//    RegisteredUser *regist= [DPlistSave readUserData];
//  
//    //退出聊天室，删除会话
//    NSString *chatter = [self.conversation.conversationId copy];
//    EMVideoMessageBody *body = [[EMVideoMessageBody alloc] initWithLocalPath:[url path] displayName: [NSString stringWithFormat:@"%@%i.mp4",K_FileName_RecordVideoName,videoTag]];
//    NSString *from = [[EMClient sharedClient] currentUsername];
//   NSDictionary * dic=[[NSDictionary alloc] initWithObjectsAndKeys:
//         regist.m_nickname,K_nickname,
//         regist.m_avatar,K_avatar,
//         [NSNumber numberWithInt:[regist.m_gender intValue] ],K_gender,
//         regist.m_birth,K_birth,
//         [accountDefaults objectForKey:UserLocationLo],K_lng,
//         [accountDefaults objectForKey:UserLocationLa],K_lat,
//         [accountDefaults objectForKey:UserLocationAddress],K_addr,
//         
//                       [NSNumber numberWithInt:[[accountDefaults objectForKey:UserDefaultNameKey] intValue] ],K_uid,nil];
//    EMMessage *message = [[EMMessage alloc] initWithConversationID:chatter from:from to:chatter body:body ext:dic];
//   
//    
//    
//        switch (self.conversation.type)
//        {
//            case EMConversationTypeChatRoom:
//                 message.chatType = EMChatTypeChatRoom;// 设置为群聊消息
//                break;
//            case EMConversationTypeGroupChat:
//                message.chatType = EMConversationTypeGroupChat;// 设置为群聊消息
//                break;
//
//            case EMConversationTypeChat:
//                message.chatType = EMConversationTypeChat;// 设置为群聊消息
//                break;
//
//            default:
//                break;
//        }
//    
//    
//    __weak typeof(self) weakself = self;
//    [self addMessageToDataSource:message progress:nil];
//    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError)
//     {
//         if (aError)
//         {
//             DLog(@"发送错误%i",aError.code);
//         }
//         [weakself.tableView reloadData];
//     }];
}
#pragma mark - EMLocationViewDelegate

-(void)sendLocationLatitude:(double)latitude
                  longitude:(double)longitude
                 andAddress:(NSString *)address
{
    [self sendLocationMessageLatitude:latitude longitude:longitude andAddress:address];
}

#pragma mark - EaseMob

#pragma mark - EMChatManagerDelegate   收到消息

- (void)didReceiveMessages:(NSArray *)aMessages
{
    
//    [self showHint:[NSString stringWithFormat:@"接收消息数量--%lu",(unsigned long)aMessages.count]];
   
    for (EMMessage *message in aMessages) {
        
       // DLog(@"%lli", message.timestamp);
//        //获取系统当前的时间戳
//        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//        NSTimeInterval a=[dat timeIntervalSince1970];
    if ([[message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue]==8||[[message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE]intValue]==9){
       
            if (self.m_joinRoomTime>message.timestamp/1000&&self.m_joinRoomTime>0)
            {
                EMError *error;
                [self.conversation deleteMessageWithId:message.messageId error:&error];
                continue;
            }else
            {
                
               

            }
        }
       
        //判断用户是否在黑名单里面 如果在 则不添加进消息
        if ([DTools judgeBlackListUserID:message.from]) {
             EMError *error;
             [self.conversation deleteMessageWithId:message.messageId error:&error];
             continue;
           
        }
        
      //  DLog(@"didReceiveMessages---%@",message.ext);
        if ([self.conversation.conversationId isEqualToString:message.conversationId]) {
            
            
            //不看用户发言
             BOOL isTure=NO;
            if( message.chatType == EMChatTypeGroupChat||message.chatType == EMChatTypeChatRoom)
            {
                
               
            
                if (self.m_blockListArr.count>0)
                {
                    int uid=[[message.ext objectForKey:K_uid] intValue];
                    
                    for (int k=0; k<self.m_blockListArr.count; k++) {
                        
                        
                        BlockModel *model=[self.m_blockListArr objectAtIndex:k];
                        int uid1=[model.m_blockUid intValue];
                        if (uid==uid1)
                        {
                            isTure=YES;
                            break;
                        }
                    }
                }
               
            }
            
            if (isTure)
            {
                  EMError *error;
                 [self.conversation deleteMessageWithId:message.messageId error:&error];
                continue;
            }else{
                
//                CGPoint contentOffsetPoint = self.tableView.contentOffset;
//                CGRect frame = self.tableView.frame;
//            if ((self.tableView.contentSize.height < self.tableView.frame.size.height || (contentOffsetPoint.y + 65)>= (self.tableView.contentSize.height - frame.size.height)) && ((self.tableView.contentSize.height - frame.size.height)-contentOffsetPoint.y > 80)) {
                
              
//                判断TableView的Fream是否在最底下  如果不在  则显示新信息提示 否则不显示
//                if (ShareAppDelegate.m_Down) {
//                    
//                    //    通知显示右下角新消息的提示
//            [[NSNotificationCenter defaultCenter]postNotificationName:K_NewMessage object:nil];
//
//                }
                
            }
       
            
            
//             [[NSNotificationCenter defaultCenter]postNotificationName:K_TOPMESSAGENUMBER object:nil];//通知话题聊天 刷新右上角未读条数
            [[NSNotificationCenter defaultCenter]postNotificationName:K_NEWSMESSAGENUMBER object:nil];//通知新闻聊天 刷新右上角未读条数
            [self addMessageToDataSource:message progress:nil];
            
            [self _sendHasReadResponseForMessages:@[message]
                                           isRead:NO];
            
            if ([self _shouldMarkMessageAsRead])
            {
                EMError *error;
                [self.conversation markMessageAsReadWithId:message.messageId error:&error];
            }
        }
    }
}

//
//-(BOOL)isTableViewDown
//{
//    
//    CGPoint contentOffsetPoint = self.tableView.contentOffset;
//    CGRect frame = self.tableView.frame;
//    
//    
//    
//    if (self.tableView.contentSize.height < self.tableView.frame.size.height || (contentOffsetPoint.y + 65)>= (self.tableView.contentSize.height - frame.size.height)) {
//       //在低端
//        return YES;
//    }else if((self.tableView.contentSize.height - frame.size.height)-contentOffsetPoint.y > 80) {
//        //不在低端
//        return NO;
//    }else{
//        
//        return YES;
//    }
//    
//}

//- (void)didReceiveCmdMessages:(NSArray *)aCmdMessages
//{
//    
//    
//    for (EMMessage *message in aCmdMessages)
//    {
//        
//        // cmd消息中的扩展属性
//        NSDictionary *ext = message.ext;
//        NSLog(@"cmd消息中的扩展属性是 -- %@",ext );
//        //信息字符串
//        NSString *dataStr=[ext objectForKey:@"record"];
//       // DLog(@"+++++++++ - ---    %@",dataStr);
//        //邀请类型标识
//        NSString *msgtype=[ext objectForKey:@"msgtype"];
//        //        NSString * msgdesc = [ext objectForKey:@"msgdesc"];
//        
//        //字符串分割
//        NSMutableArray *arrData=(NSMutableArray *)[dataStr componentsSeparatedByString:@";"];
//        //        [arrData removeLastObject];
//        NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
//        for (NSString *str in arrData)
//        {
//            NSArray *arr=[str componentsSeparatedByString:@"="];
//            [dataDic setObject:[arr objectAtIndex:1] forKey:[arr objectAtIndex:0]];
//            
//        }
////        BOOL bo= [[EMClient sharedClient].chatManager importMessages:[[NSArray alloc] initWithObjects:message, nil]];
////        if (bo)
////        {
////            DLog(@"成功-00000-%@",message.messageId);
////        }
//        EMCmdMessageBody *body = (EMCmdMessageBody *)message.body;
//       [self conversitionModel:msgtype dataDic:dataDic body:body message:message];
//      //  NSLog(@"收到的action是 -- %@",body.action);
//    }

- (void)didReceiveHasDeliveredAcks:(NSArray *)aMessages
{
    for(EMMessage *message in aMessages){
        [self _updateMessageStatus:message];
    }
}

- (void)didReceiveHasReadAcks:(NSArray *)aMessages
{
    for (EMMessage *message in aMessages) {
        if (![self.conversation.conversationId isEqualToString:message.conversationId]){
            continue;
        }
        
        __block id<IMessageModel> model = nil;
        __block BOOL isHave = NO;
        [self.dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             if ([obj conformsToProtocol:@protocol(IMessageModel)])
             {
                 model = (id<IMessageModel>)obj;
                 if ([model.messageId isEqualToString:message.messageId])
                 {
                     model.message.isReadAcked = YES;
                     isHave = YES;
                     *stop = YES;
                 }
             }
         }];
        
        if(!isHave){
            return;
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(messageViewController:didReceiveHasReadAckForModel:)]) {
            [_delegate messageViewController:self didReceiveHasReadAckForModel:model];
        }
        else{
            [self.tableView reloadData];
        }
    }
}

- (void)didMessageStatusChanged:(EMMessage *)aMessage
                          error:(EMError *)aError;
{
    [self _updateMessageStatus:aMessage];
}

- (void)didMessageAttachmentsStatusChanged:(EMMessage *)message
                                     error:(EMError *)error{
    if (!error) {
        EMFileMessageBody *fileBody = (EMFileMessageBody*)[message body];
        if ([fileBody type] == EMMessageBodyTypeImage) {
            EMImageMessageBody *imageBody = (EMImageMessageBody *)fileBody;
            if ([imageBody thumbnailDownloadStatus] == EMDownloadStatusSuccessed)
            {
                [self _reloadTableViewDataWithMessage:message];
            }
        }else if([fileBody type] == EMMessageBodyTypeVideo){
            EMVideoMessageBody *videoBody = (EMVideoMessageBody *)fileBody;
            if ([videoBody thumbnailDownloadStatus] == EMDownloadStatusSuccessed)
            {
                [self _reloadTableViewDataWithMessage:message];
            }
        }else if([fileBody type] == EMMessageBodyTypeVoice){
            if ([fileBody downloadStatus] == EMDownloadStatusSuccessed)
            {
                [self _reloadTableViewDataWithMessage:message];
            }
        }
        
    }else{
        
    }
}

#pragma mark - EMCDDeviceManagerProximitySensorDelegate

- (void)proximitySensorChanged:(BOOL)isCloseToUser
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if (isCloseToUser)
    {
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    } else {
        //有效的只有音频会话类
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        if (self.playingVoiceModel == nil) {
            [[EMCDDeviceManager sharedInstance] disableProximitySensor];
        }
    }
    [audioSession setActive:YES error:nil];
}

#pragma mark - action

- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        pasteboard.string = model.text;
    }
    
    self.menuIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:self.menuIndexPath.row];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:self.menuIndexPath, nil];
          EMError *error;
        [self.conversation deleteMessageWithId:model.message.messageId error:&error];
        [self.messsagesSource removeObject:model.message];
        
        if (self.menuIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row - 1)];
            if (self.menuIndexPath.row + 1 < [self.dataArray count]) {
                nextMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:self.menuIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(self.menuIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataArray removeObjectsAtIndexes:indexs];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    
    self.menuIndexPath = nil;
}

#pragma mark - public 

- (NSArray *)formatMessages:(NSArray *)messages
{
    NSMutableArray *formattedArray = [[NSMutableArray alloc] init];
    if ([messages count] == 0) {
        return formattedArray;
    }
    
    for (EMMessage *message in messages)
    {
        int noticeType=[[message.ext safeObjectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
        if(noticeType==5||noticeType==6)
        {
            EMError *error;
              [self.conversation deleteMessageWithId:message.messageId error:&error];
            continue;
        }
        //计算時間间隔
        CGFloat interval = (self.messageTimeIntervalTag - message.timestamp) / 1000;
        if (self.messageTimeIntervalTag < 0 || interval > 60 || interval < -60)
        {
            NSDate *messageDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
            NSString *timeStr = @"";
            
            if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewController:stringForDate:)])
            {
                timeStr = [_dataSource messageViewController:self stringForDate:messageDate];
            }
            else
            {
                timeStr = [messageDate formattedTime];
            }

                [formattedArray addObject:timeStr];
                self.messageTimeIntervalTag = message.timestamp;

            
        }
        
        //构建数据模型
        id<IMessageModel> model = nil;
        if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewController:modelForMessage:)]) {
            model = [_dataSource messageViewController:self modelForMessage:message];
        }
        else{
            model = [[EaseMessageModel alloc] initWithMessage:message];
           
        }

      if (model)
       {

             [formattedArray addObject:model];
       }
    }
    
    return formattedArray;
}

-(void)addMessageToDataSource:(EMMessage *)message
                     progress:(id)progress
{
    [self.messsagesSource addObject:message];
    
     __weak EaseMessageViewController *weakSelf = self;
 
 DLog(@"开始进消息队列了 注意啦");
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *messages = [weakSelf formatMessages:@[message]];
        if (messages.count==0)//等于0会崩溃
        {
            return ;
        }
        DLog(@"已经进消息队列了 注意啦");
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.dataArray addObjectsFromArray:messages];
            [weakSelf.tableView reloadData];
            
            
            DLog(@"耍表了 注意啦");
            //如果我是消息发送方则跳转最后  如果不是则不跳转
            if (message.direction == EMMessageDirectionSend)
            {
                 [self _scrollViewToBottom:YES];
//            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[weakSelf.dataArray count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }else{
              
                
                
                     if(self.m_Down)
                     {
                         if ([weakSelf.dataArray count] != 0) {
                             
                             //                         [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[weakSelf.dataArray count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                             [self _scrollViewToBottom:YES];
                             
                         }
                     } else
                     {
                         
                         //    通知显示右下角新消息的提示
                         [[NSNotificationCenter defaultCenter]postNotificationName:K_NewMessage object:nil];
                         
                     }
                   
                   
                 
                 
                
            }
      });
    });
}

#pragma mark - public

- (void)tableViewDidTriggerHeaderRefresh
{
    self.messageTimeIntervalTag = -1;
    NSString *messageId = nil;
    if ([self.messsagesSource count] > 0) {
        messageId = [(EMMessage *)self.messsagesSource.firstObject messageId];
    }
    else {
        messageId = nil;
    }
    [self _loadMessagesBefore:messageId count:self.messageCountOfPage append:YES];
    
    [self tableViewDidFinishTriggerHeader:YES reload:YES];
}

#pragma mark - send message
- (void)_refreshAfterSentMessage:(EMMessage*)aMessage
{
    if ([self.messsagesSource count] && [EMClient sharedClient].options.sortMessageByServerTime) {
        NSString *msgId = aMessage.messageId;
        EMMessage *last = self.messsagesSource.lastObject;
        if ([last isKindOfClass:[EMMessage class]]) {
            
            __block NSUInteger index = NSNotFound;
            index = NSNotFound;
            [self.messsagesSource enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(EMMessage *obj, NSUInteger idx, BOOL *stop) {
                if ([obj isKindOfClass:[EMMessage class]] && [obj.messageId isEqualToString:msgId]) {
                    index = idx;
                    *stop = YES;
                }
            }];
            if (index != NSNotFound) {
                [self.messsagesSource removeObjectAtIndex:index];
                [self.messsagesSource addObject:aMessage];
                
                //格式化消息
                self.messageTimeIntervalTag = -1;
                NSArray *formattedMessages = [self formatMessages:self.messsagesSource];
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:formattedMessages];
                [self.tableView reloadData];
//                EMConversationTypeChat  = 0,    /*! \~chinese 单聊会话 \~english Chat */
//                EMConversationTypeGroupChat,    /*! \~chinese 群聊会话 \~english Group chat */
//                EMConversationTypeChatRoom      /*! \~chinese 聊天室会话 \~english Chatroom chat */
                 if (!self.m_Down ||self.conversation.type==EMConversationTypeChat||self.conversation.type==EMConversationTypeGroupChat) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.dataArray count] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                 }
                return;
            }
        }
    }
    [self.tableView reloadData];
}
#pragma mark - 发送消息
- (void)_sendMessage:(EMMessage *)message
{
    if ([DTools whetherGlobalSilence])
    {
        return;
    }
    
    
    NSString *chat_fromStr=@"";
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
   
    if (self.conversation.type == EMConversationTypeGroupChat){
        message.chatType = EMChatTypeGroupChat;
       
       
    }
    else if (self.conversation.type == EMConversationTypeChatRoom){
        message.chatType = EMChatTypeChatRoom;
      
    }else if (self.conversation.type == EMConversationTypeChat){
        message.chatType = EMChatTypeChat;
//         [accountDefaults setObject:[NSString stringWithFormat:@"聊天室『%@』",self.m_model.m_cname] forKey:K_noticeRoomName];
          chat_fromStr=[NSString stringWithFormat:@"%@",  [accountDefaults objectForKey:K_noticeRoomName]];
        
    }
    
    //xiong 2016.4.7
    //===============发送消息
    if( message.chatType == EMChatTypeGroupChat||message.chatType == EMChatTypeChatRoom)
    {
        if ([self.m_groupForbidModel.m_isforbid boolValue])
        {

          
            
            
            
            //取两个日期对象的时间间隔：
            //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
            NSTimeInterval cha=[self.m_groupForbidModel.m_endTime timeIntervalSinceDate:[[XSDTimeCalibration share]getServerDate]];
            NSTimeInterval chaTime=cha/60.00;
            //向上取整
            if (0<(chaTime-(int)chaTime))
            {
                chaTime++;
            }
            if (chaTime>0)
            {
                NSString *str=[NSString stringWithFormat:@"发送失败，您已被禁言，剩余%i分钟",(int)chaTime];
                UtilAlert(@"提示",str);
                return;
            }else
            {
                if (message.chatType == EMChatTypeGroupChat) {
                     [self getNetGroupGagTimeout:self.m_groupId];
                }else
                {
                    [self getNetChatroomForbidtimeout:self.conversation.conversationId];
                }
               
            }

        }
    }
    
    RegisteredUser *regist= [DPlistSave readUserData];
    //得到用户保存的aLat和aLong
//    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic;
      BOOL isFriend=[DTools compareIsFriendEaseId:message.to];
    
//    BOOL isFriend=[DTools compareIsFriend:[[message.ext objectForKey:K_uid] intValue]];
//    if (message.chatType==EMChatTypeChat)
//    {
//        NSMutableArray *arr= [self myFriendListLocalRead];
//        int i;
//        for (i=0; i<arr.count; i++)
//        {
//            FriendListModel *listModel=[arr safeObjectAtIndex:i];
//            if ([listModel.m_easeUname isEqualToString:self.conversation.conversationId]) {
//                
//                    i=(int)arr.count+2;
//                
//                break;
//            }
//        }
//        if (i!=arr.count+2)
//        {
//            isFriend=NO;
//        }
//    }
    //判断用户聊天对象是否是好友
    
    //判断发送  是不是新闻
   int news=[ [message.ext objectForKey:K_MESSAGE_ATTR_MESSAGE_TYPE] intValue];
    
    if (news!=7&&self.m_chatRoomType!=ChatRoomTypeRolePlay)
    {
        
        if (isFriend)
        {
       
        
            
            if (message.ext)
            {
                dic=[[NSDictionary alloc] initWithObjectsAndKeys:
                   regist.m_nickname,K_nickname,
                   regist.m_avatar,K_avatar,
                   [NSNumber numberWithInt:[regist.m_gender intValue] ],K_gender,
                   regist.m_birth,K_birth,
                     regist.m_signature,K_SIGNATURE_INFO,
                   [accountDefaults objectForKey:UserLocationLo],K_lng,
                   [accountDefaults objectForKey:UserLocationLa],K_lat,
                   [accountDefaults objectForKey:UserLocationAddress],K_addr,
                   
                   [NSNumber numberWithInt:[[accountDefaults objectForKey:UserDefaultNameKey] intValue] ],K_uid,
                     chat_fromStr,K_MESSAGE_ATTR_FROM,
                     [message.ext objectForKey:K_EmExpressionId],K_EmExpressionId,
                     [message.ext objectForKey:K_EmIsBigExpression],K_EmIsBigExpression,
                     
                     nil];
                
            }else
            {
                dic=[[NSDictionary alloc] initWithObjectsAndKeys:
                     regist.m_nickname,K_nickname,
                     regist.m_avatar,K_avatar,
                     [NSNumber numberWithInt:[regist.m_gender intValue] ],K_gender,
                     regist.m_birth,K_birth,
                       regist.m_signature,K_SIGNATURE_INFO,
                     [accountDefaults objectForKey:UserLocationLo],K_lng,
                     [accountDefaults objectForKey:UserLocationLa],K_lat,
                     [accountDefaults objectForKey:UserLocationAddress],K_addr,
                     chat_fromStr,K_MESSAGE_ATTR_FROM,
                     [NSNumber numberWithInt:[[accountDefaults objectForKey:UserDefaultNameKey] intValue] ],K_uid, nil];
            }
        }else
        {
        FriendListModel *frend;
                if ([self.delegate respondsToSelector:@selector(getNoFriendInfo)])
                {
                    frend=[self.delegate getNoFriendInfo];
                }
                if (frend)
                {
                                if (message.ext)
                                {
                                    
                                    
                                dic=[[NSDictionary alloc] initWithObjectsAndKeys:
                                     regist.m_nickname,K_nickname,
                                     regist.m_avatar,K_avatar,
                                     [NSNumber numberWithInt:[regist.m_gender intValue] ],K_gender,
                                     regist.m_birth,K_birth,
                                     regist.m_signature,K_SIGNATURE_INFO,
                                     [accountDefaults objectForKey:UserLocationLo],K_lng,
                                     [accountDefaults objectForKey:UserLocationLa],K_lat,
                                     [accountDefaults objectForKey:UserLocationAddress],K_addr,
                                     
                                     [NSNumber numberWithInt:[[accountDefaults objectForKey:UserDefaultNameKey] intValue] ],K_uid,
                                     frend.m_fuid,K_MESSAGE_ATTR_TOUID,
                                     frend.m_avatar,K_MESSAGE_ATTR_TOAVATRA,
                                     frend.m_nickname,K_MESSAGE_ATTR_TONICKNAME,
                                      chat_fromStr,K_MESSAGE_ATTR_FROM,
                                     [message.ext objectForKey:K_EmExpressionId],K_EmExpressionId,
                                     [message.ext objectForKey:K_EmIsBigExpression],K_EmIsBigExpression,
                                     
                                     nil];
                                }else
                                {
                                    dic=[[NSDictionary alloc] initWithObjectsAndKeys:
                                         regist.m_nickname,K_nickname,
                                         regist.m_avatar,K_avatar,
                                         [NSNumber numberWithInt:[regist.m_gender intValue] ],K_gender,
                                         regist.m_birth,K_birth,
                                         regist.m_signature,K_SIGNATURE_INFO,
                                         [accountDefaults objectForKey:UserLocationLo],K_lng,
                                         [accountDefaults objectForKey:UserLocationLa],K_lat,
                                         [accountDefaults objectForKey:UserLocationAddress],K_addr,
                                         
                                         [NSNumber numberWithInt:[[accountDefaults objectForKey:UserDefaultNameKey] intValue] ],K_uid,
                                         frend.m_fuid,K_MESSAGE_ATTR_TOUID,
                                         frend.m_avatar,K_MESSAGE_ATTR_TOAVATRA,
                                         frend.m_nickname,K_MESSAGE_ATTR_TONICKNAME,
                                           chat_fromStr,K_MESSAGE_ATTR_FROM,
                                         nil];
                                }
                }else
                {
                    if (message.ext)
                    {
                        dic=[[NSDictionary alloc] initWithObjectsAndKeys:
                             regist.m_nickname,K_nickname,
                             regist.m_avatar,K_avatar,
                             [NSNumber numberWithInt:[regist.m_gender intValue] ],K_gender,
                             regist.m_birth,K_birth,
                             regist.m_signature,K_SIGNATURE_INFO,
                             [accountDefaults objectForKey:UserLocationLo],K_lng,
                             [accountDefaults objectForKey:UserLocationLa],K_lat,
                             [accountDefaults objectForKey:UserLocationAddress],K_addr,
                             
                             [NSNumber numberWithInt:[[accountDefaults objectForKey:UserDefaultNameKey] intValue] ],K_uid,
                             chat_fromStr,K_MESSAGE_ATTR_FROM,
                             [message.ext objectForKey:K_EmExpressionId],K_EmExpressionId,
                             [message.ext objectForKey:K_EmIsBigExpression],K_EmIsBigExpression,
                             
                             nil];
                    }else
                    {
                        dic=[[NSDictionary alloc] initWithObjectsAndKeys:
                             regist.m_nickname,K_nickname,
                             regist.m_avatar,K_avatar,
                             [NSNumber numberWithInt:[regist.m_gender intValue] ],K_gender,
                             regist.m_birth,K_birth,
                             regist.m_signature,K_SIGNATURE_INFO,
                             [accountDefaults objectForKey:UserLocationLo],K_lng,
                             [accountDefaults objectForKey:UserLocationLa],K_lat,
                             [accountDefaults objectForKey:UserLocationAddress],K_addr,
                             chat_fromStr,K_MESSAGE_ATTR_FROM,
        //                     [NSNumber numberWithInt:[[accountDefaults objectForKey:UserDefaultNameKey] intValue] ],K_uid,
                             
                              regist.m_id,K_uid,
                             
                             nil];
                    }
                    

                }
       
        }
   }
//     [self  EveryDayFirstMessageRequest];
    //群组发言  是否是当天第一次发言
    if(message.chatType != EMChatTypeChat)
    {
        NSDate *currentDate=[[XSDTimeCalibration share]getServerDate];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYYMMdd"];
        NSString *locationStr=[dateformatter stringFromDate:currentDate];
         NSMutableDictionary *hotDic=[self getHotGroupInfo];
        NSString *yesterdayDate=[hotDic safeObjectForKey:self.conversation.conversationId];
        if (![yesterdayDate isEqualToString:locationStr])
        {
            //每天第一次发言积分请求
            [self  EveryDayFirstMessageRequest];
            [hotDic setObject:locationStr forKey:self.conversation.conversationId];
            [self storageHotGroupInfo:hotDic];
         
        }
        
    }
    
  
//    if (!message.ext)
//    {
    if (news!=7&&self.m_chatRoomType!=ChatRoomTypeRolePlay)
    {
        
        message.ext=dic;
    }
    
    
    if (self.m_chatRoomType==ChatRoomTypeRolePlay)
    {
        if (message.ext)
        {
            dic=[[NSDictionary alloc] initWithObjectsAndKeys:
                 regist.m_nickname,K_nickname,
                 regist.m_avatar,K_avatar,
                 [NSNumber numberWithInt:[regist.m_gender intValue] ],K_gender,
                 regist.m_birth,K_birth,
                 regist.m_signature,K_SIGNATURE_INFO,
                 [accountDefaults objectForKey:UserLocationLo],K_lng,
                 [accountDefaults objectForKey:UserLocationLa],K_lat,
                 [accountDefaults objectForKey:UserLocationAddress],K_addr,
                 
                 [NSNumber numberWithInt:[[accountDefaults objectForKey:UserDefaultNameKey] intValue] ],K_uid,
                 chat_fromStr,K_MESSAGE_ATTR_FROM,
                 [message.ext objectForKey:K_EmExpressionId],K_EmExpressionId,
                 [message.ext objectForKey:K_EmIsBigExpression],K_EmIsBigExpression,
                 
                 nil];
            
        }else
        {
            
            AnswerModel * model =[ShareAppDelegate.m_ActorsAuditio safeObjectForKey:ShareAppDelegate.m_roomId];
            
            dic=[[NSDictionary alloc] initWithObjectsAndKeys:
                 regist.m_nickname,K_nickname,
                 regist.m_avatar,K_avatar,
                 [NSNumber numberWithInt:[regist.m_gender intValue] ],K_gender,
                 regist.m_birth,K_birth,
                 regist.m_signature,K_SIGNATURE_INFO,
                 [accountDefaults objectForKey:UserLocationLo],K_lng,
                 [accountDefaults objectForKey:UserLocationLa],K_lat,
                 [accountDefaults objectForKey:UserLocationAddress],K_addr,
                 chat_fromStr,K_MESSAGE_ATTR_FROM,
                 [NSNumber numberWithInt:[[accountDefaults objectForKey:UserDefaultNameKey] intValue] ],K_uid,
                 //这里要有名字和角色编号 所以拼接一下
                [NSString stringWithFormat:@"%@[%@]", model.m_rolemodel.m_rname,model.m_rolemodel.m_roleNumber],K_RoleName,
                model.m_rolemodel.m_avatar,K_RoleAvatar,
                model.m_rolemodel.m_rname,K_RoleRealname,nil];
        }
        
        message.ext=dic;
        
    }
//    }else
//    {
////       message.ext=[NSDictionary dictionaryWithDictionary:dic];
//    }
   //   DLog(@"message.ext--%@",message.ext);
    //===============
//     UserOperation * userModel = [self DetermineTheUserLevelOperation:[self myGroupListLocalRead] type:directMessages];
    
    //这里判断如果是群聊或者聊天室 则直接发送信息
    if (self.conversation.type == EMConversationTypeGroupChat || self.conversation.type == EMConversationTypeChatRoom){
        [self addMessageToDataSource:message
                            progress:nil];
        
        __weak typeof(self) weakself = self;
        [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError)
         {
             if (aError)
             {
                // DLog(@"发送消息错误码---%i",aError.code);
                 
                 
                 if (aError.code == 210)
                 {
                     UtilAlert(@"发送信息失败", @"对方已拒绝接收您的消息");
                 }else
                 {
                     
                     
                     NSString *tr=[NSString stringWithFormat:@"发送消息错误码---%i---错误描述-：%@",aError.code,aError.errorDescription];
                     
                     UtilAlert(@"发送信息失败",tr);
                 }
                 
             }
             
             [weakself.tableView reloadData];
         }];
        

}else{
   
   
    
        [self addMessageToDataSource:message
                        progress:nil];
    
    __weak typeof(self) weakself = self;
    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {
      
        if (error)
        {
            DLog(@"发送消息错误码---%i",error.code);
            
            
            if (error.code == 210)
            {
                UtilAlert(@"发送信息失败", @"对方已拒绝接收您的消息");
            }else
            {
                
                
                NSString *tr=[NSString stringWithFormat:@"发送消息错误码---%i---错误描述-：%@",error.code,error.errorDescription];
                
                UtilAlert(@"发送信息失败",tr);
            }
            
        }
        
        [weakself.tableView reloadData];
    }];
   
       
    }
    
}


-(void)EveryDayFirstMessageRequest
{
    [self.chatToolbar endEditing:YES];
    NSDictionary * info = [URLPath getNetChatroomIntegral];
    [[AFHTTPClient share]getMethod:[info objectForKey:K_URL] param:[info objectForKey:K_URL_PARAMETER] success:^(NSDictionary *respostData) {
        NSInteger rs = [[respostData safeObjectForKey:K_rs]integerValue];
        if (rs == 1) {
               RegisteredUser *regist= [DPlistSave readUserData];
            RegisteredUser * registOn = [DPlistSave readUserData];
            NSString * levels = [[respostData objectForKey:K_data] objectForKey:@"level"];
    if ([regist.m_levels integerValue] < [levels integerValue])
            {
                regist.m_levels = levels;//更改用户的等级
               
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
               
                [dic setObject:[DTools userReadLevelCluesLevel:levels] forKey:@"UserMessage"];
                //6.26 xiong
              //  [[ChatDemoHelper shareHelper]conversitionModel:@"101" dataDic:dic body:nil record:nil msgdesc:@"增加积分等级"];
                
            }
            regist.m_integral = [[respostData objectForKey:K_data] objectForKey:@"integral"];
            regist.m_levels   = [[respostData objectForKey:K_data] objectForKey:@"level"];
            NSDictionary * dic  = regist.mj_keyValues;
            RegisteredUser * userModel = [RegisteredUser mj_objectWithKeyValues:dic];
            [DPlistSave UserDataLocalStore:userModel];
            //发通知修改用户侧边栏显示
            [[NSNotificationCenter defaultCenter]postNotificationName:k_changePhoto object:nil];
            if (([userModel.m_integral integerValue] - [registOn.m_integral integerValue]) >0) {
            
            //6.26 xiong
                //弹出积分提示框 3秒自动消失
                //[[TodayReward shareInstance:CGRectMake(0, 0, LCDW, LCDH+20)]tpdayRewardIntegral:registOn.m_integral addNumber:[NSString stringWithFormat:@"%ld",([userModel.m_integral integerValue] - [registOn.m_integral integerValue])] center:self.view.center];
            }
          
        }
    } failed:^(NSString *errorMsg) {
        
    }];
}
/**
 *  取热门群组信息
 *
 *  @return
 */
-(NSMutableDictionary *)getHotGroupInfo
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:K_dayFirstMessage];
    NSMutableDictionary * dic =(NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (dic == nil) {
        dic = [[NSMutableDictionary alloc]init];
    }
    return dic;
}
/**
 *  存储热门群组信息
 *
 *  @param dic
 */
-(void)storageHotGroupInfo:(NSMutableDictionary *)dic
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver  archivedDataWithRootObject:dic];
    [userDefaults setObject:data forKey:K_dayFirstMessage];
    [userDefaults synchronize];//调用synchronize方法强制写入
}
- (void)sendTextMessage:(NSString *)text
{
    

    
//    NSDictionary *ext = nil;
//    if (self.conversation.type == EMConversationTypeGroupChat) {
//        NSArray *targets = [self _searchAtTargets:text];
//        if ([targets count]) {
//            __block BOOL atAll = NO;
//            [targets enumerateObjectsUsingBlock:^(NSString *target, NSUInteger idx, BOOL *stop) {
//                if ([target compare:kGroupMessageAtAll options:NSCaseInsensitiveSearch] == NSOrderedSame) {
//                    atAll = YES;
//                    *stop = YES;
//                }
//            }];
//            if (atAll) {
//                ext = @{kGroupMessageAtList: kGroupMessageAtAll};
//            }
//            else {
//                ext = @{kGroupMessageAtList: targets};
//            }
//        }
//    }
//    if(ext==nil)
//    {
//     [self sendTextMessage:text withExt:ext];
//    }else
//    {
         [self sendTextMessage:text withExt:nil];
//    }
   
}

- (void)sendTextMessage:(NSString *)text withExt:(NSDictionary*)ext
{
    EMMessage *message = [EaseSDKHelper sendTextMessage:text
                                                   to:self.conversation.conversationId
                                          messageType:[self _messageTypeFromConversationType]
                                           messageExt:ext];
    
//    EMMessage *message = [EaseSDKHelper sendTextMessage:@"[分享新闻]"
//                                                     to:self.conversation.conversationId
//                                            messageType:[self _messageTypeFromConversationType]
//                                             messageExt:ext];
    
    [self _sendMessage:message];
}

- (void)sendLocationMessageLatitude:(double)latitude
                          longitude:(double)longitude
                         andAddress:(NSString *)address
{
    EMMessage *message = [EaseSDKHelper sendLocationMessageWithLatitude:latitude
                                                            longitude:longitude
                                                              address:address
                                                                   to:self.conversation.conversationId
                                                          messageType:[self _messageTypeFromConversationType]
                          
                                                           messageExt:nil];
    [self _sendMessage:message];
}

- (void)sendImageMessageWithData:(NSData *)imageData compressionRatio:(CGFloat)compressionRatio
{
    id progress = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewController:progressDelegateForMessageBodyType:)]) {
        progress = [_dataSource messageViewController:self progressDelegateForMessageBodyType:EMMessageBodyTypeImage];
    }
    else{
        progress = self;
    }
    
    
    
    
    EMMessage *message = [EaseSDKHelper sendImageMessageWithImageData:imageData
                                                                   to:self.conversation.conversationId
                                                          messageType:[self _messageTypeFromConversationType]
                          
                                                           messageExt:nil compressionRatio:compressionRatio
                                                             ];
    [self _sendMessage:message];
}

- (void)sendImageMessage:(UIImage *)image
{
    id progress = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewController:progressDelegateForMessageBodyType:)]) {
        progress = [_dataSource messageViewController:self progressDelegateForMessageBodyType:EMMessageBodyTypeImage];
    }
    else{
        progress = self;
    }
    
    EMMessage *message = [EaseSDKHelper sendImageMessageWithImage:image
                                                             to:self.conversation.conversationId
                                                    messageType:[self _messageTypeFromConversationType]
                          
                                                     messageExt:nil
                                                     ];
    [self _sendMessage:message];
}

- (void)sendVoiceMessageWithLocalPath:(NSString *)localPath
                             duration:(NSInteger)duration
{
    id progress = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewController:progressDelegateForMessageBodyType:)]) {
        progress = [_dataSource messageViewController:self progressDelegateForMessageBodyType:EMMessageBodyTypeVoice];
    }
    else{
        progress = self;
    }
    
    EMMessage *message = [EaseSDKHelper sendVoiceMessageWithLocalPath:localPath
                                                           duration:duration
                                                                 to:self.conversation.conversationId
                                                        messageType:[self _messageTypeFromConversationType]
                          
                                                         messageExt:nil
                                                          ];
    [self _sendMessage:message];
}

- (void)sendVideoMessageWithURL:(NSURL *)url
{
    id progress = nil;
    if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewController:progressDelegateForMessageBodyType:)]) {
        progress = [_dataSource messageViewController:self progressDelegateForMessageBodyType:EMMessageBodyTypeVideo];
    }
    else{
        progress = self;
    }
    
    EMMessage *message = [EaseSDKHelper sendVideoMessageWithURL:url
                                                           to:self.conversation.conversationId
                                                  messageType:[self _messageTypeFromConversationType]
                          
                                                   messageExt:nil
                                                    ];
    [self _sendMessage:message];
}

#pragma mark - notifycation 通知
- (void)didBecomeActive
{
   
     self.isBecomeActive=YES;
    if (self.conversation.type==EMConversationTypeChatRoom)
    {
        [self getNetGetNewsGroupIDG:self.conversation.conversationId];
    }else if (self.conversation.type==EMConversationTypeGroupChat)
    {
      [self getNetGetNewsGroupIDG:self.conversation.conversationId];
    }
//    if ( ShareAppDelegate.isExistCurrentChatRoom)
//    {
//        
//    
//    self.dataArray = [[self formatMessages:self.messsagesSource] mutableCopy];
//    [self.tableView reloadData];
    
    //回到前台时
//    if (self.isViewDidAppear)
//    {
//        NSMutableArray *unreadMessages = [NSMutableArray array];
//        for (EMMessage *message in self.messsagesSource)
//        {
//            if ([self _shouldSendHasReadAckForMessage:message read:NO])
//            {
//                [unreadMessages addObject:message];
//            }
//        }
//        if ([unreadMessages count])
//        {
//            [self _sendHasReadResponseForMessages:unreadMessages isRead:YES];
//        }
//        
//        [_conversation markAllMessagesAsRead];
//    }
//    }
}
//=============
#pragma mark - private
- (void)_reloadTableViewDataWithMessage:(EMMessage *)message{
    if ([self.conversation.conversationId isEqualToString:message.conversationId])
    {
        for (int i = 0; i < self.dataArray.count; i ++) {
            id object = [self.dataArray objectAtIndex:i];
            if ([object isKindOfClass:[EaseMessageModel class]]) {
                id<IMessageModel> model = object;
                if ([message.messageId isEqualToString:model.messageId]) {
                    id<IMessageModel> model = nil;
                    if (self.dataSource && [self.dataSource respondsToSelector:@selector(messageViewController:modelForMessage:)]) {
                        model = [self.dataSource messageViewController:self modelForMessage:message];
                    }
                    else{
                        model = [[EaseMessageModel alloc] initWithMessage:message];
//                        model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
//                        model.failImageName = @"imageDownloadFail";
                    }
                    
                    [self.tableView beginUpdates];
                    [self.dataArray replaceObjectAtIndex:i withObject:model];
                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                    [self.tableView endUpdates];
                    break;
                }
            }
        }
    }}

- (void)_updateMessageStatus:(EMMessage *)aMessage
{
    BOOL isChatting = [aMessage.conversationId isEqualToString:self.conversation.conversationId];
    if (aMessage && isChatting) {
        id<IMessageModel> model = nil;
        if (_dataSource && [_dataSource respondsToSelector:@selector(messageViewController:modelForMessage:)]) {
            model = [_dataSource messageViewController:self modelForMessage:aMessage];
        }
        else{
            model = [[EaseMessageModel alloc] initWithMessage:aMessage];
           // model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
           // model.failImageName = @"imageDownloadFail";
        }
        if (model) {
            __block NSUInteger index = NSNotFound;
            [self.dataArray enumerateObjectsUsingBlock:^(EaseMessageModel *model, NSUInteger idx, BOOL *stop){
                if ([model conformsToProtocol:@protocol(IMessageModel)]) {
                    if ([aMessage.messageId isEqualToString:model.message.messageId])
                    {
                        index = idx;
                        *stop = YES;
                    }
                }
            }];
            
            if (index != NSNotFound)
            {
                [self.dataArray replaceObjectAtIndex:index withObject:model];
                [self.tableView beginUpdates];
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                [self.tableView endUpdates];
            }
        }
    }
}
- (NSArray*)_searchAtTargets:(NSString*)text
{
    NSMutableArray *targets = nil;
    if (text.length > 1) {
        targets = [NSMutableArray array];
        NSArray *splits = [text componentsSeparatedByString:@"@"];
        if ([splits count]) {
            for (NSString *split in splits) {
                if (split.length) {
                    NSString *atALl = NSEaseLocalizedString(@"group.atAll", @"all");
                    if ([split compare:atALl options:NSCaseInsensitiveSearch range:NSMakeRange(0, atALl.length)] == NSOrderedSame) {
                        [targets removeAllObjects];
                        [targets addObject:kGroupMessageAtAll];
                        return targets;
                    }
                    for (EaseAtTarget *target in self.atTargets) {
                        if ([target.userId length]) {
                            if ([split hasPrefix:target.userId] || (target.nickname && [split hasPrefix:target.nickname])) {
                                [targets addObject:target.userId];
                                [self.atTargets removeObject:target];
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
    return targets;
}
#pragma mark - 网络代理
/**
 * 禁言到时间,取消禁言
 */
- (void)getNetGroupGagTimeout:(NSString *)gId
{
    NSDictionary *info =[URLPath getNetGroupGagTimeoutP:gId];
    NSString *url = [info objectForKey:K_URL];
    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
    
//    __weak EaseMessageViewController *weakSelf = self;
    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData) {
        
        
       // DLog(@"成功--%@",respostData);
        
        int rs=[[respostData safeObjectForKey:K_rs] intValue];
//        NSString  *msg=[respostData objectForKey:k_msg];
        
        if (rs==1)
        {

        } else
        {

        }
        
       
    } failed:^(NSString *errorMsg)
     
     {
         
     }];
}
/**
 *  聊天室禁言时间到取消禁言
 *
 *  @param roomId 聊天室id
 *
 */
- (void)getNetChatroomForbidtimeout:(NSString *)roomId
{
    //    [SVProgressHUD showWithStatus:@"请求数据中....."];
    
    
    NSDictionary *info =[URLPath getNetChatroomForbidtimeoutP:roomId];
    NSString *url = [info objectForKey:K_URL];
    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
    
        __weak EaseMessageViewController *weakSelf = self;
    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData) {
        
        
       // DLog(@"成功--%@",respostData);
        
        int rs=[[respostData safeObjectForKey:K_rs] intValue];
        //        NSString  *msg=[respostData objectForKey:k_msg];
        
        if (rs==1)
        {
            weakSelf.m_groupForbidModel.m_isforbid=@"0";
            weakSelf.m_groupForbidModel.m_remainTime=@"0";
        } else
        {
           
        }
        
     
    } failed:^(NSString *errorMsg)
     
     {
         
         
     }];
}
/**
 *  设置历史聊天室
 *
 *  @param roomId 聊天室id
 *
 */
- (void)getNetChatroomSetHistory:(NSString *)roomId
{
    
    
    
    NSDictionary *info =[URLPath getNetChatroomSetHistoryP:roomId];
    NSString *url = [info objectForKey:K_URL];
    NSDictionary *param = [info objectForKey:K_URL_PARAMETER];
    
    //    __weak EaseMessageViewController *weakSelf = self;
    [[AFHTTPClient share] postMethod:url param:param success:^(NSDictionary *respostData) {
        
        
       // DLog(@"成功--%@",respostData);
        
        int rs=[[respostData safeObjectForKey:K_rs] intValue];
       
        
        if (rs==1)
        {
            
        } else
        {
           
        }
        
       
    } failed:^(NSString *errorMsg)
     
     {
         
         
     }];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[YYLabel class]]){
        //        YYLabel *label = (YYLabel *)touch.view;
        //        if ([label containslinkAtPoint:[touch locationInView:label]]){
        return NO;
        //        }else{
        //            return YES;
        //        }
    }else{
        return YES;
    }
}
-(void)goBack:(UISwipeGestureRecognizer*)sender
{
    
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}



- (void)takePhoto {
    
    if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag = 1;
        [alert show];
        
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            return [self takePhoto];
            
        });
        
    } else { // 调用相机
        [SVProgressHUD showWithStatus:@"正在读取..."];
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
        
        ChoosePhotosViewController * cc= [storyboard instantiateViewControllerWithIdentifier:@"ChoosePhotosViewController"];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:cc];
        //            [cc.m_chooseArray removeAllObjects];
        
        cc.delegate = self;
        [self.m_imageArray removeAllObjects];
        cc.m_chooseArray = self.m_imageArray;
        [self presentViewController:nav animated:YES completion:^{
            
        }];
        
    }
}


#pragma mark - ChoosePhotos
-(void)ChoosePhotosDelegateSendingPictures:(NSMutableArray *)array
{
    
    [self haveNumberImage:0 imageArray:array];
    
    
    
    
    
}

-(void)haveNumberImage:(NSInteger)numer imageArray:(NSMutableArray *)array
{
    
    
    [TZImageManager manager].photoPreviewMaxWidth = 600;
    TZAssetModel * model;
    
    if (numer != self.m_imageArray.count) {
         model =[self.m_imageArray safeObjectAtIndex:numer];
    }else{
        return;
    }
    if (model) {
        
    __weak typeof(self) weakSelf = self;
        
        
      [[TZImageManager manager]getOriginalPhotoDataWithAsset:model.asset completion:^(NSData *data, NSDictionary *info, BOOL isDegraded) {
    
       
         // 当前UIImage是否是低质量的，这个可以实现给用户先显示一个预览图
          if (!isDegraded) {
              
              
              if (model.m_isOriginalImage) {//原图
                  
                  CGFloat dataKBytes = data.length/1000.0;
                  NSData * imageData ;
                  //判断原图大于10M么  大于就压缩到10M
                  if (dataKBytes > 1024*10) {
                      
                       imageData = [data compressToMaxDataSizeKBytes:1024*10];
                      [weakSelf sendImageMessageWithData:imageData compressionRatio:1.0];
                  }else{
                      
                      
                        [weakSelf sendImageMessageWithData:data compressionRatio:1.0];
                  }
                  
                  
            
                  
              }else{//压缩图
                  
                  
                  CGFloat dataKBytes = data.length/1000.0;
                  NSData * imageData ;
                  //判断大于500K么 大于就压缩上传
                  if (dataKBytes > 500) {
                      
                      imageData = [data compressToMaxDataSizeKBytes:1024*10];
                        [weakSelf sendImageMessageWithData:imageData compressionRatio:0.6];
                  }else{
                      
                        [weakSelf sendImageMessageWithData:data compressionRatio:0.6];
                      
                  }

                  
                
              }
              
              
              [weakSelf haveNumberImage:numer+1 imageArray:array];
              
          }

          
       
      }];
//    [[TZImageManager manager]getPhotoWithAssetXSD:model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
//       
//        if ([info[PHImageResultIsDegradedKey]integerValue]==0) {
//            
//        
//            if (model.m_isOriginalImage) {//原图
//                
//                    [weakSelf sendImageMessageWithData:UIImagePNGRepresentation(photo)compressionRatio:1.0];
//                
//            }else{//压缩图
//                
//                 [weakSelf sendImageMessageWithData:UIImagePNGRepresentation(photo)compressionRatio:0.6];
//            }
//        
//            
//            [weakSelf haveNumberImage:numer+1 imageArray:array];
//                
//        }
//        }];
    }
}


@end
