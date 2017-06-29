//
//  BlackListTableViewCell.m
//  chat
//
//  Created by 高超 on 16/5/3.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "BlackListTableViewCell.h"
//#import "BlickListModel.h"
@implementation BlackListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(BlackListTableViewCell *)createCellTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSMutableArray *)dataArray
{
    //加载Xib
    static NSString * identifer1 = @"BlackListTableViewCell";
    UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:identifer1];
    
    BlackListTableViewCell * cell = (BlackListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
    //6.26 xiong
    
//    BlickListModel *model=[dataArray safeObjectAtIndex:indexPath.row];
//    cell.m_userNameLable.text = model.m_nickName;
//    [cell.m_userPhotoImage sd_setImageWithURL:[NSURL URLWithString:model.m_avatar] placeholderImage:ImageNamed(K_avaterPHImage)];
//    [DTools setImageView:cell.m_userPhotoImage];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
