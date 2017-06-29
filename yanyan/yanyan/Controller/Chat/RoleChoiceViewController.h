//
//  RoleChoiceViewController.h
//  chat
//
//  Created by 高超 on 2017/5/11.
//  Copyright © 2017年 Dong. All rights reserved.
//
//角色名单
#import "ViewController.h"
#import "RolePlayTableViewCell.h"
#import "RoleIntroduceInfo.h"
#import "CharacterIntroduced.h"
#import "NewsPlazaModel.h"
@interface RoleChoiceViewController : UIViewController


@property(nonatomic,strong)UITableView * m_tableView;


/**
 环信聊天室ID
 */
@property(nonatomic,strong)NSString * m_easeId;

/**
 我们自己的房间
 */
@property(nonatomic,assign)int m_roomID;


/**
 *  列表Model
 */
@property (nonatomic,strong) NewsPlazaModel *model;

@property(nonatomic,strong)NSMutableArray * m_dataArray;


/**
 判断是从列表点击过来的  还是从详情
 */
@property(nonatomic,assign)BOOL m_fromStatListandData;
@end
