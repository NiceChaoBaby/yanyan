//
//  ChatTime.m
//  chat
//
//  Created by dong on 16/5/5.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "ChatTime.h"
#define TIME_SECOND   600
@class ChatTime;
@interface ChatTime ()
@property(nonatomic,assign) int m_timeNmuber;
@property(nonatomic,strong) UIViewController *m_controller;
@end
@implementation ChatTime
+(ChatTime *)shareInstance
{
    
    static id sharedInstance=nil;
    if(!sharedInstance)
    {
        sharedInstance = [[ChatTime alloc] init];
        
        
    }
    return sharedInstance;
}

-(void)chatTimeStart
{
    if ([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
    {
        if (!self.m_timer)
        {
            
            self.m_timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeChatRoom) userInfo:nil repeats:YES];
            self.m_timeNmuber=0;
           
        }

    }
       
}
-(void)changeChatRoom
{
    self.m_timeNmuber++;
    DLog(@"聊天室倒计时----+%i",self.m_timeNmuber);
    if (self.m_timeNmuber>TIME_SECOND)
    {
    
        //退出当前聊天室通知
        [[NSNotificationCenter defaultCenter]  postNotificationName:K_LeaveChatRoom object:nil];
        [ShareAppDelegate.m_chatRoomDict removeObjectForKey:K_CHAT_ROOM_KEY];
        [self.m_timer invalidate];
        self.m_timeNmuber=0;
        self.m_timer=nil;
        [[NSNotificationCenter defaultCenter]postNotificationName:K_LEAVE_CONTROLLER_NOTICE object:nil];
    }
    [self chatTimeSecond:self.m_label];
}
-(void)chatTimeEnd
{
    if (self.m_timer.isValid)
    {
        [self.m_timer invalidate];
        self.m_timer=nil;
        self.m_timeNmuber=0;
        DLog(@"聊天室的时间清除了");
    }
   
}

