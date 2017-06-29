//
//  AnswersModel.m
//  chat
//
//  Created by 高超 on 2017/5/19.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "AnswersModel.h"

@implementation AnswersModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_answer":@"answer",
             @"m_pos":@"pos",
             @"m_photo":@"img"

             };
}
@end
