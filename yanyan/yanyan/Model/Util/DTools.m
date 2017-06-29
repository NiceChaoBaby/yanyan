//
//  DTools.m
//  storm
//
//  Created by dong on 15/7/8.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import "DTools.h"
#import "NSDictionary+Safety.h"
//#import "BlickListModel.h"
#import "UserPermissionsModel.h"
//#import "FriendAloneChatViewController.h"
#import "DPlistSave.h"
#import <CoreLocation/CLLocationManager.h>
//#import "ChatMessageClass.h"

@implementation DTools
/**
 *  判断字符串是否为空 YES空  NO不空
 *
 *  @param aStr 1
 *
 *  @return 1
 */
+(BOOL)isStringEmpty:(NSString*)aStr
{
    if (aStr == nil) {
        return YES;
    }
    
    if (aStr == NULL) {
        return YES;
    }
    
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[aStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        return YES;
    }
    
    if ([aStr isEqualToString:@"null"])
    {
        return YES;
    }
    if ([aStr isEqualToString:@"-"])
    {
        return YES;
    }
    return NO;
}
/**
 *  得到版本号
 *
 *  @return 1
 */
+(NSString*)getVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
}
/**
 *  得到软件名称
 *
 *  @return 1
 */
+(NSString*)getSoftName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

//切圆角头像，按钮默认10
+(void)getAvaterCorner:(UIView*)v{
    [v.layer setMasksToBounds:YES];
    [v.layer setCornerRadius:5];
  
}

/**
 还原圆角
 */
+(void)getZeroAvaterCorner:(UIView *)v
{
    [v.layer setMasksToBounds:YES];
    [v.layer setCornerRadius:0];

    
}
//通过Graphics 和 BezierPath 设置圆角
+ (void)setGraphicsCutCirculayWithView:(UIImageView *) view roundedCornersSize:(CGFloat )cornersSize
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornersSize] addClip];
    [view drawRect:view.bounds];
    view.image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束
    UIGraphicsEndImageContext();
}
//切圆角标签默认6
+(void)getLabelCorner:(UIView*)v{
    [v.layer setMasksToBounds:YES];
    [v.layer setCornerRadius:3];
}
//切90度
+(void)getCorner:(UIView*)v radius:(CGFloat)radius{

    [v.layer setCornerRadius:radius];
        [v.layer setMasksToBounds:YES];
}
//加边框
+(void)getBorder:(UIView*)v Width:(CGFloat)f andColor:(CGColorRef)color{
    [v.layer setBorderWidth:f];
    [v.layer setBorderColor:color];
    
}
/**
 *  切圆形view
 *
 *  @param view 1
 */
+(void)setImageView:(UIView*)view
{
    [view .layer setCornerRadius:(view .frame.size.height/2)];
    [view .layer setMasksToBounds:YES];
    [view  setContentMode:UIViewContentModeScaleAspectFill];
    [view  setClipsToBounds:YES];
   
    view .userInteractionEnabled = YES;
    view .backgroundColor = [UIColor clearColor];
}
//得到view的viewController
+(UIViewController*)getViewController:(UIView*)view
{
    UIResponder* responder = view.superview;
    while (![responder isKindOfClass:[UIViewController class]])
    {
        responder = responder.nextResponder;
    }
    if ([responder isKindOfClass:[UIViewController class]])
    {
        return  (UIViewController *)responder;
    }
    else
    {
        return nil;
    }
}

+(BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

//iphone应用变成中，不识别16进制的表示法，需要转化成rgb表示法
+(UIColor *) getColor:(NSString *)hexColor
{
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}


/**
 *  判断是否有空值有空值就赋予@“”
 *  因为服务器会返回空值这会导致我存入本地数据时失败
 *  @param dic 1
 *
 *  @return 新字典（不存在nil,null）
 */
+(NSDictionary *)getIsNull:(NSDictionary *)dic
{
    NSMutableDictionary *dics=[[NSMutableDictionary alloc] init];
    for (int i=0; i<dic.allKeys.count;i++)
    {
       NSString *key= [dic.allKeys objectAtIndex:i];
        NSString *value=[dic safeObjectForKey:key];
        [dics setValue:value forKey:key];
    }
    return dics;
}
+(NSString *)currentTime
{
    NSDate *currentDate=[[XSDTimeCalibration share]getServerDate];
    NSDateFormatter *currentFormatter=[[NSDateFormatter alloc] init];
    [currentFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTime=[currentFormatter stringFromDate:currentDate];
    return currentTime;
}
+(NSString *)getTime:(NSString *)times
{
    NSString *timeString=@"";
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSDate *date=[[XSDTimeCalibration share]getServerDate];
    NSString *curdate=[dateFormatter stringFromDate:date];
    //创建了两个日期对象
    NSDate *date1=[dateFormatter dateFromString:curdate];
    NSDate *date2=[dateFormatter dateFromString:times];
   
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval cha=[date1 timeIntervalSinceDate:date2];

    if (cha<60)
    {
        timeString =@"刚刚";
       
        
    }
    if (cha>=60&&cha/3600<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];//是开始位置截取到指定位置但是不包含指定位置
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    // days = different / (24 * 60 * 60) ——>86400
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    
    if (cha/86400>1&&cha/86400<30)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        
    }
    if (cha/(86400*30)>1)
    {
      
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"MM月dd日"];
       
        NSString *  locationString=[dateformatter stringFromDate:date2];
        
        timeString=locationString;
    }

    return timeString;
}

