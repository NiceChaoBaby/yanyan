//
//  UIFont+Family.h
//  chat
//
//  Created by 熊申东 on 2017/3/14.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Family)
/**
 得到缩放的 自定义字体
 
 @param fontSize 字体大小
 @return font
 */
+(UIFont *)systemFamilyFontOfSize:(float )fontSize;
/**
 得到不缩放的 自定义字体
 
 @param fontSize 字体大小
 @return font
 */
+(UIFont *)systemFamilyFontOfSizeNoScale:(float )fontSize;
@end
