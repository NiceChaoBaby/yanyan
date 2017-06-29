//
//  ProgressLine.h
//  自定义视频录制
//
//  Created by dong on 15/9/15.
//  Copyright (c) 2015年 高超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightAnimation.h"
@protocol  CustomProgressDelegate<NSObject>
@optional
////修改进度标签内容
//- (void)removeProgress;
//进度条结束时
- (void)endTime;
@end

@interface CustomProgress : UIView

//// 背景图像
//@property (retain, nonatomic) UIView *trackView;
// 填充图像
@property (retain, nonatomic) UIView *progressView;

// 填充图像
@property (strong, nonatomic) LightAnimation *m_ligthAnimation;

@property (retain, nonatomic) NSTimer *progressTimer; //时间定时器
@property (nonatomic) CGFloat targetProgress; //进度
@property (nonatomic) CGFloat currentProgress; //当前进度

@property (nonatomic, strong)id<CustomProgressDelegate> delegate;

- (void)setProgress:(CGFloat)progress;//设置进度
-(void)endTime;
@end