/**
 *  得到2者之间的距离
 *
 *  @return 距离
 */
+(NSString *)getBetweenDistance:(NSString*)lat lng:(NSString*)lng
{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    float latB= [[accountDefaults objectForKey:UserLocationLa] floatValue];
    float lngB= [[accountDefaults objectForKey:UserLocationLo] floatValue];
    if ([lat floatValue]<=90&&[lat floatValue]>=-90&&[lng floatValue]<=180&&[lng floatValue]>=-180&&latB <=90&&latB >=-90&&lngB<=180&&lngB >=-180)
    {
        // 经纬度计算距离
        //第一个坐标
        CLLocation *current=[[CLLocation alloc] initWithLatitude:[lat floatValue] longitude:[lng floatValue]];
       
        
            //第二个坐标
            CLLocation *before=[[CLLocation alloc] initWithLatitude:latB longitude:lngB];
            // 计算距离
            CLLocationDistance meters=[current distanceFromLocation:before];
        if ((meters/1000)==0)
        {
            return @"未知";
        }
            return [NSString stringWithFormat:@"%.2fkm",meters/1000];
        
    }
    else
    {
        return @"未知";
    }
   
}
/**
 *  得到用户的年龄
 *
 *  @return 年龄
 */
+(NSString *)getUserAge:(NSString*)birth
{
    
    if (![birth isNull])
    {
        return @"";
    }
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [inputFormatter dateFromString:birth];
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:inputDate];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[[XSDTimeCalibration share]getServerDate]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    if (iAge <0 ) {
        iAge = 0;
    }
    return [NSString stringWithFormat:@"%li",(long)iAge];
}
#pragma mark - 是否定位储存
/**
 *  定位储存 是否开启
 *
 *  @param storage 定位开关
 */
+(void)positioningMessageStorage:(BOOL)storage
{
    NSString * a = [NSString stringWithFormat:@"%d",storage];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:a];
    [userDefaults setObject:data forKey:k_positioning];
}
/**
 *  读取定位是否开启
 *
 *  @return 是否开启了定位
 */
+(BOOL)positioningMessageRead
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:k_positioning];
    if (data)
    {
         return [[NSKeyedUnarchiver unarchiveObjectWithData:data] isEqualToString:@"0"]?NO:YES;
    }else
    {
        [DTools positioningMessageStorage:YES];
        return YES;
    }
   

}
#pragma mark - 本地储存最后一次消息时间

/**
 存储 申请消息 或者  系统消息最后一次时间
 */
+(void)storageLastMessageTime:(NSString *)time
{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:time forKey:K_lastMessageTime];
    
}

/**
 取出 申请消息或者 系统最后一次时间
 */
+(NSString *)TakeLastMessageTime
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
       return [userDefaults objectForKey:K_lastMessageTime];
}


#pragma mark - 本地储存黑名单
/**
 *  存储黑名单列表
 */
+(void)storageUserBlackList:(NSMutableArray *)array
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [userDefaults setObject:data forKey:k_blackList];
}

/**
 *  获取黑名单
 */
+(NSMutableArray *)haveStorageUserBlackList
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:k_blackList];
   return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
}

/**
 *  判断黑名单是否有此用户
 */
+(BOOL)judgeBlackListUserID:(NSString *)userID
{
    BOOL user = NO;
//    NSMutableArray * array = [DTools haveStorageUserBlackList];
     //6.26 xiong
//    for (BlickListModel * model in array) {
//        
//    if ([model.m_easeUname isEqualToString:userID]) {
//        
//        user = YES;
//        return user;
//        break;
//        }
//        
//        
//    }
    return user;
    
}

/**
 *  删除聊天室
 */
