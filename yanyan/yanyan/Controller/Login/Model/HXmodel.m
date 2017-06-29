//
//  HXmodel.m
//  chat
//
//  Created by 高超 on 16/3/21.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "HXmodel.h"

@implementation HXmodel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_HXname":@"hx_name",
             @"m_HXpasswd":@"hx_passwd"
            
    };
}

@end
