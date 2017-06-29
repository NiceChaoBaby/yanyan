//
//  RoleIntroduceModel.h
//  chat
//
//  Created by 高超 on 2017/5/12.
//  Copyright © 2017年 Dong. All rights reserved.
//
//角色扮演  介绍Model
#import <Foundation/Foundation.h>
#import "AnswersModel.h"
@interface RoleIntroduceModel : NSObject

/**
 介绍
 */
@property(nonatomic,strong)NSString * m_inrroduce;
//状态 暂时用不上
@property(nonatomic,assign)int  m_cstatus;
//创建时间 也用不上
@property(nonatomic,assign)int  m_dt;
//结束时间 格式是   2017-06-16 09:30:00 这样的 为了精确 还是用remain  这个暂时不用
@property(nonatomic,strong)NSString * m_dtEnd;
//聊天室ID
@property(nonatomic,strong)NSString * m_easeId;
//请求房间详情时候用的id
@property(nonatomic,assign)int  m_id;
//TB头视图图片
@property(nonatomic,strong)NSString * m_img;
//结束时间
@property(nonatomic,strong)NSString *  m_remain;
//类型
@property(nonatomic,assign)int  m_secType;
//上一页这一角色扮演聊天室的名字
@property(nonatomic,strong)NSString * m_title;


/************问答题界面数据************/
/**
 问题
 */
@property(nonatomic,strong)NSString * m_question;


/**
 选项数组
 */
@property(nonatomic,strong)NSMutableArray * m_answersArray;

/**
 问答头视图
 */
@property(nonatomic,strong)NSString * m_imgQuestion;

/**
 正确答案下标
 */
@property(nonatomic,assign)int m_ansRight;
@end
