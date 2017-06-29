//
//  NSString+Extension.h
//  storm
//
//  Created by dong on 15/8/5.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
-(CGSize)sizeWithFontXSD:(float)fontSize maxSize:(CGSize)maxSize;
-(CGSize)sizeWithFontNoScale:(float)fontSize maxSize:(CGSize)maxSize;
//Unicode转中文
- (NSString *)replaceUnicode;
/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;
-(CGSize)sizeWithGCFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end

