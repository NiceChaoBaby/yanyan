//
//  HotTVRoleTableViewCell.h
//  yanyan
//
//  Created by 高超 on 2017/6/22.
//  Copyright © 2017年 XSD. All rights reserved.
//
// 影人信息
#import <UIKit/UIKit.h>

@interface HotTVRoleTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/**
 滚动视图
 */
@property(nonatomic,strong)UICollectionView * m_collectionView;


@end
