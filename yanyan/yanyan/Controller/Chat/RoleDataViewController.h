//
//  RoleDataViewController.h
//  chat
//
//  Created by 高超 on 2017/5/11.
//  Copyright © 2017年 Dong. All rights reserved.
//
//角色扮演详情
#import <UIKit/UIKit.h>

@interface RoleDataViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *m_tableview;
@property (weak, nonatomic) IBOutlet UILabel *m_roomName;
@property (weak, nonatomic) IBOutlet UIButton *m_goRoomBtn;
@property (nonatomic,strong)NSString * m_roomId;//房间ID
/**
 *  判断是不是聊天室跳转
 */
@property(nonatomic,assign)BOOL m_isChatRoomPush;


/**
 黑名单数组
 */
@property(nonatomic,strong) NSMutableArray *m_dataBlockArr;

@end
