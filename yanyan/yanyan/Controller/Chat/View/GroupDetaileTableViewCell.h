//
//  GroupDetaileTableViewCell.h
//  chat
//
//  Created by 高超 on 16/3/15.
//  Copyright © 2016年 Dong. All rights reserved.
//
//已加入群组信息   群组管理 cell
#import <UIKit/UIKit.h>

@interface GroupDetaileTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_NameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *m_Btn;


+(GroupDetaileTableViewCell *)createTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath headTitleArray:(NSArray *)headTitleArray;

@end
