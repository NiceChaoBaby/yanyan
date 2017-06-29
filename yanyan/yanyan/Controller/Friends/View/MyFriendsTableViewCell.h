//
//  MyFriendsTableViewCell.h
//  chat
//
//  Created by 高超 on 16/3/11.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendListModel.h"
@interface MyFriendsTableViewCell : UITableViewCell
/**
 *  数据
 */
@property (strong, nonatomic)  FriendListModel *m_friendListModel;
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *m_avatarImageView;
/**
 *  好友名字
 */
@property (weak, nonatomic) IBOutlet UILabel *m_friendName;
/**
 *  签名
 */
@property (weak, nonatomic) IBOutlet UILabel *m_signature;
/**
 *  年龄
 */
@property (weak, nonatomic) IBOutlet UILabel *m_ageLab;
/**
 *  性别背景视图（男女颜色不一样）
 */
@property (weak, nonatomic) IBOutlet UIView *m_genderBgView;
/**
 *  距离
 */
@property (weak, nonatomic) IBOutlet UILabel *m_distanceLab;
/**
 *  性别图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *m_genderImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_friendNameConstraint;
@property (weak, nonatomic) IBOutlet UIButton *m_clickButton;

/**
 是否被禁言image   角色扮演成员列表用
 */
@property (weak, nonatomic) IBOutlet UIImageView *m_flagImageView;
- (IBAction)clickButton:(id)sender;

/**
 *  更新数据
 *
 *  @param friendListModel 好友model
 */
-(void)refreshData:(FriendListModel *)friendListModel;
@end
