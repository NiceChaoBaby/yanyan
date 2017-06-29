//
//  NSArray+LxArray.m
//  storm
//
//  Created by dong on 15/7/14.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//

#import "NSArray+LxArray.h"
@implementation NSArray (LxArray)


//- (id)firstObject
//{
//    return self.count > 0 ? self[ 0 ] : nil;
//}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([indexPath isKindOfClass:[NSIndexPath class]]) {
//        return [[self objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    }
    
    return nil;
}
- (id)safeObjectAtIndex:(NSInteger)index
{
	if ( index < 0 )
		return nil;
	
	if ( index >= self.count )
		return nil;
    
	return [self objectAtIndex:index];
}

// NSInteger排序
+ (NSArray *)sortNumArray:(NSArray *)array
{
    NSArray * result = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int a = [obj1 intValue];
        int b = [obj2 intValue];
        if(a > b)
            return NSOrderedDescending;
        else
            return NSOrderedAscending;
    }];
    return result;
}

// 去掉重复元素
+ (NSArray *)getUnduplicatedElement:(NSArray *)array
{
    NSSet *set = [NSSet setWithArray:array];
    NSArray *result = [set allObjects];
    return result;
}

// 元素逆序
+ (NSArray *)reverseArray:(NSArray *)array
{
    NSMutableArray *result = [NSMutableArray array];
    for(NSInteger i = [array count] - 1; i >= 0; i --){
        [result addObject:[array objectAtIndex:i]];
    }
    return result;
}


@end
