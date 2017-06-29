//
//  PhoneAlbumTableViewCell.h
//  storm
//
//  Created by dong on 15/7/30.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//相册cell
#import <UIKit/UIKit.h>

@interface PhoneAlbumTableViewCell : UITableViewCell
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *m_titleLab;

@end
