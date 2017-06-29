//
//  RoleIntroduceTableViewCell.h
//  chat
//
//  Created by 高超 on 2017/5/12.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoleIntroduceModel.h"
#import "ActorsAuditionModel.h"
@interface RoleIntroduceTableViewCell : UITableViewCell

/**
 介绍
 */
@property(nonatomic,strong)UILabel * m_introduceStr;

@property(nonatomic,strong)RoleIntroduceModel * m_model;

//model数据
@property(nonatomic,strong)ActorsAuditionModel * m_ActorsModel;

@end
