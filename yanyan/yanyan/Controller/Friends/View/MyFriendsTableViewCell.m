//
//  MyFriendsTableViewCell.m
//  chat
//
//  Created by 高超 on 16/3/11.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "MyFriendsTableViewCell.h"
#import "FriendAloneChatViewController.h"
#import "LookUserViewController.h"
@implementation MyFriendsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [DTools getCorner:self.m_avatarImageView radius:self.m_avatarImageView.frame.size.height/2];
     [DTools getCorner:self.m_clickButton radius:self.m_clickButton.frame.size.height/2];
    [DTools getLabelCorner:self.m_genderBgView];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  更新数据
 *
 *  @param friendListModel 好友model
 */
-(void)refreshData:(FriendListModel *)friendListModel
{
    self.m_friendListModel=friendListModel;
    [self.m_avatarImageView sd_setImageWithURL:[NSURL URLWithString:friendListModel.m_avatar] placeholderImage:ImageNamed(K_avaterPHImage)];
    
    self.m_friendName.text=friendListModel.m_nickname;
    self.m_friendNameConstraint.constant=[friendListModel.m_nickname sizeWithFont:[UIFont systemFamilyFontOfSize:16] maxSize:CGSizeMake(MAXFLOAT, 20)].width+10;
    //判断是男是女：性别 1男  2女
    if ([friendListModel.m_gender isEqualToString:@"1"])
    {
        [self.m_genderImageView setImage:ImageNamed(@"man")];
      
        
    }else
    {
        [self.m_genderImageView setImage:ImageNamed(@"women")];
       
    }
    self.m_signature.text=friendListModel.m_signature;
    self.m_ageLab.text=[DTools getUserAge:friendListModel.m_birth];
    
    self.m_distanceLab.hidden = YES;//距离暂时隐藏
    self.m_distanceLab.text=[DTools getBetweenDistance:friendListModel.m_lat lng:friendListModel.m_lng];
    
}
- (IBAction)clickButton:(id)sender
{
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Friends" bundle:nil];
        LookUserViewController * lookuser = [storyboard instantiateViewControllerWithIdentifier:@"LookUserViewController"];
    
        lookuser.m_uid=self.m_friendListModel.m_fuid;
    lookuser.m_from = self.m_friendListModel.m_source;
   
    [[DTools getViewController:self].navigationController pushViewController:lookuser animated:YES];
}
@end
