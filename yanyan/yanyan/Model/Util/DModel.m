//
//  DModel.m
//  storm
//
//  Created by dong on 15/7/24.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import "DModel.h"

@implementation DModel
/**
 *  旧值换新值，用于过滤字典中的值
 *
 *  @param oldValue 旧值
 *
 *  @return 新值
 */
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    
    if  ((property.type.typeClass == [NSString class]&&[oldValue isKindOfClass:[NSString class]]) ||[oldValue isKindOfClass:[NSNull class]]) {
        
        if (oldValue == nil || [oldValue isKindOfClass:[NSNull class]])
        {
             return @"";
        }
        else
        {
           return [oldValue replaceUnicode];
        }
    }
    
    return oldValue;

}
/**
 *  Unicode转中文
 *
 *  @param unicodeStr
 *
 *  @return
 */
- (NSString *)replaceUnicode:(NSString *)str  {
    NSString *tempStr1 = [str stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
@end
