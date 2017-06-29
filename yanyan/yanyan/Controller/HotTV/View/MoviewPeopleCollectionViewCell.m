//
//  MoviewPeopleCollectionViewCell.m
//  yanyan
//
//  Created by 高超 on 2017/6/27.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "MoviewPeopleCollectionViewCell.h"

@implementation MoviewPeopleCollectionViewCell


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

@end
