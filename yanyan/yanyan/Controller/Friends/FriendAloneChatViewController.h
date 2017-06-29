//
//  FriendAloneChatViewController.h
//  chat
//
//  Created by dong on 16/3/24.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>


//#import "EaseMessageViewController.h"
#import "FriendListModel.h"
#import "NoticeModel.h"
@interface FriendAloneChatViewController : UIViewController
/**
 *  会话ID
 */
@property(nonatomic,strong) NSString *m_aConversationId;
/**
 *  名字
 */
@property(nonatomic,strong) NSString *m_friendName;
/**
 *  通知model
 */
@property(nonatomic,strong) NoticeModel *m_noticeModel;
/**
 * 好友详情
 */
@property(nonatomic,strong) FriendListModel *m_friendListModel;
@end
