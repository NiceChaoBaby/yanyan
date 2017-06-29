//
//  ActorListViewController.h
//  yanyan
//
//  Created by 高超 on 2017/6/28.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActorListViewController : DRootViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/**
 滚动视图
 */
@property(nonatomic,strong)UICollectionView * m_collectionView;
@end