+(void)DeleteCurrentPage
{
    
    //6.26 xiong
//    [[NSNotificationCenter defaultCenter]  postNotificationName:K_LeaveChatRoom object:nil];
//    [[ChatTime shareInstance]chatTimeEnd];
//    [ShareAppDelegate.m_chatRoomDict removeObjectForKey:K_CHAT_ROOM_KEY];
}

/**
 *  存储感兴趣时间 1分钟 感兴趣3次
 */
+(void)StoredInterestedTimeOneMin:(NSString *)time KName:(NSString *)name
{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * array = [DTools TakeOutInterestedTimeArrayKName:name];
    if (array.count == 2) {
        [array removeAllObjects];
    }
    
    [array addObject:time];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
    
    [userDefaults setObject:data forKey:name];
    [userDefaults synchronize];//调用synchronize方法强制写入
}

/**
 *  对比3次次点击事件间隔是否为1分钟
 */
+(BOOL)compareTouch:(NSString*)newTime KName:(NSString *)name
{
    NSMutableArray * array = [DTools TakeOutInterestedTimeArrayKName:name];
    
    if (array.count == 2 ) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *dt1 = [[NSDate alloc] init];
        NSDate *dt2 = [[NSDate alloc] init];
        dt1 = [df dateFromString:array[0]];
        dt2 = [df dateFromString:newTime];
        NSTimeInterval numberTime =[dt2 timeIntervalSinceDate:dt1];
        int  betweenTime = [[NSString stringWithFormat:@"%f",numberTime]intValue];
        
        if (betweenTime > 60) {

             return YES;
        }else{
            
            return NO;
        }
       
        
    }else{
        
        return YES;
    }
}

/**
 *  取出存储时间感兴趣数组
 */
+(NSMutableArray *)TakeOutInterestedTimeArrayKName:(NSString *)name
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
     NSData * data = [userDefaults objectForKey:name];
    NSMutableArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (array == nil) {
        array = [[NSMutableArray alloc]initWithCapacity:0];
        return array;
    }else{
        return array;
    }
  
    
}



/**
 *  存储感兴趣时间 2小时版
 */
+(void)StoredInterestedTime:(NSString *)time
{
    //    NSString  * time = [self tellMeTime];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:time forKey:k_ClickTime];
    [userDefaults synchronize];//调用synchronize方法强制写入
}
/**
 *  取出存储时间
 */
+(NSString *)TakeOutInterestedTime
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * oldtime = [userDefaults objectForKey:k_ClickTime];
    
    return oldtime;
    
}
/**
 *  转换时间
 *  @param time 给我剩余时间
 */
