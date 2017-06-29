//
//  UILabel+Init.h
//  yanyan
//
//  Created by xiong on 2017/6/29.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (Init)

@end
@interface UILabel (Init)
/**
 label 初始化
 
 @param fontSize 字体大小
 @param textColor 字体颜色
 @return lab
 */
-(id)initWithFont:(float)fontSize textColor:(UIColor *)textColor;
@end
@interface UIButton (Init)
@end
@interface UIImageView (Init)
@end
@interface UITextView (Init)
@end

@interface UITableView (Init)
@end