-(void)topChatRoomEnd
{
    //退出当前聊天室通知
    [[NSNotificationCenter defaultCenter]  postNotificationName:K_LeaveChatRoom object:nil];
    [ShareAppDelegate.m_chatRoomDict removeObjectForKey:K_CHAT_ROOM_KEY];
    [self.m_timer invalidate];
    self.m_timeNmuber=0;
    self.m_timer=nil;
    [[NSNotificationCenter defaultCenter]postNotificationName:K_LEAVE_CONTROLLER_NOTICE object:nil];
    DLog(@"话题聊天室的时间清除了");
}
-(void)enterBackGround
{
    
    
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults setObject:[self currentTime] forKey:@"enterBackGround"];
    

    DLog(@"走这个方法了 。。。。。。。。     %@    ---------",[self currentTime]);
}
//bool  是判断聊天室是否还在  从后台进入前台需要走这个方法
-(BOOL)enterForeground
{
    //取出推到后台时存储的时间
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str= [accountDefaults objectForKey:@"enterBackGround"];
    
    //赋予离开后计算的时间   推到后台的时间加上 现在的时间 得出一共过了多少时间
    self.m_timeNmuber=[self intervalSinceNow:str];
    //对比过去的时间  和   设置的时间  如果大于 则退出聊天室   不大于则赋值 继续跑定时器
    if (self.m_timeNmuber>TIME_SECOND)
    {
        
        //？
        if([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
        {
            
            if (ShareAppDelegate.isExistChatRoom)
            {
                //退出当前聊天室通知
                [[NSNotificationCenter defaultCenter]  postNotificationName:K_chatRoomEndTime object:nil];
                
                //退出当前聊天室通知
                [[NSNotificationCenter defaultCenter]  postNotificationName:K_LeaveChatRoom object:nil];
                
               
                
                
                  [ShareAppDelegate.m_chatRoomDict removeObjectForKey:K_CHAT_ROOM_KEY];
               
                [self.m_timer invalidate];
                self.m_timeNmuber=0;
                
                self.m_timer=nil;
            }else
            {
                //退出当前聊天室通知
                [[NSNotificationCenter defaultCenter]  postNotificationName:K_LeaveChatRoom object:nil];
                
                
                [ShareAppDelegate.m_chatRoomDict removeObjectForKey:K_CHAT_ROOM_KEY];
                [self.m_timer invalidate];
                self.m_timeNmuber=0;
                self.m_timer=nil;
                [[NSNotificationCenter defaultCenter]postNotificationName:K_LEAVE_CONTROLLER_NOTICE object:nil];
            }
         
        }
        
        return YES;
    }
    else
        
    {
        //存在就不做处理 因为时间还没到  且在当前聊天室
        if (!ShareAppDelegate.isExistChatRoom)
        {
            if([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
            {
                
                //保存上一次的时间值
                int time=self.m_timeNmuber;
                [self chatTimeStart];
                self.m_timeNmuber=time;
                
            }
        }
        
        return  NO;
    }
    
}
////bool  是判断聊天室是否还在  从后台进入前台需要走这个方法
//-(BOOL)enterForeground2
//{
//    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *str= [accountDefaults objectForKey:@"enterBackGround"];
//    
//    //赋予离开后计算的时间
//    self.m_timeNmuber=[self intervalSinceNow:str]+self.m_timeNmuber;
//    
//    if (self.m_timeNmuber>TIME_SECOND)
//    {
//        return NO;
//    }else{
//        
//        return YES;
//    }
//    
//    
//}


-(NSString *)currentTime
{
   
 
    NSDate *currentDate=[[XSDTimeCalibration share]getServerDate];
    //////////
    NSDateFormatter *currentFormatter=[[NSDateFormatter alloc] init];
    [currentFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime=[currentFormatter stringFromDate:currentDate];
    NSLog(@"自定义时间：======= %@",currentTime);
//    NSString * str = [NSString stringWithFormat:@"自定义时间：======= %@",currentTime];
//    NSDate* currentDate1 = [NSDate date];
//    NSDateFormatter *currentFormatter1=[[NSDateFormatter alloc] init];
//    [currentFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *currentTime1=[currentFormatter stringFromDate:currentDate1];
//     NSLog(@"自定义时间1111111：======= %@",currentTime1);
//     NSString * str1 = [NSString stringWithFormat:@"自定义时间：======= %@",currentTime1];
//    
//    
//    UtilAlert(str, str1);
    
    return currentTime;
}


//一个时间距现在的时间

- (int)intervalSinceNow: (NSString *) theDate
{
  
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSDate* currentDate = [NSDate date];
  
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval cha=[d timeIntervalSinceDate:currentDate];
//      NSLog(@"自定义时间对比：======= %d",(int )fabs(cha));
//      NSString * str = [NSString stringWithFormat:@"自定义时间：======= %d",(int )fabs(cha)];
//    NSDateFormatter *date1=[[NSDateFormatter alloc] init];
//    [date1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *d1=[date dateFromString:theDate];
//    NSDate* currentDate1 = [NSDate date];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
//    NSTimeInterval cha1=[d1 timeIntervalSinceDate:[[XSDTimeCalibration share]getServerDate]];
//    NSLog(@"自定义时间对比111111：======= %d",(int )fabs(cha1));
//   NSString * str1 = [NSString stringWithFormat:@"自定义时间：======= %d",(int)fabs(cha1)];
//    
//    
//    UtilAlert(str, str1);
//    
    
    return (int )fabs(cha);
}
-(void)chatTimeSecond:(UILabel *)label
{
    
    if (label)
    {
        int time=30-self.m_timeNmuber/60;
        if (time==0) {
            time=1;
        }
        NSString *timeStr=[NSString stringWithFormat:@"%i",time];
       
        if (self.m_timeNmuber<TIME_SECOND)
        {
         label.text=[NSString stringWithFormat:@"%@分钟后退出聊天室",timeStr];
        }
            
    }
   
}
@end
