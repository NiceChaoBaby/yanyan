//
//  UITableViewCell+deselectColor.m
//  chat
//
//  Created by 高超 on 2016/11/28.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "UITableViewCell+deselectColor.h"

@implementation UITableViewCell (deselectColor)
/**
 设置Cell 选中颜色方法
 */
-(void)deselectColor
{
    UIView* selectedBGView = [[UIView alloc] initWithFrame:self.bounds];
    selectedBGView.backgroundColor =  RGBCellDeselectColor;
    self.selectedBackgroundView = selectedBGView;
}
@end
