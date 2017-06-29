//
//  RoleIntroduceModel.m
//  chat
//
//  Created by 高超 on 2017/5/12.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "RoleIntroduceModel.h"

@implementation RoleIntroduceModel
-(NSMutableArray *)m_answersArray
{
    if (!_m_answersArray) {
        _m_answersArray = [[NSMutableArray  alloc]initWithCapacity:0];
    }
    
    return _m_answersArray;
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             
             @"m_answersArray": @"AnswersModel"
             
             };
    
    
}
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_inrroduce":@"cdesc",
             @"m_cstatus":@"cstatus",
             @"m_dt":@"dt",
             @"m_dtEnd":@"dt_end",
             @"m_easeId":@"ease_id",
             @"m_id":@"id",
             @"m_img":@"img",
             @"m_remain":@"remain",
             @"m_secType":@"sec_type",
             @"m_title":@"title",
             @"m_question":@"question",
             @"m_answersArray":@"answers",
             @"m_imgQuestion":@"img_question",
             @"m_ansRight":@"ans_right"
             
             
             };
}
@end
