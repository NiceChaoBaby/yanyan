//
//  ActorsAuditionCell.h
//  chat
//
//  Created by 高超 on 2017/5/15.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActorsAuditionModel.h"
#import "AnswersModel.h"
@interface ActorsAuditionCell : UITableViewCell


/**
 选项
 */
@property(nonatomic,strong)UILabel * m_label;

/**
 服务器选项下标
 */
@property(nonatomic,assign)int m_pos;
/**
 选项A B C D
 */
@property(nonatomic,strong)UILabel * m_optionsLabel;

/**
 错误通过印章
 */
@property(nonatomic,strong)UIImageView * m_passImage;

/**
 头像
 */
@property(nonatomic,strong)UIImageView * m_userPhotoImage;

//model数据
@property(nonatomic,strong)ActorsAuditionModel * m_ActorsModel;
@end
