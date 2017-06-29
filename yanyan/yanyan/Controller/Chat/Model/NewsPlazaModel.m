//
//  NewsPlazaModel.m
//  chat
//
//  Created by 高超 on 2017/2/23.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "NewsPlazaModel.h"

@implementation NewsPlazaModel

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
    return @{@"m_userName":@"nickname",
             @"m_userPhoto" : @"avatar",
             @"m_NewId":@"id",
             @"m_NewsName":@"title",
             @"m_NewsFrom":@"notes",
             @"m_easeId":@"ease_id",
             @"m_intrestUid":@"uid_intrest",
             @"m_NewsReleaseTime":@"dt",
             @"m_remain":@"remain",
             @"m_NewImageUrl":@"img",
             @"m_secType":@"sec_type",
             @"m_ImageCount":@"count",
             @"m_NewCount":@"new_count",
             @"m_ansRight":@"ans_right",
             @"m_question":@"question",
             @"m_answersArray":@"answers",
             @"m_imgQuestion":@"img_question",
             @"m_cdesc":@"cdesc"
             
             
             };
}

@end
