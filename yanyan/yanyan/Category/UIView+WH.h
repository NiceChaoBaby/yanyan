//
//  UIView+WH.h
//  chatdong
//
//  Created by 熊申东 on 2017/1/22.
//  Copyright © 2017年 xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WH)
/**
 * 设置LinearLayout的控件参数
 *
 
 * @param width
 *            宽
 * @param height
 *            高
 
 */
- (void) setViewWH:(CGFloat)  width  height:(CGFloat)height;
/**
 * 通过控件的原始宽度计算在当前屏幕下的实际宽度，以屏幕宽度为基准计算，单位：像素
 *
 * @param designWidth
 *            设计的宽度
 * @return 原始宽度*当前屏幕的宽度/设计参考的屏幕宽度
 */
-(CGFloat) getRealWidth:(CGFloat) designWidth;
@end
