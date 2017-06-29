//
//  CustomLabel.h
//  chat
//
//  Created by dong on 2016/11/4.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLabel : UILabel

/**
 如果这里设置了内边距  就要把label的整体宽高 加上这个边距的距离
 */
@property (nonatomic, assign) UIEdgeInsets textInsets; // 控制字体与控件边界的间隙
@end
