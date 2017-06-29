//
//  UILabel+Init.m
//  yanyan
//
//  Created by xiong on 2017/6/29.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "UIView+Init.h"

@implementation UIView (Init)


@end
@implementation UILabel (Init)

/**
 label 初始化
 
 @param fontSize 字体大小
 @param textColor 字体颜色
 @return lab
 */
-(id)initWithFont:(float)fontSize textColor:(UIColor *)textColor
{
    self=[super init];
    if (self)
    {
        self.font=[UIFont systemFontOfSize:fontSize];
        self.textColor=textColor;
        
       
    }
    return self;
}
@end
@implementation UITableView (Init)


@end
