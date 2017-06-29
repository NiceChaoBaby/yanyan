//
//  GroupDetaileTableViewCell.m
//  chat
//
//  Created by 高超 on 16/3/15.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "GroupDetaileTableViewCell.h"

@implementation GroupDetaileTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(GroupDetaileTableViewCell *)createTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath headTitleArray:(NSArray *)headTitleArray
{
    //加载Xib
    static NSString * identifer1 = @"GroupDetaileTableViewCell";
    UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:identifer1];
    
    GroupDetaileTableViewCell * cell = (GroupDetaileTableViewCell * )[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //加载数据
    NSArray * titleArray = headTitleArray[indexPath.section];
    cell.m_NameLabel.text = titleArray[indexPath.row];
    
    return cell;

    
    
}

@end
