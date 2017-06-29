//
//  MessageTableViewCell.h
//  yanyan
//
//  Created by xiong on 2017/6/28.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCells : UITableViewCell
/**
 *  人名称
 */
@property (strong, nonatomic)  UILabel *m_labMessageName;
/**
 *  最后一条内容
 */
@property (strong, nonatomic)  UILabel *m_labLastMessage;
/**
 *  时间
 */
@property (strong, nonatomic)  UILabel *m_labTime;
/**
 *  //有多少条信息
 */
@property (strong, nonatomic)  UILabel *m_labNumberMessage;
/**
 *  /人头像
 */
@property (strong, nonatomic)  UIImageView *m_imgMessagePhoto;

@end
