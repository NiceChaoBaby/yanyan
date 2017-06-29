//
//  MovieFanViewController.h
//  yanyan
//
//  Created by xiong on 2017/6/21.
//  Copyright © 2017年 XSD. All rights reserved.
//
//影迷圈
#import <UIKit/UIKit.h>

@interface MovieFanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

/**
 列表
 */
@property(nonatomic,strong)UITableView * m_tableView;
@end
