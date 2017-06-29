//
//  optionsView.h
//  chat
//
//  Created by 高超 on 2017/1/3.
//  Copyright © 2017年 Dong. All rights reserved.
//
//点击用户头像出现的选项框
#import <UIKit/UIKit.h>

@interface optionsView : UIView

@property(nonatomic,strong)UIView * m_dataView;

@property(nonatomic,copy)void(^closeBlock)();

- (void)removePopUpView;
@end
