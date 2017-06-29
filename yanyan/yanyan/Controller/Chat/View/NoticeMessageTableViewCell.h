//
//  NoticeMessageTableViewCell.h
//  chat
//
//  Created by dong on 16/4/19.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
@interface NoticeMessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *m_titleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_labWidthConstraint;
@property (weak, nonatomic) IBOutlet UIView *m_bgView;

@end
