//
//  UIFont+Family.m
//  chat
//
//  Created by 熊申东 on 2017/3/14.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "UIFont+Family.h"

@implementation UIFont (Family)

/**
 得到缩放的 自定义字体

 @param fontSize 字体大小
 @return font
 */
+(UIFont *)systemFamilyFontOfSize:(float )fontSize
{
    UIFont *font=[UIFont fontWithName:K_fontPingfang size:fontSize * SizeScale];
    return font;
}
/**
 得到不缩放的 自定义字体
 
 @param fontSize 字体大小
 @return font
 */
+(UIFont *)systemFamilyFontOfSizeNoScale:(float )fontSize
{
    
    UIFont *font=[UIFont fontWithName:K_fontPingfang size:fontSize];
    return font;
}
@end
