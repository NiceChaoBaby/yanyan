//
//  AnswerModel.h
//  chat
//
//  Created by 高超 on 2017/5/18.
//  Copyright © 2017年 Dong. All rights reserved.
//
//角色扮演答题Model
#import <Foundation/Foundation.h>
#import "RoleIntroduceInfo.h"
@interface AnswerModel : NSObject


/**
 选择的选项内容    因为A B C D不一定每次都一样  要内容一样
 */
@property(nonatomic,strong)NSString * m_SelectContent;

/**
 选项服务器下标
 */
@property(nonatomic,assign)int m_pos;
/**
 选择选项数组的第几个  跟pos不一样 这个是下标
 */
@property(nonatomic,assign)int m_modelArrayNumber;
/**
 题目内容
 */
@property(nonatomic,strong)NSString * m_question;

/**
 环信roomId
 */
@property(nonatomic,strong)NSString * m_EaseRoomId;


/***********选择角色信息***************/


/**
 角色信息Model
 */
@property(nonatomic,strong)RoleIntroduceInfo * m_rolemodel;
@end
