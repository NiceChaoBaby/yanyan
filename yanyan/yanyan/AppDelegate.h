//
//  AppDelegate.h
//  yanyan
//
//  Created by xiong on 2017/6/21.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign)BOOL m_WXstark;//分享
@property(nonatomic)BOOL isWifi;
//房间id聊天室
@property (nonatomic,strong)  NSString                              *m_roomId;
/**
 *  点击聊天室的置顶
 */
@property(nonatomic,strong) NSMutableArray * m_topDataArray;
/**
 *  记录聊天室人数数组
 */
@property(nonatomic,strong)NSMutableArray * m_ChatNumberPeople;
//存放单个聊天室信息
@property(nonatomic,strong) NSMutableDictionary *m_chatRoomDict;

/**
 答题答案记录字典   Key为房间ID
 
 */
@property(nonatomic,strong)NSMutableDictionary * m_ActorsAuditio;
/**
 *  当前页面是否在聊天室
 */
@property(nonatomic,assign) BOOL isExistChatRoom;
/**
 *  积分字典
 */
@property(nonatomic,strong)NSMutableDictionary * m_integralRules;
/**
 * 记录房间环信的ID  当退出房间的时候  房间ID清空  只针对群组 和 私聊
 */

@property(nonatomic,strong)NSString * m_easeID;
-(void)login;
@end

