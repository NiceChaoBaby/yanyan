//
//  CustomMessageTableViewCell.m
//  chat
//
//  Created by dong on 16/4/12.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "CustomMessageTableViewCell.h"
#import "ChatTipoffModel.h"
@implementation CustomMessageTableViewCell

- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)refreshData:(ChatType )type
{
    
    self.backgroundColor=RGBBgChatColor;
    [self.m_agreeBtn setHidden:NO];
    [self.m_disagreeBtn setHidden:NO];
    [self.m_dealBtn setHidden:YES];
//    //判断是否处理过
//   if  ([[self.m_messageCellModel.message.ext safeObjectForKey:K_MESSAGE_NOTICE_ATTR_ISDEAL] boolValue])
//    {
//        [self.m_agreeBtn setHidden:YES];
//        [self.m_disagreeBtn setHidden:YES];
//        [self.m_dealBtn setHidden:NO];
//        //判断处理是同意还是拒绝
//        if  ([[self.m_messageCellModel.message.ext safeObjectForKey:K_MESSAGE_NOTICE_ATTR_ISDEAL] intValue]==1)
//        {
//            [self.m_dealBtn setTitle:@"已同意" forState:UIControlStateNormal];
//        }else
//        {
//             [self.m_dealBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
//        }
//    }
////    NSDictionary *dic=[self.m_messageCellModel.message.ext safeObjectForKey:K_data];
////    ChatTipoffModel *chatModel=[ChatTipoffModel mj_objectWithKeyValues:dic];
//    
//  
//        //通知类型，1=举报2=管理员禁言某个用户
////        if  ([[self.m_messageCellModel.message.ext safeObjectForKey:K_MESSAGE_ATTR_ISNOTICE] intValue]==1)
////        {
//
//            self.m_contentLab.text=[self.m_messageCellModel.message.ext safeObjectForKey:K_MESSAGE_NOTICE_ATTR_BODY];
////        }else
////        {
////            self.m_contentLab.text=[NSString stringWithFormat:@"有管理员发起对用户“%@”的禁言，您是否同意？",chatModel.m_memberName];
////        }
//  
    
}
/**
 *  拒绝按钮
 *
 *  @param sender
 */
- (IBAction)clickDisagreeButton:(UIButton *)sender
{
//    if ([self.delegate respondsToSelector:@selector(clickDisagree:)])
//    {
//        [self.delegate clickDisagree:self.m_messageCellModel];
//    }
}
/**
 *  同意按钮
 *
 *  @param sender
 */
- (IBAction)clickAgreeButton:(UIButton *)sender
{
//    if ([self.delegate respondsToSelector:@selector(clickAgree:)])
//    {
//        [self.delegate clickAgree:self.m_messageCellModel];
//    }
}
@end
