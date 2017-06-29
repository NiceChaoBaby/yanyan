//
//  ActorsAuditionCell.m
//  chat
//
//  Created by 高超 on 2017/5/15.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "ActorsAuditionCell.h"
#import "AnswerModel.h"
@implementation ActorsAuditionCell

/*************懒加载********************/

-(UILabel *)m_label
{
    if (!_m_label) {
        _m_label = [UILabel new];
        _m_label.textColor = RGBChatTextColor;
        _m_label.font = [UIFont systemFamilyFontOfSizeNoScale:16.f];
          _m_optionsLabel.isAttributedContent = YES;
    }
    return _m_label;
}
-(UILabel *)m_optionsLabel
{
    if (!_m_optionsLabel) {
        _m_optionsLabel = [UILabel new];
        _m_optionsLabel.textColor = RGBChatTextColor;
        _m_optionsLabel.font = [UIFont systemFamilyFontOfSizeNoScale:16.f];
        _m_optionsLabel.isAttributedContent = YES;

    }
    
    return _m_optionsLabel;
    
}
-(UIImageView *)m_passImage
{
    if (!_m_passImage) {
        _m_passImage = [UIImageView new];
        _m_passImage.backgroundColor = [UIColor clearColor];
    }
    
    
    return _m_passImage;
}


-(UIImageView *)m_userPhotoImage
{
    if (!_m_userPhotoImage) {
        _m_userPhotoImage = [UIImageView new];
        _m_userPhotoImage.hidden = YES;
        _m_userPhotoImage.clipsToBounds = YES;
       [_m_userPhotoImage setContentMode:UIViewContentModeScaleAspectFill];
    }
    
    return _m_userPhotoImage;
}




/*************************************/



// 重写构造方法 -- 只调用一次嘛 （套路来的！务必记住！）
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView sd_addSubviews:@[self.m_userPhotoImage,self.m_optionsLabel,self.m_label,self.m_passImage]];
        
        //头像
        self.m_userPhotoImage.sd_layout
        .leftSpaceToView(self.contentView, 35)
        .topSpaceToView(self.contentView, 2.5)
        .widthIs(70)
        .heightIs(70);
        
        
        //选项abc
        self.m_optionsLabel.sd_layout
        .leftSpaceToView(self.m_userPhotoImage, 10)
        .centerYEqualToView(self.m_userPhotoImage)
        .widthIs(10)
        .autoHeightRatio(0);
        
        
        //选项内容
        self.m_label.sd_layout
        .leftSpaceToView(self.m_optionsLabel, 10)
        .topEqualToView(self.m_optionsLabel)
        .rightSpaceToView(self.contentView, 40)
        .autoHeightRatio(0);
        
        
        //选项图片对错
        self.m_passImage.sd_layout
        .centerXEqualToView(self.m_optionsLabel)
        .topSpaceToView(self.contentView, 19)
        .widthIs(35)
        .heightIs(35);
        
          [self setupAutoHeightWithBottomView:self.m_label bottomMargin:17.5];
        
    }
    
    return self;
}

//-(void)setM_model:(ActorsAuditionModel *)m_model
//{
//    self.m_model = m_model;
//    
//    
//    self.m_label.text =  m_model.m_title;
//}

-(void)setM_ActorsModel:(ActorsAuditionModel *)m_ActorsModel
{
    
    
    _m_ActorsModel = m_ActorsModel;
    AnswersModel * model  = [m_ActorsModel.m_answersArray safeObjectAtIndex:self.tag];

    NSArray * array = @[@"A",@"B",@"C",@"D"];
    //选项头字母
    self.m_optionsLabel.text = [array safeObjectAtIndex:self.tag];
//    model.m_answer = @"斯柯达积分快圣诞节疯狂山东矿机分开说的九分裤圣诞节付款束带结发看束带结发kakdfkaskdfkasd房间阿斯兰的房间暗恋谁看得见发了斯柯达卷发拉克丝点击法拉克圣诞节副科级按时点开链接发奥斯卡来得及发送快乐大脚发可视对讲发卡三等奖发卡三等奖发卡机速度快发加上肯德基发卡萨丁就卡束带结发卡世纪东方卡时间的发卡世纪东方卡机上的看法斯柯达积分卡三等奖发";
    self.m_label.text =model.m_answer;//选项内容
    self.m_pos = model.m_pos;//服务器选项下标
    if ([DTools isStringEmpty:model.m_photo]) {//没有头像选项
        
        self.m_userPhotoImage.sd_layout
        .widthIs(0)
        .heightIs(0);
        self.m_userPhotoImage.hidden = YES;
        
        self.m_optionsLabel.sd_layout
        .leftSpaceToView(self.contentView, 35)
        .centerYEqualToView(self.contentView);
        
        
    }else{//有头像选项
        self.m_userPhotoImage.sd_layout
        .widthIs(70)
        .heightIs(70);
        self.m_userPhotoImage.hidden = NO;
        self.m_optionsLabel.sd_layout
        .leftSpaceToView(self.m_userPhotoImage, 10)
        .centerYEqualToView(self.m_userPhotoImage);
        
        [self.m_userPhotoImage sd_setImageWithURL:[NSURL URLWithString:model.m_photo] placeholderImage:ImageNamed(@"详情页和答案角色头像")];
        [DTools getCorner:self.m_userPhotoImage radius:5];
    }
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
