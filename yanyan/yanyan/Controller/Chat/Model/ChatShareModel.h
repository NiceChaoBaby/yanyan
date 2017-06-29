//
//  ChatShareModel.h
//  yanyan
//
//  Created by xiong on 2017/6/23.
//  Copyright © 2017年 XSD. All rights reserved.
//聊天分享model

#import "DModel.h"

@interface ChatShareModel : DModel
/**
 *  图片
 */
@property(nonatomic,strong)NSString * m_img;
/**
 *  标题
 */
@property(nonatomic,strong)NSString * m_title;
/**
 *  url
 */
@property(nonatomic,strong)NSString * m_shareUrl;
/**
 *  副标题
 */
@property(nonatomic,strong)NSString * m_summary;
/**
 分享Url
 */
@property(nonatomic,strong)NSString * m_contentUrl;

/**
 *  新闻图片高
 */
@property(nonatomic,strong)NSString * m_imgHeight;

/**
 *  新闻图片宽
 */
@property(nonatomic,strong)NSString * m_imgWith;

@end
