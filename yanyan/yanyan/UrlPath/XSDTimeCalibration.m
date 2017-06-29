//
//  XSDTimeCalibration.m
//  chat
//
//  Created by 熊申东 on 2017/1/4.
//  Copyright © 2017年 Dong. All rights reserved.
//
/*iOS 由于iOS客户端开发无法正确校准标准时间，而标准时间可以通过服务器得到，那么怎么样时时的得到服务器所给我的正确时间呢？
由于项目有通过时间去发公告的功能，
[[NSProcessInfoprocessInfo]systemUptime];
上面代码返回一个时间戳可以得到系统开机时间到现在为止的秒数，我会在程序刚启动时就得到这个时间戳同时也会得到服务器下发给我的服务器时间
-(void)setOriginTime:(NSTimeInterval)servertime {
    _originServerTime = servertime;
    _originStartTime = [[NSProcessInfoprocessInfo]systemUptime];
    //    NSLog(@"_________originTime   %f, %f",_originServerTime, _originStartTime);
}清楚的一点是每次调用这个方法 [[NSProcessInfo processInfo] systemUptime];会重新得到一个时间差，每次掉用此方法并且减去刚登录成功时得到的时间差也就是服务器下发给你的时间到目前为止执行了多长时间，此时服务器加上这个时间差就是当前的时间，我最初的误解是使用一个打点计时器去不断的更新和维护，看来是不需要的，苹果给我们的类库很丰富
// 返回当前的服务器时间
-(NSDate *)serverDate{
    if (_originStartTime ==0) return [NSDatedate];
    NSTimeInterval outtime = [[NSProcessInfoprocessInfo]systemUptime] -_originStartTime;
    NSDate *serverDate = [NSDatedateWithTimeIntervalSince1970:(_originServerTime + outtime)];
    //    NSLog(@"srever_ %@",serverDate);
    return serverDate;
}*/

#import "XSDTimeCalibration.h"
#import "NSDate+InternetDateTime.h"
@interface XSDTimeCalibration()
@property(nonatomic,assign)NSTimeInterval m_originServerTime;
@property(nonatomic,assign)NSTimeInterval m_originStartTime;

@end
@implementation XSDTimeCalibration
+ (XSDTimeCalibration *)share
{
    static XSDTimeCalibration     *shareClient = nil;
    if(!shareClient)
    {
        shareClient = [[XSDTimeCalibration alloc] init];
    }
    return shareClient;
}
//设置服务器时间
-(void)setOriginTime:(NSString *)time
{
   
   NSDate *date= [NSDate dateFromRFC822String:time];
    
    NSTimeInterval servertime=[date timeIntervalSince1970]; // *1000 是精确到毫秒，不乘就是精确到秒
   
    self.m_originServerTime = servertime;
    self.m_originStartTime = [[NSProcessInfo processInfo]systemUptime];

}
// 返回当前的服务器时间
-(NSDate *)getServerDate{
    if (self.m_originStartTime ==0) return [NSDate date];
    NSTimeInterval outtime = [[NSProcessInfo processInfo]systemUptime] -self.m_originStartTime;
    NSDate *serverDate = [NSDate dateWithTimeIntervalSince1970:(self.m_originServerTime + outtime)];
        NSLog(@"srever_ %@",serverDate);
    return serverDate;
}


/**
 返回当前时间+过去多少秒

 @param secs 秒
 @return 数据
 */
-(NSDate *)getCurrentTimeAddSinceNow:(NSTimeInterval)secs
{
    NSDate *currentTime=[self getServerDate];
    
   currentTime= [currentTime dateByAddingTimeInterval:secs];
    
    return currentTime;
}
@end
