//
//  HotTVCommentsTableViewCell.h
//  yanyan
//
//  Created by 高超 on 2017/6/22.
//  Copyright © 2017年 XSD. All rights reserved.
//
//影视评论
#import <UIKit/UIKit.h>
#import "HotCommentM.h"
@interface HotTVCommentsTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray * imageArray;
/**
 用户头像
 */
@property(nonatomic,strong)UIImageView * m_userPhoto;


/**
 用户昵称
 */
@property(nonatomic,strong)UILabel * m_userName;


/**
 发表时间
 */
@property(nonatomic,strong)UILabel * m_time;


/**
 评论
 */
@property(nonatomic,strong)UILabel * m_commentLabel;


/*******************底部工具栏  赞  评论    分享************************/

/**
 底部按钮View
 */
@property(nonatomic,strong)UIView * m_downView;

/**
 底部视图 顶部线条
 */
@property(nonatomic,strong)UIImageView * m_topImage;

/**
 分割线A
 */
@property(nonatomic,strong)UIImageView * m_segmentationA;

/**
 分割线B
 */
@property(nonatomic,strong)UIImageView * m_segmentationB;

/**
 点赞按钮
 */
@property(nonatomic,strong)UIButton * m_greatBtn;

/**
 评论按钮
 */
@property(nonatomic,strong)UIButton * m_commentBtn;


/**
 分享
 */
@property(nonatomic,strong)UIButton * m_shareBtn;

/**
 滚动视图
 */
@property(nonatomic,strong)UICollectionView * m_collectionView;


/*************************数据Model**********************************/


/**
  影视评论
 */
@property(nonatomic,strong)HotCommentM * m_hotCommentM;




@end
