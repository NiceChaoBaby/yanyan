//
//  HotTVDetailsViewController.h
//  yanyan
//
//  Created by 高超 on 2017/6/29.
//  Copyright © 2017年 XSD. All rights reserved.
//
//用户某个影评详情页
#import <UIKit/UIKit.h>

@interface HotTVDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>



/**
 列表
 */
@property(nonatomic,strong)UITableView * m_tableView;
@end
