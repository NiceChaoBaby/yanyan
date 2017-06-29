//
//  NewsModel.m
//  chat
//
//  Created by 高超 on 16/5/6.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel


+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_img" : @"img",
             @"m_imgHeight":@"img_height",
             @"m_imgWith":@"img_width",
             @"m_link":@"link",
             @"m_remainTime":@"remain_time",
             @"m_summary":@"summary",
             @"m_title":@"title",
             @"m_source":@"source",
             @"m_newsType":@"news_type",
             @"m_secType":@"sec_type",
             @"m_content":@"content",
             @"m_dtpub":@"dt",
             @"m_contentUrl":@"content_url",
             @"m_avatar":@"avatar",
             @"m_easeId":@"ease_id",
             @"m_id":@"id",
             @"m_nickName":@"nickname",
             @"m_notes":@"notes",
             @"m_source":@"source",
             @"uidIntrest":@"uid_intrest",
             @"m_remain":@"remain"
             };
}



@end
