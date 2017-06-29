//
//  RoleIntroduceTableViewCell.m
//  chat
//
//  Created by 高超 on 2017/5/12.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "RoleIntroduceTableViewCell.h"

@implementation RoleIntroduceTableViewCell

-(UILabel *)m_introduceStr
{
    if (!_m_introduceStr) {
        _m_introduceStr = [UILabel new];
        _m_introduceStr.textColor = RGBChatTextColor;
        _m_introduceStr.font = [UIFont systemFamilyFontOfSizeNoScale:17.0f];
    }

    return _m_introduceStr;
}

// 重写构造方法 -- 只调用一次嘛 （套路来的！务必记住！）
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView sd_addSubviews:@[self.m_introduceStr]];
        self.m_introduceStr.sd_layout
        .topSpaceToView(self.contentView, 15)
        .leftSpaceToView(self.contentView, 15)
        .rightSpaceToView(self.contentView, 15)
        .autoHeightRatio(0);
        [self setupAutoHeightWithBottomView:self.m_introduceStr bottomMargin:15];
    }
    
    return self;
}


-(void)setM_model:(RoleIntroduceModel *)m_model
{
    
    self.m_introduceStr.text = m_model.m_inrroduce;
    
}

-(void)setM_ActorsModel:(ActorsAuditionModel *)m_ActorsModel
{
    
     self.m_introduceStr.text = m_ActorsModel.m_question;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
