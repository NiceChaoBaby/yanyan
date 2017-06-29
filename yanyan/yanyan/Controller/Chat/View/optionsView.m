//
//  optionsView.m
//  chat
//
//  Created by 高超 on 2017/1/3.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "optionsView.h"

@implementation optionsView
{
    UIView * m_bgView;
    
    CGRect m_viewFream;
    
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor clearColor];
        UIView * view = [[UIView alloc]initWithFrame:frame];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        [self addSubview:view];
    }
    return self;
}


-(void)setM_dataView:(UIView *)m_dataView
{
    if (!_m_dataView) {
        _m_dataView = m_dataView;
    }

    //添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removePopUpView)];
    [self addGestureRecognizer:tap];
    m_viewFream = CGRectMake(10, LCDH - (50 + CGRectGetHeight(m_dataView.frame)), LCDW - 20, CGRectGetHeight(m_dataView.frame)+50);
    //下面弹上来的View   CGRectMake(10,LCDH, LCDW - 20, CGRectGetHeight(m_bgView.frame))
    
    m_bgView = [[UIView alloc]initWithFrame:CGRectMake(10,LCDH, LCDW - 20,CGRectGetHeight(m_dataView.frame)+50)];
    m_bgView.backgroundColor = [UIColor clearColor];
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(m_bgView.frame)-40, CGRectGetWidth(m_bgView.frame), 50)];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:self.tintColor  forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFamilyFontOfSize:20]];
    [btn addTarget:self action:@selector(removePopUpView) forControlEvents:UIControlEventTouchUpInside];
   
    [DTools getAvaterCorner:btn];
    [m_bgView addSubview:btn];
    [DTools getAvaterCorner:m_dataView];
    [m_bgView  addSubview:m_dataView];
    [self addSubview:m_bgView];
    [self showPopUp];
}
///**
// *  显示
// */
//- (void)show
//{
//   
//    
//    
//}

///**
// *  隐藏
// */
//- (void)hide
//{
//    
//    
//    
//}
/**
 显示view
 @param block 回调选择值
 */
- (void)showPopUp{
    
   [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [m_bgView setFrame:m_viewFream];
        
    } completion:^(BOOL finished) {
        
    }];
   
}

- (void)removePopUpView{
  
  [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
     
    [m_bgView setFrame:CGRectMake(10,LCDH, LCDW - 20, CGRectGetHeight(m_bgView.frame))];
      
  } completion:^(BOOL finished) {
     
      self.closeBlock();
      [self removeFromSuperview];
  }];
    
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
