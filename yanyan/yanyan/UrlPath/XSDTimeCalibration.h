//
//  XSDTimeCalibration.h
//  chat
//
//  Created by 熊申东 on 2017/1/4.
//  Copyright © 2017年 Dong. All rights reserved.
//时间校准

#import <Foundation/Foundation.h>

@interface XSDTimeCalibration : NSObject
+ (XSDTimeCalibration *)share;
//设置服务器时间
-(void)setOriginTime:(NSString *)time;
// 返回当前的服务器时间
-(NSDate *)getServerDate;
/**
 返回当前时间+过去多少秒
 
 @param secs 秒
 @return 数据
 */
-(NSDate *)getCurrentTimeAddSinceNow:(NSTimeInterval)secs;
@end
