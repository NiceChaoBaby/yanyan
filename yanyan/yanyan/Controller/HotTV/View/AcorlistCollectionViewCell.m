//
//  AcorlistCollectionViewCell.m
//  yanyan
//
//  Created by 高超 on 2017/6/28.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "AcorlistCollectionViewCell.h"

@implementation AcorlistCollectionViewCell
/**
 影视人名
 */
-(UIImageView *)m_MoviewPeopleImage
{
    if (!_m_MoviewPeopleImage) {
        _m_MoviewPeopleImage = [UIImageView new];
        _m_MoviewPeopleImage.contentMode = UIViewContentModeScaleAspectFill;
        _m_MoviewPeopleImage.clipsToBounds = YES;
        [self.contentView addSubview:_m_MoviewPeopleImage];
        _m_MoviewPeopleImage.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.contentView, 0)
        .heightIs(RW(200));
        
        //        self.backgroundColor = [UIColor redColor];
        
    }
    
    
    return _m_MoviewPeopleImage;
}

/**
 饰演角色名
 */
-(UILabel *)m_movePeopleName
{
    if (!_m_movePeopleName) {
        _m_movePeopleName = [UILabel new];
        _m_movePeopleName.textAlignment = NSTextAlignmentCenter;
        _m_movePeopleName.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_m_movePeopleName];
        _m_movePeopleName.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.m_MoviewPeopleImage, RW(20))
        .heightIs(20);
    }
    
    return _m_movePeopleName;
}


/**
 影视人图片
 */
-(UILabel *)m_roleIntroduceName
{
    if (!_m_roleIntroduceName) {
        _m_roleIntroduceName = [UILabel new];
        _m_roleIntroduceName.textAlignment = NSTextAlignmentCenter;
        _m_roleIntroduceName.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:_m_roleIntroduceName];
        _m_roleIntroduceName.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .topSpaceToView(self.m_movePeopleName, RW(10))
        .heightIs(20);
        
    }
    
    return _m_roleIntroduceName;
    
}

@end
