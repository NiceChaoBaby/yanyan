//
//  VideoModel.h
//  chat
//
//  Created by 高超 on 16/6/24.
//  Copyright © 2016年 Dong. All rights reserved.
//
// 视频Model
#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
/**
 *  视频URL
 */
@property(nonatomic,strong)NSURL  * m_url;
/**
 *  视频缩略图
 */
@property(nonatomic,strong)UIImage   * m_image;
/**
 *  视频时间
 */
@property(nonatomic,strong)NSString  * m_time;
/**
 *  视频高度
 */
@property(nonatomic,strong)NSString  * m_width;
/**
 *  视频宽度
 */
@property(nonatomic,strong)NSString  * m_high;



@end