+(NSString *)ConversionTime:(NSString *)time
{
    
    NSDate *data=[[XSDTimeCalibration share]getServerDate];
    data=[data dateByAddingTimeInterval:[time floatValue]];
    NSDateFormatter *currentFormatter=[[NSDateFormatter alloc] init];
    [currentFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *endTime=[currentFormatter stringFromDate:data];
    
    return endTime;
   

}

/**
 跟上面不一样的格式
 */
+(NSString *)ConversionTimeTwoFormat:(NSString *)time
{
    NSString * latestMessageTime;
    double timeInterval = [time longLongValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    return latestMessageTime;
    
    
    
}
/**
  *  转换时间 不需要加当前时间 直接是1970年到到期时间的秒数  我自己直接转化成到期时间
  */
+(NSString *)ConversionTimeTwo:(NSString *)time
{
    NSString * latestMessageTime;
    double timeInterval = [time longLongValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
       return latestMessageTime;
   
    
}

/**
 计算新闻聊天内容刷新整点
 */
+(NSString *)NewConversionTime:(NSString *)time
{
    
    NSString * latestMessageTime;
    double timeInterval = [time longLongValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    return latestMessageTime;
}
/**
 *  对比时间 过了多久
 */
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02
{
   
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
   
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSTimeInterval numberTime =[dt2 timeIntervalSinceDate:dt1];
    int  betweenTime = [[NSString stringWithFormat:@"%f",numberTime]intValue];
    
//    NSComparisonResult result = [dt1 compare:dt2];
//    switch (result)
//    {
//            //date02比date01大
//        case NSOrderedAscending: ci=1; break;
//            //date02比date01小
//        case NSOrderedDescending: ci=-1; break;
//            //date02=date01
//        case NSOrderedSame: ci=0; break;
//        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
//    }
    if (betweenTime < 0) {
        betweenTime = 0;
    }
    return betweenTime;
}

/**
 * 判断消息身份   是否发送方
 * type  0 普通 1 管理员 2 创建人 3 群主
 * direction  YES 发送方  NO 非发送方
 */
+(UIImage *)ChatDubbleDetermineType:(ChatInfoType)type direction:(BOOL)direction
{
    if (type == ordinary) {
        //普通
        if (direction) {
        //发送方
        return  ImageNamed(@"bubble-2");
        
        }else{
        //不是发送方
        return ImageNamed(@"bubble-1");
        }
        
    }else{
        //管理员  创建人  群主

        if (direction) {
            //发送方
            return  ImageNamed(@"warden_bubble-2");
            
        }else{
            //不是发送方
            return ImageNamed(@"warden_bubble-1");
        }
        
    }
    
    
    
    
    
    return nil;
}


///**
// *  对比时间 过了多久
// */
//-(NSMutableDictionary *)CompareTime:(NSString *)oldtime
//{
//    //判断是否有点击记录的时间
//    if ([oldtime integerValue] != 0) {
//        NSString  * time = [self tellMeTime];
//        NSDateFormatter * dateFormatter=[[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
//        NSDate * date1=[dateFormatter dateFromString:oldtime];
//        NSDate * date2=[dateFormatter dateFromString:time];
//        NSTimeInterval numberTime =[date2 timeIntervalSinceDate:date1];
//        NSString * alls = [NSString stringWithFormat:@"%f",numberTime];
//        //几天
//        int days=((int)numberTime)/(3600*24);
//        NSString * daysS = [NSString stringWithFormat:@"%d",days];
//        //几小时
//        int hours=((int)numberTime)%(3600*24)/3600;
//        NSString * hoursS = [NSString stringWithFormat:@"%d",hours];
//        //    //几分钟
//        //    int minutes = ((int)numberTime%(3600*24)%3600)/60;
//        //    NSString * minutesS =[NSString stringWithFormat:@"%d",minutes];
//        //创建
//        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//        
//        //添加字典
//        [dictionary setObject:daysS forKey:@"days"];
//        [dictionary setObject:hoursS forKey:@"hours"];
//        [dictionary setObject:alls forKey:@"alls"];
//        //    [dictionary setObject:minutesS forKey:@"minutes"];
//        
//        
//        return dictionary;
//        
//    }else{
//        return nil;
//    }
//}
//

/**
 ID是否是我自己
 */
+(BOOL)IFMyID:(NSString *)uid
{
    //得到用户保存的uid和code
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uidStr=[accountDefaults objectForKey:UserDefaultNameKey];
    return [uidStr isEqualToString:uid];
}
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
    result = nextResponder;
    else
    result = window.rootViewController;
    
    return result;
}
/**
 *  个人好友列表读取   读取Model数组返回
 */
+(NSMutableArray *)myFriendListLocalRead
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:k_friends];
    NSMutableArray * array = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return array;
}


/**
    存储好友请求时间
 */
+(void)recordFriendsListRequestTime:(NSString *)time
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:time forKey:k_reqFriendList];
}

/**
    好友列表是否可以请求
 */
+(BOOL)reqFriendListNowTime:(NSString *)nowTime
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * time = [userDefaults objectForKey:k_reqFriendList];
    if (![time isNull]) {
        return  YES;
    }else{
    
  int   howTime =  [DTools compareDate:nowTime withDate:time];
    
   
    int  numberTime = 60 * 3;//
    if (howTime < numberTime ) {
        return NO;
    }
    return YES;
    }
}


/**
 存储群组请求时间
 */
+(void)recordGroupListRequestTime:(NSString *)time
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:time forKey:k_reqGroupList];
}

/**
 群组列表是否可以请求
 */
+(BOOL)reqGroupListNowTime:(NSString *)nowTime
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString * time = [userDefaults objectForKey:k_reqGroupList];
   
    if (![time isNull]) {
    
        return  YES;
    
    }else{
        
        int   howTime =  [DTools compareDate:nowTime withDate:time];
        
        
        int  numberTime = 60 * 3;//
    
        if (howTime < numberTime ) {
        
            return NO;
        
        }
       
        return YES;
    
    }

}
//6.26 xiong

/**
 比较好友

 @param uid 好友id

 @return YES 是 好友 no 非好友
 */
+(BOOL)compareIsFriend:(int)uid
{
    NSMutableArray *arr=[FriendListModel mj_objectArrayWithKeyValuesArray:[self myFriendListLocalRead]];
    for (FriendListModel *model  in arr)
    {
        if ([model.m_fuid integerValue] == uid)
        {
            return YES;
            break;
        }
        
    }
    return NO;
}

/**
 比较好友
 
 @param uid 好友id
 
 @return YES 是 好友 no 非好友
 */
