//
//  WordFilter.h
//  chat
//
//  Created by 熊申东 on 2016/12/15.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordFilter : NSObject
+ (instancetype)sharedInstance;
- (void)initFilter:(NSString *)filepath;
/**
 检测敏感字  替换它为****
 
 @param str 字符串
 @return 替换后的字符串
 */
- (NSString *)wordSensitivefilter:(NSString *)str;
/**
 检测是否包含敏感字
 
 @param str 字符串
 @return bool
 */
- (BOOL)iswordSensitivefilter:(NSString *)str;
//释放
- (void)freeFilter;
@end
