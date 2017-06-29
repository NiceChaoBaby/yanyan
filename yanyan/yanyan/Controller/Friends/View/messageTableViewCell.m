//
//  messageTableViewCell.m
//  chat
//
//  Created by 高超 on 16/3/17.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "messageTableViewCell.h"

@implementation messageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(messageTableViewCell *)createTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath titleDataArr:(NSMutableArray *)titleDataArr FriendInformationModel:(FriendInformationModel*)userInfoModel
{
    
    static NSString * identifer1 = @"messageTableViewCell";
    
    UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:identifer1];
    
    messageTableViewCell * cell = (messageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.m_titleLab.hidden = NO;
    cell.m_contentLab.hidden = NO;
    NSArray *arr=[titleDataArr safeObjectAtIndex:indexPath.section];
    cell.m_titleLab.text = arr[indexPath.row];
    cell.m_titleLab.numberOfLines =1;
    
    cell.m_titleLab.lineBreakMode = NSLineBreakByTruncatingTail;
    switch (indexPath.section)
    {
        case 0:
            if (indexPath.row == 0) {
                cell.m_contentLab.text = userInfoModel.m_numSerial;
            }else if (indexPath.row == 1){
                
                cell.m_contentLab.text = userInfoModel.m_levels;
            }else if (indexPath.row==2)
            {
                if([userInfoModel.m_gender isEqualToString:@"1"])
                {
                    cell.m_contentLab.text=@"男";
                }else
                {
                    cell.m_contentLab.text=@"女";
                }
                
            }
            else if (indexPath.row==3)
            {
                cell.m_contentLab.text=userInfoModel.m_birth;
            }else if (indexPath.row==4)
            {
                cell.m_contentLab.text=[DTools getUserAge:userInfoModel.m_birth];
                
            }else if (indexPath.row==5)
            {
                cell.m_contentLab.text=userInfoModel.m_signature;
                [cell.m_contentLab sizeToFit];
            }
            break;
        case 1:
            if (indexPath.row==0)
            {
                if([userInfoModel.m_emotion isEqualToString:@"0"])
                {
                    cell.m_contentLab.text=@"保密";
                }else if ([userInfoModel.m_emotion isEqualToString:@"1"])
                {
                    cell.m_contentLab.text=@"单身";
                }else if ([userInfoModel.m_emotion isEqualToString:@"2"])
                {
                    cell.m_contentLab.text=@"已婚";
                }
            }else if (indexPath.row==1)
            {
                cell.m_contentLab.text=userInfoModel.m_intrest;
            }else if (indexPath.row==2)
            {
                cell.m_contentLab.text=userInfoModel.m_homeTown;
            }
            break;
        default:
            break;
    }
//    if (indexPath.section==0&&indexPath.row==3)
//    {
//        cell.backgroundColor=RGBBgColor;
//    }else
//    {
        cell.backgroundColor=[UIColor whiteColor];
    
   
//    }
    return cell;
    
    

}

@end
