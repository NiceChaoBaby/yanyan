//
//  NSString+Extension.m
//  storm
//
//  Created by dong on 15/8/5.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
/**
 *返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
  
    CGFloat fontSize = font.pointSize;
   UIFont *myFont = [UIFont fontWithName:K_fontPingfang size:fontSize * SizeScale];
    CGSize size = CGSizeZero;
    if(ISIOS8)
    {
        NSDictionary *attribute = @{NSFontAttributeName: myFont};
        
        size = [self boundingRectWithSize:maxSize
                                  options: NSStringDrawingTruncatesLastVisibleLine|
                NSStringDrawingUsesLineFragmentOrigin|
                NSStringDrawingUsesFontLeading
                               attributes:attribute
                                  context:nil].size;
    }
    else
    {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxSize.width, maxSize.height)];
        label.font=myFont;
        label.text=self;
        label.numberOfLines = 0;
        size = [label sizeThatFits:maxSize];
    }
    return size;
//    NSDictionary *attrs = @{NSFontAttributeName : font};
//    return [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}
/**
 *返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
-(CGSize)sizeWithGCFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    
//    CGFloat fontSize = font.pointSize;
//    UIFont *myFont = [UIFont fontWithName:K_fontPingfang size:fontSize * SizeScale];
    CGSize size = CGSizeZero;
    if(!ISIOS8)
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        
        size = [self boundingRectWithSize:maxSize
                                  options: NSStringDrawingTruncatesLastVisibleLine|
                NSStringDrawingUsesLineFragmentOrigin|
                NSStringDrawingUsesFontLeading
                               attributes:attribute
                                  context:nil].size;
    }
    else
    {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxSize.width, maxSize.height)];
        label.font=font;
        label.text=self;
        label.numberOfLines = 0;
        size = [label sizeThatFits:maxSize];
    }
    return size;
    //    NSDictionary *attrs = @{NSFontAttributeName : font};
    //    return [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

-(CGSize)sizeWithFontXSD:(float)fontSize maxSize:(CGSize)maxSize
{
  
    UIFont *fonts = [UIFont fontWithName:K_fontPingfang size:fontSize * SizeScale];

    CGSize size = CGSizeZero;
    if(!ISIOS8)
    {
        NSDictionary *attribute = @{NSFontAttributeName: fonts};
        
        size = [self boundingRectWithSize:maxSize
                                  options: NSStringDrawingTruncatesLastVisibleLine|
                NSStringDrawingUsesLineFragmentOrigin|
                NSStringDrawingUsesFontLeading
                               attributes:attribute
                                  context:nil].size;
    }
    else
    {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxSize.width, maxSize.height)];
        label.font=fonts;
        label.text=self;
        label.numberOfLines = 0;
        size = [label sizeThatFits:maxSize];
    }
    return size;
    //    NSDictionary *attrs = @{NSFontAttributeName : font};
    //    return [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

-(CGSize)sizeWithFontNoScale:(float)fontSize maxSize:(CGSize)maxSize
{
    
    UIFont *fonts = [UIFont fontWithName:K_fontPingfang size:fontSize];
    
    CGSize size = CGSizeZero;
    if(!ISIOS8)
    {
        NSDictionary *attribute = @{NSFontAttributeName: fonts};
        
        size = [self boundingRectWithSize:maxSize
                                  options: NSStringDrawingTruncatesLastVisibleLine|
                NSStringDrawingUsesLineFragmentOrigin|
                NSStringDrawingUsesFontLeading
                               attributes:attribute
                                  context:nil].size;
    }
    else
    {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxSize.width, maxSize.height)];
        label.font=fonts;
        label.text=self;
        label.numberOfLines = 0;
        size = [label sizeThatFits:maxSize];
    }
    return size;
   
}

/**
 *  Unicode转中文
 *
    这个代码是为了解决  服务器存不了表情 是因为现在服务器数据库版本太低 存不了  所以我们只要经过服务器的表情都要做解码  
 *  @param unicodeStr
 *
 *  @return
 */
- (NSString *)replaceUnicode{
    
    NSString *tempStr = [self stringByReplacingOccurrencesOfString:@"\\\\\\" withString:@"\\"];
    NSString *tempStrs = [tempStr stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
    NSString *tempStr1 = [tempStrs stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}



@end
