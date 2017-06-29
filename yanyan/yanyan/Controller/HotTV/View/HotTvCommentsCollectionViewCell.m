//
//  HotTvCommentsCollectionViewCell.m
//  yanyan
//
//  Created by 高超 on 2017/6/27.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import "HotTvCommentsCollectionViewCell.h"

@implementation HotTvCommentsCollectionViewCell


-(UIImageView *)m_imageView
{
    if (!_m_imageView) {
        _m_imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _m_imageView.backgroundColor = [UIColor clearColor];
        _m_imageView.contentMode = UIViewContentModeScaleAspectFill;
        _m_imageView.clipsToBounds = YES;
        [self addSubview:_m_imageView];
    }
    return _m_imageView;
    
}
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self)
//    {
//        _m_imageView = [[UIImageView alloc]initWithFrame:];
//        _m_imageView.backgroundColor = [UIColor clearColor];
//        [_m_imageView setImage:ImageNamed(@"1111aaaa")];
//        
//        [self.contentView addSubview:_m_imageView];
//    }
//    
//    return self;
//}

@end
