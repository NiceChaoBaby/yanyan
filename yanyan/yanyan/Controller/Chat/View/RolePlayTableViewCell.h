//
//  RolePlayTableViewCell.h
//  chat
//
//  Created by 高超 on 2017/5/11.
//  Copyright © 2017年 Dong. All rights reserved.
//
//角色名单Cell
#import <UIKit/UIKit.h>
#import "RoleIntroduceInfo.h"
#import "RoleChoiceViewController.h"
#import "AnswerModel.h"
@protocol RolePlayTableViewCellDelegate <NSObject>

-(void)RolePlayTableViewCellDelegateState:(RoleIntroduceInfo *)m_rolemodel;


@end
@interface RolePlayTableViewCell : UITableViewCell
@property(nonatomic,assign)id<RolePlayTableViewCellDelegate>delegate;//音乐View的代理
/**
 用户头像
 */
@property(nonatomic,strong)UIImageView * m_userPhoto;

/**
 角色名
 */
@property(nonatomic,strong)UILabel * m_UserNamelabel;


/**
 角色说明
 */
@property(nonatomic,strong)UILabel * m_details;


/**
 选择角色按钮
 */
@property(nonatomic,strong)UIButton * m_stateBtn;

/**
 角色名单Model
 */
@property(nonatomic,assign)RoleIntroduceInfo * m_rolemodel;
@end
