//
//  UILabel+Size.h
//  chat
//
//  Created by dong on 16/3/24.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Size)
/**
 *返回值是该字符串所占的大小(width, height)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
-(CGSize)sizeWithMaxSize:(CGSize)maxSize;
@end
