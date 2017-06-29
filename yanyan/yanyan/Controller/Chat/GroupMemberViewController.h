//
//  GroupMemberViewController.h
//  chat
//
//  Created by 高超 on 16/3/17.
//  Copyright © 2016年 Dong. All rights reserved.
//群成员

#import <UIKit/UIKit.h>
@protocol GroupMemberViewControllerDelegate <NSObject>
/**
 *  更新数据
 *
 *  @param arrData
 */
-(void)GroupMemberViewUpdata:(NSMutableArray *)arrData;

@end
@interface GroupMemberViewController : UIViewController
@property(nonatomic,strong) NSMutableArray *m_dataArr;
@property(nonatomic,strong) NSMutableArray *m_dataBlockArr;
/**
 *  0 成员  1 群主  2  管理员
 */
@property(nonatomic,strong) NSString *m_isManager;
/**
 *  是否是聊天室
 */
@property(nonatomic,assign) BOOL m_isChat;
/**
 *  聊天室内类型
 */
@property(nonatomic,assign)ChatRoomType m_chatRoomType;
//判断是从群组详情跳转过来的
@property(nonatomic,assign) BOOL m_groupPeople;
//来源
@property(nonatomic,strong)NSString * m_form;
@property(nonatomic,strong) id<GroupMemberViewControllerDelegate> delegate;
@end

