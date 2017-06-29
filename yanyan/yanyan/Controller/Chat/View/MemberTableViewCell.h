//
//  MemberTableViewCell.h
//  chat
//
//  Created by 高超 on 16/3/17.
//  Copyright © 2016年 Dong. All rights reserved.
//
//群成员Cell
#import <UIKit/UIKit.h>

@interface MemberTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *m_userPhoto;//用户头像
@property (weak, nonatomic) IBOutlet UILabel *m_userName;//用户名称
/**
 *  成员标识
 */
@property (weak, nonatomic) IBOutlet UIImageView *m_imageGender;

@property (weak, nonatomic) IBOutlet UILabel *m_menberFlagLab;
/**
 *  显示被屏蔽和禁言的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *m_flagImageView;
@end
