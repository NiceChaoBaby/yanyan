//
//  MoviewPeopleCollectionViewCell.h
//  yanyan
//
//  Created by 高超 on 2017/6/27.
//  Copyright © 2017年 XSD. All rights reserved.
//
//影人信息CollectionCell
#import <UIKit/UIKit.h>

@interface MoviewPeopleCollectionViewCell : UICollectionViewCell


/**
 影视人名
 */
@property(nonatomic,strong)UILabel * m_movePeopleName;

/**
 影视人图片
 */
@property(nonatomic,strong)UIImageView * m_MoviewPeopleImage;
@end
