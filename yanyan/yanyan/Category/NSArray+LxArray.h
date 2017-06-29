//
//  NSArray+LxArray.h
//  storm
//
//  Created by dong on 15/7/14.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (LxArray)

/**
 *  返回数组的第一个节点
 *
 *  @return id
 */
//- (id)firstObject;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (id)safeObjectAtIndex:(NSInteger)index;
// int排序
+ (NSArray *)sortNumArray:(NSArray *)array;

// 去掉重复元素
+ (NSArray *)getUnduplicatedElement:(NSArray *)array;

// 元素逆序
+ (NSArray *)reverseArray:(NSArray *)array;


@end
