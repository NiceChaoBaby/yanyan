//
//  ChatViewController.h
//  chat
//
//  Created by dong on 16/3/8.
//  Copyright © 2016年 Dong. All rights reserved.
//聊天室

//#import "DRootViewController.h"
//#import "EaseMessageViewController.h"

#import "RoleIntroduceInfo.h"
#import "NewsPlazaModel.h"
//#import "ChatMessageViewController.h"
@interface ChatViewController : UIViewController
/**
 *  会话ID
 */
@property(nonatomic,strong) NSString *m_aConversationId;
@property(nonatomic,strong)NSString * m_titleTopic;//话题标题
@property(nonatomic,strong)NSString * m_RoleDataID;//请求角色扮演详情ID
@property(nonatomic,strong)RoleIntroduceInfo * m_model;
@property(nonatomic,strong)NewsPlazaModel * m_listModel;



#pragma mark -- topicTimeView

@property(nonatomic) BOOL m_isTime10;
@property(nonatomic) BOOL m_isTime5;
@property(nonatomic) BOOL m_isTime1;
@property(nonatomic) BOOL m_isTime0;

@property(nonatomic) BOOL isMessageJoin;
/**
 *  比较时间
 */
-(void)startCompareTime;
/**
 *  取消定时器
 */
-(void)deletePerformSelector;
/**
 *  标题
 */
@property(nonatomic,strong) UILabel *m_title;
/**
 *  结束时间
 */
@property(nonatomic,strong) NSString *m_remainTime;


@end
