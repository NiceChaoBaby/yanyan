//
//  ActorsAuditionModel.m
//  chat
//
//  Created by 高超 on 2017/5/16.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "ActorsAuditionModel.h"

@implementation ActorsAuditionModel
//-(NSMutableArray *)m_arrayState
//{
//    if (!_m_arrayState) {
//        _m_arrayState = [[NSMutableArray alloc]initWithCapacity:0];
//    }
//    return _m_arrayState;
//}


-(NSMutableArray *)m_answersArray
{
    if (!_m_answersArray) {
        _m_answersArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    return _m_answersArray;
    
}

//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{@"m_title":@"",
//             @"m_arrayState":@""
//             
//             };
//}
@end
