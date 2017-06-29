//
//  messageTableViewCell.h
//  chat
//
//  Created by 高超 on 16/3/17.
//  Copyright © 2016年 Dong. All rights reserved.
//
//用户签名 等其他信息Cell
#import <UIKit/UIKit.h>
#import "FriendInformationModel.h"
@interface messageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *m_contentLab;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *m_titleLab;


+(messageTableViewCell *)createTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath titleDataArr:(NSMutableArray *)titleDataArr FriendInformationModel:(FriendInformationModel*)userInfoModel;


@end
