//
//  MemberTableViewCell.m
//  chat
//
//  Created by 高超 on 16/3/17.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "MemberTableViewCell.h"

@implementation MemberTableViewCell

- (void)awakeFromNib {
   [super awakeFromNib];
    // Initialization code
   // [DTools getLabelCorner:self.m_menberFlagLab];
    [DTools getCorner:self.m_userPhoto radius:self.m_userPhoto.frame.size.height/2];
     [DTools getCorner:self.m_menberFlagLab radius:2];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