+(BOOL)compareIsFriendEaseId:(NSString *)easeid
{
    NSMutableArray *arr=[FriendListModel mj_objectArrayWithKeyValuesArray:[self myFriendListLocalRead]];
    for (FriendListModel *model  in arr)
    {
        if ([model.m_easeUname isEqualToString: easeid])
        {
            return YES;
        }
        
    }
    return NO;
}


+(FriendListModel *)CompareIsFriendModelEaseId:(NSString *)easeid
{
    
    
    NSMutableArray *arr=[FriendListModel mj_objectArrayWithKeyValuesArray:[self myFriendListLocalRead]];
    for (FriendListModel *model  in arr)
    {
        if ([model.m_easeUname isEqualToString: easeid])
        {
            return model;
        }
        
    }
    return nil;
    
}


/**
 通过环信用户id 获取好友用户id

 @param uid 用户环信id
 @return 用户id
 */
+(int)compareXSDIsFriendEaseId:(NSString *)uid
{
    NSMutableArray *arr=[FriendListModel mj_objectArrayWithKeyValuesArray:[self myFriendListLocalRead]];
    for (FriendListModel *model  in arr)
    {
        if ([model.m_easeUname isEqualToString: uid])
        {
            return [model.m_fuid intValue];
        }
        
    }
    return 0;
}
/**
 
 用户是否开始定位

 @return
 */
+(BOOL)userIsOpenLocation
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status)
    {
        
//        [self positioningMessageStorage:NO];
        return NO;
    }
//     [self positioningMessageStorage:YES];
    return YES;
}
+ (void)alertController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message handler:(void (^ __nullable)(UIAlertAction *action))handler
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        handler(action);
    }];
    
    [alert addAction:cancel];
    
    [controller presentViewController:alert animated:YES completion:nil];
}

/**
 读取等级提示信息
 */
+(NSString *)userReadLevelCluesLevel:(NSString *)userlevel
{
    NSString * title;
    NSString * desc;
    switch ([userlevel integerValue]) {
        case 1:
          title = @"总共可加入3个群组。每天首次发言将获得经验积分，祝您聊的愉快！";
            break;
        case 2:
            title =@"总共可加入4个群组。每天首次发言将获得经验积分，祝您聊的愉快！";
            break;
        case 3:
            title =@"可以建立1个群组；总共可加入5个群组。成为群主，打造属于自己的特色群聊！每天首次发言将获得经验积分，祝您聊的愉快！";
            break;
        case 4:
            title =@"可以建立2个群组；总共可加入6个群组。成为群主，打造属于自己的特色群聊！每天首次发言将获得经验积分，祝您聊的愉快！";
            break;
        case 5:
            title =@"可以建立3个群组；总共可加入7个群组。成为群主，打造属于自己的特色群聊！每天首次发言将获得经验积分，祝您聊的愉快！";
            break;
        case 6:
            title =@"总共可加入8个群组。每天首次发言将获得经验积分，祝您聊的愉快！";
            break;
        case 7:
            
            title =@"总共可加入9个群组。每天首次发言将获得经验积分，祝您聊的愉快！";
            
            break;
        default:
            break;
    }
    
if ([userlevel integerValue] >=8)
       {
       
        title =@"总共可加入10个群组。每天首次发言将获得经验积分，祝您聊的愉快！";
        
       }
    
        desc = [NSString stringWithFormat:@"您好，恭喜您升级到【%@级】，获得特权：%@",userlevel,title];
    
    return desc;
}

//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL) isEmpty:(NSString *) str
{
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

/**
 判断是否含有空格
 */
+(BOOL) isHaveEmpty:(NSString *)str
{
    
    NSRange _range = [str rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return YES;
    }else {
        return NO;
    }
    
    
}
/**
 去除首尾空格和换行
 */
+(NSString *)filterString:(NSString *)str
{
    
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
//去掉特殊字符 
+(NSString *)filterSpecialString:(NSString *)str
{
 NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"/／\\|\""];
    
 NSString *trimmedString = [str stringByTrimmingCharactersInSet:set];
    
    return trimmedString;
}

/**
 判断是否存在自己设定的特殊字符
 */
+(BOOL)filterSpecialStringJudge:(NSString *)str  Rules:(NSString *)rules
{
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString:rules]];
    
    if (urgentRange.location == NSNotFound)
        
    {
        
        return NO;
        
    }
    
    return YES;

    
}


/**
 判断是否有特殊字符存在
 */
