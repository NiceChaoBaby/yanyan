//
//  NewsPlazaModel.h
//  chat
//
//  Created by 高超 on 2017/2/23.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnswersModel.h"
@interface NewsPlazaModel : NSObject

/**
 用户名字
 */
@property(nonatomic,strong)NSString * m_userName;
/**
 用户头像
 */
@property(nonatomic,strong)NSString * m_userPhoto;
/**
 新闻ID
 */
@property(nonatomic,assign)int  m_NewId;
//新闻标题
@property(nonatomic,strong)NSString * m_NewsName;
//新闻来源
@property(nonatomic,strong)NSString * m_NewsFrom;
//新闻图片地址
@property(nonatomic,strong)NSString * m_NewImageUrl;
/**
 环信聊天室ID
 */
@property(nonatomic,strong)NSString * m_easeId;

/**
 点赞用户，同话题聊天室
 */
@property(nonatomic,strong)NSString * m_intrestUid;
//新闻发布时间
@property(nonatomic,assign)long long  m_NewsReleaseTime;

/**
 *  保持剩余时间
 */
@property (nonatomic,strong)NSString * m_remain;
/**
 几小时前  什么时间等等
 */
@property(nonatomic,strong)NSString * m_WhatTime;

/**
 更新消息多少条
 */
@property(nonatomic,assign)NSInteger * m_NewCount;

/**
 类型
 */
@property(nonatomic,assign)NSInteger m_secType;

@property(nonatomic,assign)NSInteger m_ImageCount;
/**
 *  新闻状态
 */
@property(nonatomic,assign)ChatSquareType m_isState;


/**
 正确答案下标
 */
@property(nonatomic,assign)int m_ansRight;


/**
 选项数组
 */
@property(nonatomic,strong)NSMutableArray * m_answersArray;


/**
 问答问题
 */
@property(nonatomic,strong)NSString * m_question;


/**
 问答头视图
 */
@property(nonatomic,strong)NSString * m_imgQuestion;

/**
 角色扮演描述
 */
@property(nonatomic,strong)NSString * m_cdesc;

@end
