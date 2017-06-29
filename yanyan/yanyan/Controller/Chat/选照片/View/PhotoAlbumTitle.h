//
//  PhotoAlbumTitle.h
//  storm
//
//  Created by dong on 15/7/31.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlbumTitle : UIButton
/**
 *  图片
 */
@property(nonatomic,strong) UIButton *m_imageBtn;
/**
 *  标题
 */
@property(nonatomic,strong) UILabel     *m_titleLab;
@end
