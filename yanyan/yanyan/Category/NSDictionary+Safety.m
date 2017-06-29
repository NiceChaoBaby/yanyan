//
//  NSDictionary+Safety.m
//  storm
//
//  Created by dong on 15/8/13.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import "NSDictionary+Safety.h"

@implementation NSDictionary (Safety)
- (id)safeObjectForKey:(NSString *)key
{
    if  (([self objectForKey:key]==nil)||[ [self objectForKey:key] isKindOfClass:[NSNull class]])
    {
        
                  return @"";
        
    }
    
    return  [self objectForKey:key];
}

/**
 *  判断字典设置的对象是否为空
 *
 *  @param m_id
 *  @param key
 */
-(void)safeSetObject:(id)m_id forKey:(NSString *) key
{

    if ([m_id isKindOfClass:[NSNumber class]])
    {
        
        [self setValue:m_id forKey:key];
    }
    else if([m_id isKindOfClass:[NSString class]])
    
    {
        if ([m_id isNull])
        {
            [self setValue:m_id forKey:key];
        }else
        {
            [self setValue:@"" forKey:key];
        }
    }else
    {
         [self setValue:@"" forKey:key];
    }
}
@end
