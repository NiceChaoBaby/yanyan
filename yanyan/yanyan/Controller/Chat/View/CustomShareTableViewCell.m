//
//  CustomShareTableViewCell.m
//  chat
//
//  Created by dong on 16/4/27.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "CustomShareTableViewCell.h"

@implementation CustomShareTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [DTools getLabelCorner:self.m_avatarImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
