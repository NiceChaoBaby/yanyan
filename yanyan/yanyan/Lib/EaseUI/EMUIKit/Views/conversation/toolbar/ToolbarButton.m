//
//  ToolbarButton.m
//  chat
//
//  Created by dong on 16/4/19.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "ToolbarButton.h"

@implementation ToolbarButton
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self.m_button=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [self addSubview:self.m_button];
        
        self.m_label=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.m_button.frame)+4,60, 16)];
        self.m_label.textAlignment=NSTextAlignmentCenter;
        self.m_label.textColor=RGBChatTextColor;
        self.m_label.font=[UIFont systemFontOfSize:14];
        [self addSubview:self.m_label];
    }
    return   self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
