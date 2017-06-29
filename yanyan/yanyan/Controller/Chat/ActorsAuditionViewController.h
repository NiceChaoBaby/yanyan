//
//  ActorsAuditionViewController.h
//  chat
//
//  Created by 高超 on 2017/5/12.
//  Copyright © 2017年 Dong. All rights reserved.
//
//演员试镜问题
#import <UIKit/UIKit.h>
#import "ActorsAuditionModel.h"
#import "NewsPlazaModel.h"
@interface ActorsAuditionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *m_tableView;
//model数据
@property(nonatomic,strong)ActorsAuditionModel * m_model;


/**
 *  列表Model
 */
@property (nonatomic,strong) NewsPlazaModel *model;
/**
 判断是从列表点击过来的  还是从详情
 */
@property(nonatomic,assign)BOOL m_fromStatListandData;
@end