+(BOOL)filterSpecialStringJudge:(NSString *)str
{
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"\n "]];
    
    if (urgentRange.location == NSNotFound)
        
    {
        
        return NO;
        
    }
    
    return YES;
    
}
/**
 检测敏感字

 @param word 字符串
 @return bool
 */
+(BOOL)isWordSensitive:(NSString *)word
{
    if ( [[WordFilter sharedInstance] iswordSensitivefilter:word])
    {
        UtilAlert(nil, @"提交失败，输入内容包含敏感字符");
        return YES;
    }else
    {
        return NO;
    }
}

//麦克风
+ (BOOL)isCanUseMicrophone {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        UtilAlert(@"无法使用麦克风", @"请在iPhone的\"设置-隐私\"中允许访问麦克风");
        //无权限
        return NO;
    }
    return YES;
}
+ (BOOL)isCanUseCamera {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        //无权限
        UtilAlert(@"无法使用相机", @"请在iPhone的\"设置-隐私\"中允许访问相机");
        //无权限
        return NO;
    }
    return YES;
}
+ (BOOL)isCanUsePhotos {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
             UtilAlert(@"无法使用相册", @"请在iPhone的\"设置-隐私\"中允许访问相册");
            //无权限
            return NO;
        }
    }
    else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
             UtilAlert(@"无法使用相册", @"请在iPhone的\"设置-隐私\"中允许访问相册");
            //无权限
            return NO;
        }
    }
    return YES;
}


//统计未读数
+(void)refreshUnreadMessage
{
//    6.26 xiong
//    ChatMessageClass * m_class =[[ChatMessageClass alloc]init];
//    UIViewController * view = [[UIViewController alloc]init];
//    NSInteger  number =  [m_class getChatMessageAllNumber];
//    NoticeModel * m_noticeMoel = [view messageLocalRead];
//    NoticeModel * m_noticeMoel1 = [view messageLocalReadApply];
//    
//    number += m_noticeMoel.m_number;
//    number += m_noticeMoel1.m_number;
//
//    [view storageAllMessageNumber:[NSString stringWithFormat:@"%ld",number]];

}
//6.26 xiong
//
///**
// 判断账号是否还在全局禁言
// */
//+(BOOL)whetherGlobalSilence
//{
//    RegisteredUser * model = [DPlistSave readUserData];
//    
//  NSDate * data  =  [[XSDTimeCalibration share]getServerDate];
//    
//  NSInteger  now = [data timeIntervalSince1970];
//    
//    if (model.m_finishTime > now) {
//        
//    NSInteger remain = model.m_finishTime - now;//得到禁言剩余秒数
//        
//        NSInteger hour = remain/3600;//小时
//        NSInteger min  = (remain - hour *3600)/60;
//        NSString * str = @"您已被禁言，剩余";
//        if (hour >0) {
//        str = [NSString stringWithFormat:@"%@%ld小时",str,hour];
////            [DTools alertController:<#(UIViewController *)#> title:<#(NSString *)#> message:<#(NSString *)#> handler:<#^(UIAlertAction *action)handler#>]
//        }
//        str = [NSString stringWithFormat:@"%@%ld分钟",str,min];
//        UtilAlert(nil, str);
//        
//        return YES;
//    }
//    
//    return NO;
//}

