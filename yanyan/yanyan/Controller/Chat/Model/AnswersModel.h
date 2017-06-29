//
//  AnswersModel.h
//  chat
//
//  Created by 高超 on 2017/5/19.
//  Copyright © 2017年 Dong. All rights reserved.
//
//单个选项Model
#import <Foundation/Foundation.h>

@interface AnswersModel : NSObject


/**
 选项内容
 */
@property(nonatomic,strong)NSString * m_answer;


/**
 选项头像
 */
@property(nonatomic,strong)NSString * m_photo;
/**
 服务器排序出来的选项的第几个  从0开始  记住这个就不会和服务器选项不一致了
 */
@property(nonatomic,assign)int   m_pos;
@end
