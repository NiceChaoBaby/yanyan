//
//  PRompt.m
//  chat
//
//  Created by 高超 on 16/5/10.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "PRompt.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@implementation PRompt

/**
  声音 震动提示 1 声音提示 2 震动提示 3 全部提示

 @param ter 1
 */
+(void)promptVibrationPrompt:(NSInteger)ter
{
//     [PRompt PromptStorage:NO];
    if (ter == 1) {
    if (![PRompt PromptRead]) {
        AudioServicesPlaySystemSound(1007);
        [PRompt timeCountdown];
        }
   
    }else if (ter == 2){
        BOOL a = [PRompt PromptRead];
        if (!a) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [PRompt timeCountdown];
        }
    }else if (ter == 3){
        
        BOOL a = [PRompt PromptRead];
        if (!a) {
             AudioServicesPlaySystemSound(1007);
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [PRompt timeCountdown];
        }
    }
    
}

/**
 判断免扰进行本地消息推送判断

 @param type 1
 @param ideID 1
 */
+(BOOL)JudgePromptMessage:(MessageType)type identifyID:(NSString *)ideID
{
    BOOL m_message;
    SetMessage * model = [PRompt promptReadStorage];
    //首先判断勿扰
    BOOL noHarassSW = [model.m_noHarass isEqualToString:@"0"]?NO:YES;
    
    if (noHarassSW) {//打开勿扰进行下面判断
        
        BOOL time = [PRompt isBetweenFromHour:22 toHour:8];
        
        if (time) {//如果在勿扰时间内则直接跳出
            return YES;
        }
    }
    //其次判断声音和震动
    BOOL voice = [model.m_voicePrompt isEqualToString:@"0"]?NO:YES;//声音
    BOOL vibration = [model.m_vibrationPrompt isEqualToString:@"0"]?NO:YES;//震动
    if (voice || vibration) {//声音震动开一个即可
        if (type == MessageGroup){//群组消息
            BOOL groupMessage = [model.m_groupMessage isEqualToString:@"0"]?NO:YES;
            if (groupMessage) {//群组提示开着的
                //如果不在群组免扰的数组里 则提示
                if (ideID.length != 0) {
                   m_message =  NO;
                }else{
                    m_message =  YES;
                }
            }else{
               m_message = YES;
            }
        }else if (type == MessageUser){//个人消息
            BOOL  userMessage = [model.m_userMessage isEqualToString:@"0"]?NO:YES;
            if (userMessage) {//个人提示
               
                    m_message = NO;
        
//                //启用谁该想方法
//                [PRompt promptVoice:voice Vibration:vibration];
            }else{
                m_message = YES;
            }
        }else{//通知消息
           
                m_message =  NO;
           //            //启用谁该想方法
//            [PRompt promptVoice:voice Vibration:vibration];
        }
    }else{
        
        m_message = YES;
    }
    
    
    return m_message;
}

/**
 * 判断是否声音提示
 */
+(void)JudgePrompt:(MessageType)type identifyID:(NSString *)ideID
{

   SetMessage * model = [PRompt promptReadStorage];
   //首先判断勿扰
    BOOL noHarassSW = [model.m_noHarass isEqualToString:@"0"]?NO:YES;
    
    if (noHarassSW) {//打开勿扰进行下面判断
       
     BOOL time = [PRompt isBetweenFromHour:22 toHour:8];
        
        if (time) {//如果在勿扰时间内则直接跳出
            return;
        }
    }
    
  //其次判断声音和震动
    BOOL voice = [model.m_voicePrompt isEqualToString:@"0"]?NO:YES;//声音
    BOOL vibration = [model.m_vibrationPrompt isEqualToString:@"0"]?NO:YES;//震动
    
if (voice || vibration) {//声音震动开一个即可
        
    if (type == MessageGroup){//群组消息
  
    //如果不在群组免扰的数组里 则提示
    if (ideID.length != 0) {
        //启用谁该想方法
        [PRompt promptVoice:voice Vibration:vibration];
    }
    
     }else if (type == MessageUser){//个人消息
        
        BOOL  userMessage = [model.m_userMessage isEqualToString:@"0"]?NO:YES;
            
           if (userMessage) {//个人提示
                
               //启用谁该想方法
               [PRompt promptVoice:voice Vibration:vibration];

            }
        }else if (type == MessageNotice){//通知消息
            
            //启用谁该想方法
            [PRompt promptVoice:voice Vibration:vibration];

        }
    }
}
/**
 *  判断谁该响
 *
 *  @param voice     声音
 *  @param vibration 震动
 */
