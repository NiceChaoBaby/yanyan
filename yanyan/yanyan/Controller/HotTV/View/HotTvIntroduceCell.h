//
//  HotTvIntroduceCell.h
//  yanyan
//
//  Created by 高超 on 2017/6/22.
//  Copyright © 2017年 XSD. All rights reserved.
//
// 影片介绍
#import <UIKit/UIKit.h>
#import "MovieIntroduced.h"
@interface HotTvIntroduceCell : UITableViewCell


/**
 影片介绍
 */
@property(nonatomic,strong)UILabel * m_introduce;


/**
 电影介绍Model
 */
@property(nonatomic,strong)MovieIntroduced * m_movieIntroduced;
//

/**
 展开、收起
 */
@property(nonatomic,strong)UIButton * m_MoreBtn;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
