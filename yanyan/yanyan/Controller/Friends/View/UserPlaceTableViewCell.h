//
//  UserPlaceTableViewCell.h
//  chat
//
//  Created by 高超 on 16/3/17.
//  Copyright © 2016年 Dong. All rights reserved.
//
//用户足迹
#import <UIKit/UIKit.h>

@interface UserPlaceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *m_place;//足迹地名
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *m_titlePlaceLab;

/**
 *  背景视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *m_bgImageView;


+(UserPlaceTableViewCell *)createTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath titleDataArr:(NSMutableArray *)titleDataArr;


@end
