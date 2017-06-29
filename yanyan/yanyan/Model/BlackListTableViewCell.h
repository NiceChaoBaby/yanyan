//
//  BlackListTableViewCell.h
//  chat
//
//  Created by 高超 on 16/5/3.
//  Copyright © 2016年 Dong. All rights reserved.
//
//黑名单用户Cell
#import <UIKit/UIKit.h>
//#import "FriendListModel.h"
@interface BlackListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *m_userPhotoImage;//用户头像
@property (weak, nonatomic) IBOutlet UILabel *m_userNameLable;//用户名


+(BlackListTableViewCell *)createCellTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSMutableArray *)dataArray;


@end