+(void )GetPhoto:(id)m_asset completion:(void (^)(UIImage *photo))completion
{
    
    if ([m_asset isKindOfClass:[PHAsset class]]) {
        
        PHAsset *phAsset = (PHAsset *)m_asset;
        CGSize size =  CGSizeMake(phAsset.pixelWidth, phAsset.pixelHeight);
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        // 同步获得图片, 只会返回1张图片
        options.synchronous = YES;
        options.resizeMode = PHImageRequestOptionsResizeModeFast;
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            completion(result);
            
        }];
        
    }
    else if ([m_asset isKindOfClass:[ALAsset class]])
    {
//        ALAsset *alAsset = (ALAsset *)m_asset;
    }
    

    
}
+ (PHImageRequestID)getPhotoWithAsset:(id)asset isSynchronous:(BOOL)isSynchronous photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion progressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler networkAccessAllowed:(BOOL)networkAccessAllowed {
    if ([asset isKindOfClass:[PHAsset class]]) {
      
        CGSize imageSize;
        
        PHAsset *phAsset = (PHAsset *)asset;
        CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
        CGFloat pixelWidth = photoWidth * 2;
        CGFloat pixelHeight = pixelWidth / aspectRatio;
         imageSize = CGSizeMake(pixelWidth, pixelHeight);
        if(photoWidth==0)
        {
         imageSize = CGSizeMake(phAsset.pixelWidth, phAsset.pixelHeight);
        }
       
       
        

        // 修复获取图片时出现的瞬间内存过高问题
        // 下面两行代码，来自hsjcom，他的github是：https://github.com/hsjcom 表示感谢
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
        // 同步获得图片, 只会返回1张图片
        option.synchronous = isSynchronous;

        PHImageRequestID imageRequestID = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
                                           {
                                               BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
                                               if (downloadFinined && result) {
                                                   result = [self fixOrientation:result];
                                                   if (completion) completion(result,info,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
                                               }
                                               // Download image from iCloud / 从iCloud下载图片
                                               if ([info objectForKey:PHImageResultIsInCloudKey] && !result && networkAccessAllowed) {
                                                   PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
                                                   options.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           if (progressHandler) {
                                                               progressHandler(progress, error, stop, info);
                                                           }
                                                       });
                                                   };
                                                   options.networkAccessAllowed = YES;
                                                   options.resizeMode = PHImageRequestOptionsResizeModeFast;
                                                   [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                                                       UIImage *resultImage = [UIImage imageWithData:imageData scale:0.1];
                                                       resultImage = [self scaleImage:resultImage toSize:imageSize];
                                                       if (resultImage) {
                                                           resultImage = [self fixOrientation:resultImage];
                                                           if (completion) completion(resultImage,info,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
                                                       }
                                                   }];
                                               }
                                           }];
        
        return imageRequestID;
    }
    else if ([asset isKindOfClass:[ALAsset class]])
    {
//        ALAsset *alAsset = (ALAsset *)asset;
     
    }

   return 0;
}
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 *  修改图片的方向
 *
 *  @param aImage 图片
 *
 *  @return 图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
+(NSString * )photoIdefer:(id)asset
{
    NSString * str;
    if (ISIOS8) {
        
        PHAsset *phAsset = (PHAsset *)asset;
        str = phAsset.localIdentifier;
    } else {
        ALAsset *alAsset = (ALAsset *)asset;
        NSURL *assetUrl = [alAsset valueForProperty:ALAssetPropertyAssetURL];
        
        str = [assetUrl absoluteString];
    }
    return str;
    
}


/**
 * 计算缩放比
 *
 * @param bitWidth  当前图片宽度
 * @param bitHeight 当前图片高度
 * @return
 * @Description:函数描述 http://blog.csdn.net/jaycee110905/article/details/50600566
 */
+(CGFloat) getRatioSize:(CGFloat) bitWidth bitHeight:(CGFloat) bitHeight {
    // 图片最大分辨率
    CGFloat imageHeight = 1280;
//    int imageWidth = 1280;
    // 缩放比
    CGFloat ratio = 1;
    //a，图片宽或者高均小于或等于1280时图片尺寸保持不变，但仍然经过图片压缩处理，得到小文件的同尺寸图片
    if (bitWidth <= imageHeight && bitHeight <= imageHeight) {
       
        ratio = 1;
        //b，宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
    } else if (bitWidth > imageHeight || bitHeight > imageHeight) {
        
        if(bitWidth/bitHeight<=2)
        {
            ratio=imageHeight/MAX(bitWidth, bitHeight);
        }else if(bitWidth/bitHeight>2)
        {
            //c，宽或者高大于1280，但是图片宽高比大于2时，并且宽以及高均大于1280，则宽或者高取小的等比压缩至1280
            if (bitWidth > imageHeight && bitHeight > imageHeight){
                 ratio=imageHeight/MIN(bitWidth, bitHeight);
            }
            
        //  d  宽或者高大于1280，但是图片宽高比大于2时，并且宽或者高其中一个小于1280，则压缩至同尺寸的小文件图片
         if (bitWidth <= imageHeight || bitHeight <= imageHeight)
         {
              ratio=1;
          }
        }
    }
    // 最小比率为1
    if (ratio <= 0)
        ratio = 1;
    return ratio;
}

/**
 图片缩放

 @param img 原图
 @return 缩放图片
 */
+ (UIImage *)scaleToSize:(UIImage *)img{
    
   CGSize size;
   CGFloat ratio= [self getRatioSize:img.size.width bitHeight:img.size.height];
    size.width= img.size.width*ratio;
    size.height=img.size.height*ratio;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    
    return scaledImage;
}


/**
 解析原图@缩略图

 @param str <#str description#>
 @return <#return value description#>
 */
