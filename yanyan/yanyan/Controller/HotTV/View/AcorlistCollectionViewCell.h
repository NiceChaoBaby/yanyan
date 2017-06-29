//
//  AcorlistCollectionViewCell.h
//  yanyan
//
//  Created by 高超 on 2017/6/28.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcorlistCollectionViewCell : UICollectionViewCell

/**
 影视人名
 */
@property(nonatomic,strong)UILabel * m_movePeopleName;

/**
 饰演角色名
 */
@property(nonatomic,strong)UILabel * m_roleIntroduceName;

/**
 影视人图片
 */
@property(nonatomic,strong)UIImageView * m_MoviewPeopleImage;

@end
