//
//  CustomMessageTableViewCell.h
//  chat
//
//  Created by dong on 16/4/12.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DEnumClass.h"
@class CustomMessageTableViewCell;

@protocol CustomMessageTableViewCellDelegate <NSObject>

@optional
/**
 *  不同意
 */
//-(void)clickDisagree:(id<IMessageModel>) messageModel;
/**
 *  同意
 */
//-(void)clickAgree:(id<IMessageModel>) messageModel;
@end
@interface CustomMessageTableViewCell : UITableViewCell
//@property(nonatomic,assign)id<IMessageModel> m_messageCellModel;
/**
 *  拒绝
 */
@property (weak, nonatomic) IBOutlet UIButton *m_disagreeBtn;
/**
 *  已经处理
 */
@property (weak, nonatomic) IBOutlet UIButton *m_dealBtn;
/**
 *  同意
 */
@property (weak, nonatomic) IBOutlet UIButton *m_agreeBtn;
@property (assign, nonatomic)  id<CustomMessageTableViewCellDelegate> delegate;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *m_contentLab;
/**
 *  高的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentBgConstraintH;
-(void)refreshData:(ChatType )type;
/**
 *  拒绝按钮
 *
 *  @param sender
 */
- (IBAction)clickDisagreeButton:(UIButton *)sender;
/**
 *  同意按钮
 *
 *  @param sender
 */
- (IBAction)clickAgreeButton:(UIButton *)sender;
@end
