//
//  UIButton+touch.h
//  LiqForDoctors
//
//  Created by StriEver on 16/3/10.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#define defaultInterval .5  //默认时间间隔
@interface UIButton (touch)
/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;
/**
 *  用于设置单个按钮不需要被hook
 */
@property (nonatomic, assign) BOOL isIgnore;



/**
 给按钮设置背景 设置颜色图片

 @param color 颜色图片
 @param state 什么状态
 @param radius 切圆角
 */
-(void)setBtnBackgroundIamgeColor:(UIColor*)color state:(UIControlState)state  radius:(CGFloat)radius;

@end
