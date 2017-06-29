//
//  CustomShareTableViewCell.h
//  chat
//
//  Created by dong on 16/4/27.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomShareTableViewCell : UITableViewCell
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *m_avatarImageView;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *m_titleLab;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *m_contentLab;
@end
