//
//  NoticeMessageTableViewCell.m
//  chat
//
//  Created by dong on 16/4/19.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "NoticeMessageTableViewCell.h"

@implementation NoticeMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   [DTools getCorner:self.m_bgView radius:5];
//    self.m_titleLab.textInsets=UIEdgeInsetsMake(5.f, 10.f, 5.f, 10.f); // 设置左右内边距
       self.m_titleLab.numberOfLines = 0;//根据最大行数需求来设置
        self.m_titleLab.lineBreakMode = NSLineBreakByTruncatingTail;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
