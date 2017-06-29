////
////  ChatMessageViewController.m
////  chat
////
////  Created by dong on 16/4/11.
////  Copyright © 2016年 Dong. All rights reserved.
////
//
//#import "ChatMessageViewController.h"
//#import "TBActionSheet.h"
//#import "CustomMessageTableViewCell.h"
//#import "BlockModel.h"
//#import "GroupMemberModel.h"
//@interface ChatMessageViewController ()<EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource,TBActionSheetDelegate,CustomMessageTableViewCellDelegate>
///**
// *  表情字典
// */
//@property(nonatomic,strong) NSMutableDictionary *m_emotionDic;
//
//
//@end
//
//@implementation ChatMessageViewController
//
//- (void)viewDidLoad {
//    
//    [super viewDidLoad];
//    
//    self.delegate = self;
//    self.dataSource = self;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(concelBlockUser:) name:K_Unblock_User object:nil];
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(concelForbidUser:) name:K_Unforbid_User object:nil];
//    // Do any additional setup after loading the view.
//}
//#pragma mark - EaseMessageViewControllerDelegate
///*!
// @method
// @brief 是否允许长按
// @discussion 获取是否允许长按的回调,默认是NO
// @param viewController 当前消息视图
// @param indexPath 长按消息对应的indexPath
// @result
// */
//- (BOOL)messageViewController:(EaseMessageViewController *)viewController
//   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
///*!
// @method
// @brief 触发长按手势
// @discussion 获取触发长按手势的回调,默认是NO
// @param viewController 当前消息视图
// @param indexPath 长按消息对应的indexPath
// @result
// */
//- (BOOL)messageViewController:(EaseMessageViewController *)viewController
//   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    id object = [self.dataArray objectAtIndex:indexPath.row];
//    if (![object isKindOfClass:[NSString class]]) {
//        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//        [cell becomeFirstResponder];
//        self.menuIndexPath = indexPath;
//        //  [self _showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
//    }
//    return YES;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//     self.menuIndexPath = indexPath;
//}
//#pragma mark - EaseMessageViewControllerDataSource
///*!
// @method
// @brief 将EMMessage类型转换为符合<IMessageModel>协议的类型
// @discussion 将EMMessage类型转换为符合<IMessageModel>协议的类型,设置用户信息,消息显示用户昵称和头像
// @param viewController 当前消息视图
// @param EMMessage 聊天消息对象类型
// @result 返回<IMessageModel>协议的类型
// */
//- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
//                           modelForMessage:(EMMessage *)message
//{
//    id<IMessageModel> model = nil;
//    model = [[EaseMessageModel alloc] initWithMessage:message];
//
//    return model;
//}
//
//- (NSArray*)emotionFormessageViewController:(EaseMessageViewController *)viewController
//{
//    NSMutableArray *emotions = [NSMutableArray array];
//    for (NSString *name in [EaseEmoji allEmoji]) {
//        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:[EaseConvertToCommonEmoticonsHelper convertToSystemEmoticons:name] emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
//        [emotions addObject:emotion];
//    }
////    EaseEmotion *temp = [emotions objectAtIndex:0];
//    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:@"f_static_001"]];
//    
//    NSMutableArray *emotionGifs = [NSMutableArray array];
//    self.m_emotionDic = [NSMutableDictionary dictionary];
//    NSArray *names = @[@"a_001",@"a_002",@"a_003",@"a_004",@"a_005",@"a_006",@"a_007",@"a_008",@"a_009",@"a_010",@"a_011",@"a_012",@"a_013",@"a_014",@"a_015",@"a_016",@"a_017",@"a_018",@"a_019",@"a_020",@"a_021",@"a_022",@"a_023",@"a_024",@"a_025",@"a_026",@"a_027",@"a_028",@"a_029"];
//    
//    
//    NSArray *names2 = @[@"[你说呢]",@"[切]",@"[渣渣]",@"[你谁呀]",@"[智障]",@"[嘿嘿]",@"[哈哈哈]",@"[-1]",@"[+1]",@"[不玩了]",@"[节操]",@"[买个表]",@"[同意]",@"[别在意]",@"[太棒了]",@"[别说了]",@"[真逗]",@"[睡觉]",@"[呵呵]",@"[说得好]",@"[欢迎]",@"[看你]",@"[你好]",@"[吼耶]",@"[唱歌]",@"[差不多]",@"[大笑]",@"[呜呜呜]",@"[帅气]"];
//    int index = 0;
//    for (NSString *name in names) {
//        index++;
//        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:[NSString stringWithFormat:@"%@",[names2 objectAtIndex:index-1]] emotionId:[NSString stringWithFormat:@"em%d",(1000 + index)] emotionThumbnail:[NSString stringWithFormat:@"%@_cover",name] emotionOriginal:[NSString stringWithFormat:@"%@",name] emotionOriginalURL:@"" emotionType:EMEmotionGif];
//        [emotionGifs addObject:emotion];
//        [self.m_emotionDic setObject:emotion forKey:[NSString stringWithFormat:@"em%d",(1000 + index)]];
//    }
//    EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionGif emotionRow:2 emotionCol:4 emotions:emotionGifs tagImage:[UIImage imageNamed:@"icon_002_cover"]];
//    
//    return @[managerDefault,managerGif];
//}
//
///*!
// @method
// @brief 判断消息是否为表情消息
// @discussion
// @param viewController 当前消息视图
// @param message 要发送已读回执的message
// @param messageModel 消息模型
// @result
// */
//- (BOOL)isEmotionMessageFormessageViewController:(EaseMessageViewController *)viewController
//                                    messageModel:(id<IMessageModel>)messageModel
//{
//    BOOL flag = NO;
//    if ([messageModel.message.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
//        return YES;
//    }
//    return flag;
//}
///*!
// @method
// @brief 根据消息获取表情信息
// @discussion
// @param viewController 当前消息视图
// @param message 要发送已读回执的message
// @param messageModel 消息模型
// @result
// */
//- (EaseEmotion*)emotionURLFormessageViewController:(EaseMessageViewController *)viewController
//                                      messageModel:(id<IMessageModel>)messageModel
//{
//    NSString *emotionId = [messageModel.message.ext objectForKey:MESSAGE_ATTR_EXPRESSION_ID];
//    EaseEmotion *emotion = [self.m_emotionDic objectForKey:emotionId];
//    if (emotion == nil) {
//        emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:emotionId emotionThumbnail:@"" emotionOriginal:@"" emotionOriginalURL:@"" emotionType:EMEmotionGif];
//    }
//    return emotion;
//}
///*!
// @method
// @brief 获取发送表情消息的扩展字段
// @discussion
// @param viewController 当前消息视图
// @param easeEmotion
// @result
// */
//- (NSDictionary*)emotionExtFormessageViewController:(EaseMessageViewController *)viewController
//                                        easeEmotion:(EaseEmotion*)easeEmotion
//{
//    return @{MESSAGE_ATTR_EXPRESSION_ID:easeEmotion.emotionId,MESSAGE_ATTR_IS_BIG_EXPRESSION:@(YES)};
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//#pragma mark- 通知
//-(void)concelBlockUser:(NSNotification *)noti
//{
//    BlockModel *block=noti.object;
//    for (BlockModel *model in self.m_blockListArr)
//    {
//        if ([model.m_blockUid isEqualToString:block.m_blockUid])
//        {
//            [self.m_blockListArr removeObject:model];
//            break;
//        }
//    }
//    
//}
//-(void)concelForbidUser:(NSNotification *)noti
//{
//    GroupMemberModel *block=noti.object;
//    for (int i=0;i<ShareAppDelegate.m_ChatNumberPeople.count;i++ )
//    {
//        ChatMemberListModel *model =[ShareAppDelegate.m_ChatNumberPeople objectAtIndex:i];
//        if ([model.m_id isEqualToString:block.m_id])
//        {
//            model.m_isForbid=@"0";
//            model.m_endDate=nil;
//            model.m_remainTime=0;
//            [ShareAppDelegate.m_ChatNumberPeople replaceObjectAtIndex:i withObject:model];
//            break;
//        }
//    }
//   
//}
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
//@end
