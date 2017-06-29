//
//  HotCommentM.h
//  yanyan
//
//  Created by 高超 on 2017/6/27.
//  Copyright © 2017年 XSD. All rights reserved.
//
//聊热剧  剧集评论Model
#import <Foundation/Foundation.h>

@interface HotCommentM : NSObject


/**
 用户头像
 */
@property(nonatomic,strong)NSString * m_userPhoto;


/**
 用户名称
 */
@property(nonatomic,strong)NSString * m_userNmae;



/**
 用户评论时间
 */
@property(nonatomic,strong)NSString * m_CommentTime;


/**
 用户评论内容
 */
@property(nonatomic,strong)NSString * m_commentsContent;


/**
 评论照片
 */
@property(nonatomic,strong)NSString * m_commentsImage;


/**
 点赞人数
 */
@property(nonatomic,strong)NSString * m_ThumbUpCount;


/**
 电影名称
 */
@property(nonatomic,strong)NSString * m_moviewName;

/**
 电影人物介绍
 */
@property(nonatomic,strong)NSString * m_moviewData;

/**
 电影封面图
 */
@property(nonatomic,strong)NSString * m_moviewImage;
@end