+(NSMutableDictionary *)ImageResolution:(NSString *)str
{
    if (![DTools isStringEmpty:str]) {//把图片字符串分割出来
        //缩略图数组
        NSMutableArray * arrayThimage = [[NSMutableArray alloc]initWithCapacity:0];
        //原图
        NSMutableArray * arrayOriginal = [[NSMutableArray alloc]initWithCapacity:0];
        //接收字符串分割
        NSMutableArray * array = [[NSMutableArray alloc]initWithCapacity:0];
        [array addObjectsFromArray: [str componentsSeparatedByString:@","]];
        
        //拷贝接收字符串
        NSMutableArray * array1 = [array copy];
        
        for (int i = 0; i < array1.count; i ++) {
            
            NSString * str = array1[i];
            
            if ([DTools isStringEmpty:str]) {
                [array removeObjectAtIndex:i];
            }else{
                
                //原图@缩略图
                NSArray * arrayOne = [str componentsSeparatedByString:@"@"];
                if (arrayOne.count >=2) {
                    
                    [arrayOriginal addObject:arrayOne[0]];
                    [arrayThimage addObject:arrayOne[1]];
                    
                }else{
                    
                    [arrayOriginal addObject:arrayOne[0]];
                }
                
            }
        }
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        //原图
        [dic setObject:arrayOriginal forKey:k_OriginalImage];
        //缩略图
        [dic setObject:arrayThimage forKey:k_ThumbnailImage];
        
        return dic;
    }else{
        
        return  nil;
        
    }
    
    
}

/**
 聊天室结束  2个小时
 */
+(void)chatRoomEnd
{
   
         //6.26 xiong
//        if ([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
//        {//如果有聊天室
//            ChatViewController * chat  = [ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY];//取出聊天室
//            if (chat.m_chatRoomType == ChatRoomTypeTopic)
//            {//判断是不是话题聊天室
//                
//                
//                //    话题聊天室
//                NSUserDefaults *time=[NSUserDefaults standardUserDefaults];
//                NSDate* theDate=[time objectForKey:K_TopEndTime];
//                
//               [self theDate:theDate];
//            }else
//            {
//                //    话题聊天室
//                NSUserDefaults *time=[NSUserDefaults standardUserDefaults];
//                NSDate* theDate=[time objectForKey:K_NewsEndTime];
//                [self theDate:theDate];
//               
//
//            }
//        }
   

}

/**
 是否登陆
 */
+(BOOL)isLogin
{
   //6.26 xiong
//    RegisteredUser * userModel = [DPlistSave readUserData];
//    //判断是否自动登录
//        BOOL isAutoLogin = [EMClient sharedClient].isAutoLogin;
//    if (userModel != nil  && [userModel.m_id integerValue]>0 && ![DTools isStringEmpty:userModel.m_uname] && isAutoLogin) {
//        
//        return YES;
//    }
    
    
    return NO;
}

/**
 给按钮添加等待动画
 */
+(void)buttonWaitForHUD:(UIButton *)btn HUD:(BOOL)hud
{
    //6.26 xiong
//    //隐藏完成动画
//    [XLPaymentSuccessHUD hideIn:btn];
//    if (hud) {
//        //显示等待中动画
//        [XLPaymentLoadingHUD showIn:btn];
//    }else{
//        //隐藏等待中成动画
//        [XLPaymentLoadingHUD hideIn:btn];
//    }
}

/**
 给按钮添加完成动画
 */
+(void)buttonCompleteHUD:(UIButton *)btn blockBtn:(void(^)(bool isDown))blockbtn
{
    //6.26 xiong
    //隐藏等待动画
//    [XLPaymentLoadingHUD hideIn:btn];
//    //显示完成动画动画
//    [XLPaymentSuccessHUD showIn:btn];
//    double delayInSeconds = 1.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        //隐藏完成动画动画
//        [XLPaymentSuccessHUD hideIn:btn];
//        blockbtn(YES);
//    
//    });

}

-(void)delayMethod:(id)blockBtn
{
  
    
}
+(void)theDate:(NSDate*)time
{
    // 获取系统当前的时间戳
    NSTimeInterval cha=[time timeIntervalSinceDate:[[XSDTimeCalibration share]getServerDate]];
    if (cha<0)//判断话题聊天室2个小时结束
    {
        [self DeleteCurrentPage];//是并且时间到了  就删除掉
    }
}


/**
 自改 2017  05 08  获取data gif
 */
+ (NSData *)xsd_dataGIFNamed:(NSString *)name {
    CGFloat scale = [UIScreen mainScreen].scale;
    
    if (scale > 1.0f&&scale<3) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return data;
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return data;
        } return nil;
        
    }else if (scale>=3) {
        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@3x"] ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
        
        if (data) {
            return data;
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return data;
        }
         return nil;
    }
    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return data;
        }
        
        return nil;
    }
}


@end
