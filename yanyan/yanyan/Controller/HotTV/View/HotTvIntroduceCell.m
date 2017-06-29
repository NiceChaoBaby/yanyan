//
//  HotTvIntroduceCell.m
//  yanyan
//
//  Created by 高超 on 2017/6/22.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "HotTvIntroduceCell.h"

@implementation HotTvIntroduceCell



/**
 影视介绍
 */
-(UILabel *)m_introduce
{
    if (!_m_introduce) {
        _m_introduce = [UILabel new];
        _m_introduce.textColor = [UIColor blackColor];
        _m_introduce.font = [UIFont systemFontOfSize:16.0f];
        _m_introduce.numberOfLines = 0;
        
    }
    
    return _m_introduce;
}

///**
// 展开收起
// */
//-(UIButton *)m_MoreBtn
//{
//    if (!_m_MoreBtn) {
//       
//    }
//    
//    return _m_MoreBtn;
//}

// 重写构造方法 -- 只调用一次嘛 （套路来的！务必记住！）
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        _m_MoreBtn = [UIButton new];
        [_m_MoreBtn setTitle:@"全文" forState:UIControlStateNormal];
        [_m_MoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_m_MoreBtn addTarget:self action:@selector(changeNuberLabel:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contentView sd_addSubviews:@[self.m_introduce,self.m_MoreBtn]];
        
        
        
        self.m_introduce.sd_layout
        .leftSpaceToView(self.contentView,RW(20))
        .topSpaceToView(self.contentView,RW(10))
        .rightSpaceToView(self.contentView,RW(20))
        .autoHeightRatio(0);
    
        self.m_MoreBtn.sd_layout
        .leftSpaceToView(self.contentView,RW(0))
        .rightSpaceToView(self.contentView,RW(0))
        .topSpaceToView(self.m_introduce,RW(20))
        .heightIs(RW(60));
        
      
        
      
        //设置最大行数  在上面约束完了在进行设置
//        [_m_introduce setMaxNumberOfLinesToShow:4];
     
        
        
    }
    
   return self;
}
-(void)setM_movieIntroduced:(MovieIntroduced *)model
{
    
    
    self.m_introduce.text = model.m_MovieIntroduced;
   
    if (model.shouldShowMoreButton) { // 如果文字高度超过60
        _m_MoreBtn.sd_layout.heightIs(RW(60));
        _m_MoreBtn.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _m_introduce.sd_layout.maxHeightIs(MAXFLOAT);
            [_m_MoreBtn setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _m_introduce.sd_layout.maxHeightIs(FirstFLOAT);
            [_m_MoreBtn setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        _m_MoreBtn.sd_layout.heightIs(0);
        _m_MoreBtn.hidden = YES;
    }

      [self setupAutoHeightWithBottomView:self.m_MoreBtn bottomMargin:0];
}


/**
 改变限制行数（影视简介显示行数）
 */
-(void)changeNuberLabel:(UIButton *)btn
{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
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
