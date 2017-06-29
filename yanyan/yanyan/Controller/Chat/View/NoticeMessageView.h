//
//  NoticeMessageView.h
//  chat
//
//  Created by dong on 16/10/17.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeMessageView : UIView
@property (weak, nonatomic) IBOutlet UIView *m_bgView;
@property (weak, nonatomic) IBOutlet UILabel *m_titleLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_labConstraintWidth;

@end