+(void)promptVoice:(BOOL)voice Vibration:(BOOL)vibration
{
    
    if (voice && vibration) {//判断是震动还是声音
        
        
        
        [PRompt promptVibrationPrompt:3];
        
    }else if (voice){
        
         [PRompt promptVibrationPrompt:1];
        
    }else if (vibration){
        
           [PRompt promptVibrationPrompt:2];
        
    }
    
    
    
}


#pragma mark - 勿扰设置的存储


/**
  储存设置状态

 @param model 1
 */
+(void)promptStorageSetState:(SetMessage * )model
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [userDefaults setObject:data forKey:k_set];
}

/**
 *  读取设置
 */
+(SetMessage *)promptReadStorage
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:k_set];
    SetMessage * model = (SetMessage *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
}

/**
 *  判断本地是否储存设置
 */
+(BOOL)promptBeingstorage
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:k_set];
    if (data) {
        return YES;
    }else{
        return NO;
    }
}

///**
// *  储存屏蔽群组号   环信群组号
// *
// *  @param array
// */
//+(void)storageShieldingGroupArray:(NSMutableArray *)array
//{
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
//    [userDefaults setObject:data forKey:k_setArray];
//}
//
///**
// *  读取屏蔽群组号   环信群组号
// *
// *  @return array
// */
//+(NSMutableArray *)readShieldingGroupArray
//{
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    NSData * data = [userDefaults objectForKey:k_setArray];
//    NSMutableArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    if (array == nil) {
//        array = [[NSMutableArray alloc]initWithCapacity:0];
//    }
//    return array;
//}

/**
 *  存储聊天室消息免打扰
 */
+(void)judgeChatRoomMessage:(BOOL)message
{
//     BOOL  isMessage = [message isEqualToString:@"0"]?NO:YES;
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%d",message] forKey:k_chatRoomMessage];
}
/**
 *  读取聊天室消息免打扰
 */
+(BOOL)judgeStateChatRoomMessage
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * str = [userDefaults objectForKey:k_chatRoomMessage];
    if (str.length == 0) {
        [PRompt judgeChatRoomMessage:YES];
        return YES;
    }else{
        return [str isEqualToString:@"0"]?NO:YES;
    }
}

#pragma mark -判断时间
/**
 *  判断在不在时段内
 *
 *  @param fromHour
 *  @param toHour
 *
 *  @return
 */
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
      NSDate *date8 = [self getCustomDateWithHour:fromHour];
       NSDate *date23 = [self getCustomDateWithHour:toHour];
       NSDate *currentDate = [NSDate date];
   
    if ([currentDate compare:date8]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
           {
                NSLog(@"该时间在 %ld:00-%ld:00 之间！", (long)fromHour, (long)toHour);
                return YES;
             }
     return NO;
}

/**
  * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
  * @param hour 如hour为“8”，就是上午8:00（本地时间）
  */
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour
 {
    //获取当前时间
     NSDate *currentDate = [NSDate date];
 
   NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
      NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
       // 生成当天的component
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
       //设置当天的某个点
       NSDateComponents *resultComps = [[NSDateComponents alloc] init];
     [resultComps setYear:[currentComps year]];
      [resultComps setMonth:[currentComps month]];
       [resultComps setDay:[currentComps day]];
        [resultComps setHour:hour];
 
       // 根据resultCalendar和resultComps生成日期
       NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
      return [resultCalendar dateFromComponents:resultComps];
}


#pragma mark -- 让消息提示不频繁
//定时器开启 当结束时 本地提示变量为NO
+(void)timeCountdown
{
    [PRompt PromptStorage:YES];
//    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:3.0f];
     __block int timeout=1; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"1秒到了");
                [PRompt PromptStorage:NO];
            });
        }else{
            timeout--;
        }  
    });
    dispatch_resume(_timer);
}


//储存是否提示变量
+(void)PromptStorage:(BOOL)prompt
{
 NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
 NSString *aa = [NSString stringWithFormat:@"%d",prompt];
[userDefaults setObject:aa forKey:k_WhetherPrompt];
[userDefaults synchronize];//调用synchronize方法强制写入
}

//读取是否提示变量
+(BOOL)PromptRead
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * str = [userDefaults objectForKey:k_WhetherPrompt];
    if (str.length == 0) {
        return NO;
    }else{
    BOOL aa = [str boolValue];
    return aa;
    }
}




@end
