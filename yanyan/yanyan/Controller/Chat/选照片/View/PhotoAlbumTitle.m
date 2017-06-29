//
//  PhotoAlbumTitle.m
//  storm
//
//  Created by dong on 15/7/31.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import "PhotoAlbumTitle.h"

@implementation PhotoAlbumTitle
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        
        
        self.m_titleLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-17, frame.size.height)];
        self.m_titleLab.backgroundColor=[UIColor clearColor];
        self.m_titleLab.textColor=[UIColor whiteColor];
        self.m_titleLab.textAlignment=NSTextAlignmentCenter;
        self.m_titleLab.font=[UIFont systemFamilyFontOfSizeNoScale:18];
        [self addSubview:self.m_titleLab];
        
        self.m_imageBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.m_titleLab.frame)+2, (frame.size.height-8)/2-7, 24, 24)];
        self.m_imageBtn.backgroundColor=[UIColor clearColor];
        [self  addSubview:self.m_imageBtn];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.m_titleLab.frame=CGRectMake(0, 0, frame.size.width-17, frame.size.height);
    self.m_imageBtn.frame=CGRectMake(CGRectGetMaxX(self.m_titleLab.frame)+2, (frame.size.height-8)/2-7,24,24);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
