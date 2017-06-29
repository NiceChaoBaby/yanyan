//
//  UIViewController+StorageMethods.m
//  chat
//
//  Created by 高超 on 16/4/12.
//  Copyright © 2016年 Dong. All rights reserved.
//
#import<CoreText/CoreText.h>
#import "UIViewController+StorageMethods.h"
#import "PRompt.h"
//#import "RegisteredViewController.h"
//#import "LoginViewTwoViewController.h"
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]//阴影效果要用
@implementation UIViewController (StorageMethods)

#pragma mark - 消息本地本地存储方法
/**
 *  存储ChatSquare的数据Key数组
 */
-(void)ChatSquareCollecTionDataStorage:(NSMutableArray *)array
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [userDefaults setObject:data forKey:k_ChatSquareKeyArr];
    [userDefaults synchronize];
    
}
/**
 *  读取ChatSquare的数据Key数组
 */
-(NSMutableArray *)ChatSquareTableDataLocalRead
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:k_messageList];
   
    return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
}




/**
 *  消息本地数据储存
 */
-(void)messageLocalStorage:(NoticeModel *)model
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [userDefaults setObject:data forKey:k_messageList];
     [userDefaults synchronize];//调用synchronize方法强制写入
}

/**
 *  消息本地数据读取
 */
-(NoticeModel *)messageLocalRead
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:k_messageList];
    NoticeModel *  model = (NoticeModel *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
    
}

/**
 *  消息本地数据储存
 */
-(void)messageLocalStorageApply:(NoticeModel *)model
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [userDefaults setObject:data forKey:k_messageListApply];
//    [userDefaults synchronize];//调用synchronize方法强制写入
}

/**
 *  消息本地数据读取
 */
-(NoticeModel *)messageLocalReadApply
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:k_messageListApply];
 
      NoticeModel * model = (NoticeModel *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
    
}


/**
 *  删除本地数据对应得Key
 */
-(void)RemoveForKey:(NSString *)key
{
      NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    
}




/**
 *  个人好友列表储存   转换为FriendListModel数组集
 */
-(void)myFriendListLocalStorage:(NSMutableArray *)array
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [userDefaults setObject:data forKey:k_friends];
}

/**
 *  个人好友列表读取   读取Model数组返回
 */
-(NSMutableArray *)myFriendListLocalRead
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:k_friends];
    NSMutableArray * array = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return array;
}

/**
 当好友修改了 签名 头像 名称  透传过来走此方法找出好友列表里对应的好友进行替换信息  并刷新好友列表
 */
-(void)changeFrientSignature:(NSDictionary *)dic type:(changeFriendData)type
{
    NSMutableArray * array = [self myFriendListLocalRead];
    NSString * easeName  = [dic objectForKey:@"ease_uname"];
    for (int i = 0; i < array.count; i++ ) {
        
        FriendListModel * model  = array[i];
      
        if ([model.m_easeUname isEqualToString:easeName]) {
         
            if (type == signature) {//好友修改签名
                
                 model.m_signature  = [dic objectForKey:@"signature"];
                
            }else if (type == Avatar){//好友修改头像
                
                 model.m_avatar  = [dic objectForKey:@"avatar"];
                
            }else if (type == nickName){//好友修改名称
                
                model.m_nickname = [dic objectForKey:@"nickname"];
                
            }
            
            [array replaceObjectAtIndex:i withObject:model];
            [self myFriendListLocalStorage:array];
            [[NSNotificationCenter defaultCenter]postNotificationName:K_REFRESH_FRIENDLIST object:nil];
            break;
        }
    }
}




/**
 *  移除好友   或者 有好友解除了和你关系
 *
 *  @param dic 数据包
 */
-(void)RemoveMyFriend:(NSDictionary *)dic
{
    NSMutableArray * array = [self myFriendListLocalRead];
    for (int i = 0 ; i < array.count; i ++) {
        FriendListModel * model = array[i];
        if ([model.m_easeUname  isEqualToString:[dic objectForKey:@"friend_ease_name"]]) {
            [array removeObjectAtIndex:i];
            [self myFriendListLocalStorage:array];
            break;
        }
    }
}

/**
 *  移除好友   或者 有好友解除了和你关系
 *
 *  @param dic 数据包
 */
-(void)RemoveMyFriendID:(NSString *)m_id
{
    NSMutableArray * array = [self myFriendListLocalRead];
    for (int i = 0 ; i < array.count; i ++) {
        FriendListModel * model = array[i];
        if ([model.m_fuid integerValue] == [m_id integerValue]) {
            [array removeObjectAtIndex:i];
            [self myFriendListLocalStorage:array];
            break;
        }
    }
}
/**
 *  获取当前时间到分
 *
 *  @return yyyy年MM月dd日HH小时mm分钟ss秒SSS毫秒
 */
-(NSString *)tellMeTime
{
    NSDate * senddate = [[XSDTimeCalibration share]getServerDate];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmm"];
    NSString * currentTime = [formatter stringFromDate:senddate];
    return currentTime;
}

/**
 *  获取当前时间到秒
 *
 *  @return yyyy年MM月dd日HH小时mm分钟ss秒SSS毫秒
 */
-(NSString *)tellMeTimeSS
{
    NSDate * senddate = [[XSDTimeCalibration share]getServerDate];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString * currentTime = [formatter stringFromDate:senddate];
    return currentTime;
}


-(NSString *)tellMeTimeSSNew
{
    NSDate * senddate = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString * currentTime = [formatter stringFromDate:senddate];
    return currentTime;
    
}

/**
 *  获取当前时间 格式yyyy-MM-dd HH:mm:ss
 */
-(NSString *)tellMeTimeTwo
{
    NSDate * senddate = [[XSDTimeCalibration share]getServerDate];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * currentTime = [formatter stringFromDate:senddate];
    return currentTime;
 
}
/**
 *  获取当前精确时间到SS
 *
 *  @return yyyy年MM月dd日HH小时mm分钟ss秒SSS毫秒
 */
-(NSString *)tellMeAccurateTime
{
    NSDate * senddate =[[XSDTimeCalibration share]getServerDate];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString * currentTime = [formatter stringFromDate:senddate];
    return currentTime;
}
/**
 *  获取用户Id
 *
 *  @return uid
 */
-(NSString *)giveMeUid
{
    //得到用户保存的uid和code
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uidStr=[accountDefaults objectForKey:UserDefaultNameKey];

    return uidStr;
    
}
/**
 *  获取用户EaseID
 *
 *  @return uid
 */
-(NSString *)giveMeEaseID
{
    RegisteredUser * model = [DPlistSave readUserData];
    
    return model.m_uname;
    
}
/**
 *  清空所以本地缓存
 */
-(void)clear
{
    [ShareAppDelegate.m_ActorsAuditio removeAllObjects];//清除角色扮演
    //如果有聊天室 则退出聊天室
    if ([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
    {
        [DTools DeleteCurrentPage];
    }
    [self storageMessageList:[self giveMeEaseID]];
    
     [self storageAllMessageNumber:@"0"];//本地储存全部消息
   
    [ShareAppDelegate.m_chatRoomDict removeAllObjects];//清除加入的聊天室信息
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
//退出时小米推送解绑
//    [MiPushSDK unsetAlias:[accountDefaults objectForKey:k_hxName]];
     [accountDefaults removeObjectForKey:k_groups];
    [accountDefaults removeObjectForKey:k_hxName];
    [accountDefaults removeObjectForKey:k_hxPasswd];
    [accountDefaults removeObjectForKey:UserDefaultNameKey];
    [accountDefaults removeObjectForKey:K_roomName];
   
    
    [accountDefaults removeObjectForKey:k_reqGroupList];
    [accountDefaults removeObjectForKey:k_reqFriendList];
  
    [accountDefaults removeObjectForKey:k_friends];
    [accountDefaults removeObjectForKey:k_messageList];
    [accountDefaults removeObjectForKey:k_messageListApply];
    [accountDefaults removeObjectForKey:k_set];
    [accountDefaults removeObjectForKey:k_setArray];
    [accountDefaults removeObjectForKey:k_WhetherPrompt];
    [accountDefaults removeObjectForKey:k_topicCreateDat];
    [accountDefaults removeObjectForKey:K_RoomHistory];//聊天室历史记录
    [accountDefaults removeObjectForKey:k_ClickTime];//清除点击时间
    [[ChatTime shareInstance]chatTimeEnd];
    //6.26 xiong
//    [[EMClient sharedClient] logout:NO];//关闭环信自动登陆
//    [EMClient sharedClient].options.isAutoLogin = NO;//设置自动登陆为NO
//    [MiPushSDK unregisterMiPush];
    [accountDefaults removeObjectForKey:K_dayFirstMessage];
//    [self removeAllMessage];//暂时先不删除所有聊天回话
//    [MiPushSDK getAllAliasAsync];
     [self removeAppDelegateData];
    [DPlistSave RemoveUserData];
     [[NSNotificationCenter defaultCenter]postNotificationName:k_changePhoto object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    [ShareAppDelegate login];
    
    
}

/**
 清除全局信息
 */
-(void)removeAppDelegateData
{
//    ShareAppDelegate.m_roomId = nil;
//    [ShareAppDelegate.m_chatRoomDict removeAllObjects];
//    ShareAppDelegate.isExistChatRoom = NO;
//    [ShareAppDelegate.m_ChatNumberPeople removeAllObjects];
//    [ShareAppDelegate.m_topDataArray removeAllObjects];
//    [ShareAppDelegate.m_messageAllArray removeAllObjects];
//    ShareAppDelegate.m_isMessageSynchronous = NO;
    
    
    
}

-(void)removeAllMessage
{
    //6.26 xiong
//    //删除环信会话
//    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
//    for (EMConversation *converstion in conversations) {
//        EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:converstion];
//        
//        if (model.conversation.type == EMConversationTypeChat || model.conversation.type == EMConversationTypeGroupChat) {
//            
//            [[EMClient sharedClient].chatManager deleteConversation:converstion.conversationId isDeleteMessages:YES completion:^(NSString *aConversationId, EMError *aError) {
//                
//            }];
//            
//        }
//        
//    }
    
    [self storageAllMessageNumber:@"0"];//本地储存全部消息
}
//#pragma mark - 环信登陆

//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password roomId:(NSString *)roomid
{
   //6.26 xiong
    //异步登陆账号
//    __weak typeof(self) weakself = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        EMError * error = [[EMClient sharedClient]loginWithUsername:username password:password];
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            //如果没有错误登陆
//            if (!error) {
//
//                //设置自动登录
//                [[EMClient sharedClient].options setIsAutoLogin:YES];
//
//                //获取数据库中的数据(异步)
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    // [[EMClient sharedClient]dataMigrationTo3];
//                    //数据获取成功后回到主线程赋值处理数据
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //数据处理更新UI
//                        
//                        //发送自动登陆状态通知
//        [[NSNotificationCenter defaultCenter]postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
////                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Chat" bundle:nil];
////                        [UIApplication sharedApplication].keyWindow.rootViewController = [storyboard instantiateInitialViewController];
//               
//                    });
//                });
//            }else{
//                [SVProgressHUD dismiss];
//                switch (error.code) {
//                        
//                    case EMErrorNetworkUnavailable:
//                        UtilAlert(@"提示", @"没有网络连接!");
//                        break;
//                    case EMErrorServerNotReachable:
//
//                        UtilAlert(@"提示", @"连接到服务器失败");
//                        break;
//                    case EMErrorUserAuthenticationFailed:
//
//                        UtilAlert(@"提示",error.errorDescription);
//                        break;
//                    case EMErrorServerTimeout:
//
//                        UtilAlert(@"提示",@"连接到服务器超时!");
//                        break;
//                    default:
//
//                        UtilAlert(@"提示",@"登录失败");
//                        break;
//                }
//            }
//        });
//    });
}




/**
 *  取位置信息
 *
 *  @return
 */
-(NSMutableDictionary *)TakePositionInfo
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
   NSData * data = [userDefaults objectForKey:k_location];
    NSMutableDictionary * dic =(NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
   
    if (dic == nil) {
        dic = [[NSMutableDictionary alloc]init];
    }
    return dic;
}
/**
 *  存储位置信息
 *
 *  @param dic
 */
-(void)storagePositionInfo:(NSMutableDictionary *)dic
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver  archivedDataWithRootObject:dic];
    [userDefaults setObject:data forKey:k_location];
    [userDefaults synchronize];//调用synchronize方法强制写入
}
/**
 *  取位置信息UID
 *
 *  @return
 */
-(NSString *)TakePositionUID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * str = [userDefaults objectForKey:k_locationUID];
    return str;
    
}
/**
 *  存储位置信息UID
 *
 *  @param dic
 */
-(void)storagePositionUID:(NSString *)str
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:str forKey:k_locationUID];
    [userDefaults synchronize];//调用synchronize方法强制写入
    
}
/**
 *  储存各个附近地点数组
 *
 *  @param array 数组
 *  @param type  类型
 */
-(void)storagePosittionArray:(NSMutableArray *)array type:(LocationType)type
{
     NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (type == LocationFJ) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
        [userDefaults setObject:data forKey:@"fujin"];
    }else if (type == LocationXQ){
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
        [userDefaults setObject:data forKey:@"xiaoqu"];
    }else if (type == LocationSC){
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
        [userDefaults setObject:data forKey:@"shangchang"];
    }else if (type == LocationXX){
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
        [userDefaults setObject:data forKey:@"xuexiao"];
    }
      [userDefaults synchronize];//调用synchronize方法强制写入
    
}
/**
 *  获取各个附近地点数组
 *
 *  @param type 类型
 *
 *  @return
 */
-(NSMutableArray *)TakePosittionArrayType:(LocationType)type
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if (type == LocationFJ) {
        
   NSData * data = [userDefaults objectForKey:@"fujin"];
NSMutableArray * array = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
        return array;
    }else if (type == LocationXQ){
        
    NSData * data =[userDefaults objectForKey:@"xiaoqu"];
NSMutableArray * array = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
        return array;
    }else if (type == LocationSC){
        
      NSData * data = [userDefaults objectForKey:@"shangchang"];
NSMutableArray * array = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
        return array;
    }else if (type == LocationXX){
        
      NSData * data = [userDefaults objectForKey:@"xuexiao"];
    NSMutableArray * array = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
        return array;
    }
    return nil;
}
/**
 *  读取消息数
 *
 *  @return
 */
-(NSString *)TakeAllMessageNumber
{
    
     NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults objectForKey:k_messageNumber];
}
/**
 *  本地储存消息数
 *
 *  @param number
 */
-(void)storageAllMessageNumber:(NSString *)number
{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
   [userDefaults setObject:number forKey:k_messageNumber];
//   [userDefaults synchronize];//调用synchronize方法强制写入
}
/**
 *  删除本地储存的地点数组 和 地点选择的数据
 */
-(void)deletePosittion
{
     NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:k_location];
    [userDefaults removeObjectForKey:k_locationUID];
    [userDefaults removeObjectForKey:@"fujin"];
    [userDefaults removeObjectForKey:@"xiaoqu"];
    [userDefaults removeObjectForKey:@"shangchang"];
    [userDefaults removeObjectForKey:@"xuexiao"];
   
    
    [userDefaults synchronize];//调用synchronize方法强制写入
    
}
/**
 *  给Lable添加阴影效果
 *
 *  @param label label
 */
-(void)AddShadowEffectLable:(UILabel *)label
{
    label.shadowColor = HEXCOLOR(0x999999);//增加阴影
    label.shadowOffset = CGSizeMake(0.5, 0.5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3)
}
/**
 *  给群组Lable添加阴影效果
 *
 *  @param label label
 */
-(void)AddShadowEffectLableGroup:(UILabel *)label
{
    label.shadowColor = [UIColor whiteColor];//增加阴影
    label.shadowOffset = CGSizeMake(0.5, 0.5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3)

}
/**
 *  调整字体行间距
 *
 *  @param label
 */
-(void)AddSpacingLabel:(UILabel *)label
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:6];//调整行间距

 [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
//    long stringCharacterSpacing = 1.0f;//字间距
//    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&stringCharacterSpacing);
//    [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, [attributedString length])];
    label.attributedText = attributedString;
    
    [label sizeToFit];
    
}

-(void)pushChatRoomController
{
    if ([ShareAppDelegate.m_chatRoomDict objectForKey:K_CHAT_ROOM_KEY])
    {
        
        [DTools DeleteCurrentPage];
    }
       ChatViewController  *chatViewController = [[ChatViewController alloc] init];
    [ShareAppDelegate.m_chatRoomDict setObject:chatViewController forKey:K_CHAT_ROOM_KEY];
    [self.navigationController pushViewController:chatViewController animated:NO];
}


/**
 *  判断用户等级操作
 */
-(UserOperation *)DetermineTheUserLevelOperationType:(UserOperationType)type
{
    int  createGroups = 0;
    int  addGroups = 0;
    /**
     返回的判断model
     */
    UserOperation * Usermdoel = [[UserOperation alloc]init];
    /**
     *  用户数据
     */
    RegisteredUser *regist= [DPlistSave readUserData];
    /**
     *  规则Model
     */
    UserPermissionsModel * model = [ShareAppDelegate.m_integralRules objectForKey:regist.m_levels];
    

   
        //私聊判断
     if (type == directMessages){
        
        if ([model.m_canSingleChat integerValue] != 1) {
            
            Usermdoel.m_level = YES;
            return Usermdoel;
            
        }else{
            
            return Usermdoel;
            
        }
        
    }else if(type == addFriend){
        if ([model.m_addFriends integerValue] != 1) {
            
            Usermdoel.m_level = YES;
            return Usermdoel;
            
        }else{
            
            return Usermdoel;
            
        }
        
    }else{
        
        return Usermdoel;
        
    }
    
    
}

/**
 判断条件并弹出提示框
 */
-(BOOL)promptMessageOperationType:(UserOperationType)type
{
    UserOperation * userModel = [self DetermineTheUserLevelOperationType:type];
    NSString * str;
    BOOL beging = YES;
    //判断等级积分
    if (userModel.m_level ) {
        beging = NO;
        
        if(type == directMessages){
            str = @"1级用户才可以私信他人，请不要着急。";
        }else if(type == addFriend){
            
            str = @"1级用户才可以加好友，请不要着急。";
            
        }
        //等级不足
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
        //上面控制提示框的内容和标题
        //下面控制提示框的按钮动作
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        //将内容标题加上动作 cancel
        [alert addAction:cancel];
        //然后在视图上显示提示框
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else if (userModel.m_integral){
       
        
        
    }
   
    return beging;
}


/**
 *  储存标签
 */
-(void)storageLable:(NSString *)label
{
    //取出标签
    NSMutableArray * array = [self takeTheLableArray];
    
    if (![array containsObject:label]) {
        
        if (array.count == 3) {
            [array removeLastObject];
        }
        
           [array insertObject:label atIndex:0];
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:array];
            [userDefaults setObject:data forKey:K_CHATROOMLABEL];
        
    }
}
/**
 *  取出标签
 */
-(NSMutableArray *)takeTheLableArray
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:K_CHATROOMLABEL];
    NSMutableArray * array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (!array) {
        
        array = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return array;
}

/**
 计算聊天室里面剩余时间
 */
- (NSString *)ChatFormateDate:(NSString *)dateString
{
   
    //// 再然后，把间隔的秒数折算成天数和小时数：
    int time  = [dateString intValue];
    NSString *dateStr = @"";
    
     if(time<=60*60){  ////  一个小时以内的
        
        int mins = time/60;
        dateStr = [NSString stringWithFormat:@"%d分钟",mins];
        
     }else{
         
         int hos = time/3600;
         int mins =  (time/60)%60;
          dateStr = [NSString stringWithFormat:@"%d小时%d分钟",hos,mins];
     }
    return dateStr;
}

/**
 /////  和当前时间比较
 ////   1）1分钟以内 显示        :    刚刚
 ////   2）1小时以内 显示        :    X分钟前
 ///    3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 ///    4) 今年显示              :   09月12日
 ///    5) 大于本年      显示    :    2013/09/09
 **/

- (NSString *)formateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    if ([DTools isStringEmpty:dateString])
      return @"";
    if ([DTools isStringEmpty:formate])
        return @"";

//        //实例化一个NSDateFormatter对象
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:formate];
//        

//        
//        /////  将需要转换的时间转换成 NSDate 对象
//        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
//        /////  取当前时间和转换时间两个日期对象的时间间隔
//        /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
//    NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
// 这里时间传进来NSString格式一定要是下面这种格式 而且两个要一样  下面这个格式可以自己更改  但是必须传进来就这中格式都一样
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
//告诉了电脑我对比的格式是这样的以后  下面创建2个Data去把NSString类型转换成Data类型
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [dateFormatter dateFromString:dateString];
    dt2 = [dateFormatter dateFromString:formate];
    //这里dt1是当前时间   dt2是消息时间 进行差值对比==22
    NSTimeInterval numberTime =[dt1 timeIntervalSinceDate:dt2];
   
    int  time = [[NSString stringWithFormat:@"%f",numberTime]intValue];
        //// 再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = @"";
        
        if (time<=60) {  //// 1分钟以内的
            dateStr = @"刚刚";
        }else if(time<=60*60){  ////  一个小时以内的
            
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
        }else if(time<=60*60*24){   //// 在一天内的
            
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];

            
            [dateFormatter setDateFormat:@"HH:mm"];
       
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:dt2]];
    
        }else if(time>60*60*24 && time<=60*60*48){
            
            //  昨天
                dateStr = @"昨天";

        }else{

            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:dt1];
            NSString *nowYear = [dateFormatter stringFromDate:dt2];
            
            if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [dateFormatter setDateFormat:@"MM-dd"];
                dateStr = [dateFormatter stringFromDate:dt2];
            }else{
                [dateFormatter setDateFormat:@"MM-dd"];
                dateStr = [dateFormatter stringFromDate:dt2];
            }
        }
        
        return dateStr;
    }

/**
 /////  和当前时间比较
 ////   1）1分钟以内 显示        :    刚刚
 ////   2）1小时以内 显示        :    X分钟前
 ///    3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 ///    4) 今年显示              :   09月12日
 ///    5) 大于本年      显示    :    2013/09/09
 **/
//计算新闻广场 新闻时间
- (NSString *)ChatSquareFormateDate:(NSString *)dateString withFormate:(NSString *) formate
{
    
    if ([DTools isStringEmpty:dateString])
        return @"";
    if ([DTools isStringEmpty:formate])
        return @"";
    
    //        //实例化一个NSDateFormatter对象
    //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //        [dateFormatter setDateFormat:formate];
    //
    
    //
    //        /////  将需要转换的时间转换成 NSDate 对象
    //        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
    //        /////  取当前时间和转换时间两个日期对象的时间间隔
    //        /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
    //    NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 这里时间传进来NSString格式一定要是下面这种格式 而且两个要一样  下面这个格式可以自己更改  但是必须传进来就这中格式都一样
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //告诉了电脑我对比的格式是这样的以后  下面创建2个Data去把NSString类型转换成Data类型
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [dateFormatter dateFromString:dateString];
    dt2 = [dateFormatter dateFromString:formate];
    
    
    
    //这里dt1是当前时间   dt2是消息时间 进行差值对比==22
    //计算两个日期相差几天
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
  
    
    //去掉时分秒信息   这里判断时间对比天数  要把时分秒去掉  日期相同就是同一天   日期差一天就是差一天，与是否满24小时无关
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:dt2];
     [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:dt1];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:fromDate  toDate:toDate  options:0];
    NSInteger time = [comps day];
    
    
    NSString *dateStr = @"";
    [dateFormatter setDateFormat:@"dd"];
//    //现在的时间 天
//    NSString * timeNew = [dateFormatter stringFromDate:dt1];
//    //新闻时间  天
//    NSString * timeN    = [dateFormatter stringFromDate:dt2];
    [dateFormatter setDateFormat:@"HH"];
    //现在的时间 H
    NSString * timeNewH = [dateFormatter stringFromDate:dt1];
    //新闻时间 H
    NSString * timeNH    = [dateFormatter stringFromDate:dt2];
    

if (time == 0 && ([timeNH intValue]+1) <= 24){ // 一天之内
   
    
        if ([timeNewH intValue] > ([timeNH intValue]+1)) {
            
        //新闻的小时
            dateStr = [NSString  stringWithFormat:@"%d:00",([timeNH intValue]+1)];
            
            }else{
            
            //现在的小时
            dateStr = [NSString stringWithFormat:@"%@:00",timeNewH];
            
            
        }

}else if(time == 1 || ([timeNH intValue]+1) == 24){
            //  昨天
            dateStr = @"昨天";
            
             
}else if(time  == 2){
    
             
             dateStr = @"前天";
             
             
}else{
            
             
             dateStr = @"更早";
}
    
    return dateStr;
}
/**
 *  单个好友写入 用于跳界面
 */
-(void)writefriendAlone:(FriendListModel *)model
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [userDefaults setObject:data forKey:k_friendAlone];
    [userDefaults synchronize];//调用synchronize方法强制写入
}
/**
 *  单个好友读取 用于跳界面
 */
-(FriendListModel *)readfriendAlone
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [userDefaults objectForKey:k_friendAlone];
    FriendListModel * model =(FriendListModel *) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
    return model;
}


//判断内容是否全部为空格  yes 全部为空格  no 不是
- (BOOL) isEmpty:(NSString *) str
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
-(BOOL) isHaveEmpty:(NSString *)str
{
  
    NSRange _range = [str rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return YES;
    }else {
        return NO;
    }
    
    
}


//消息列表保存
-(void)storageMessageList:(NSString *)easeID
{
    NSMutableDictionary * messageList  =[[NSMutableDictionary alloc]init];
    NSData * messageListData = [NSKeyedArchiver archivedDataWithRootObject:[self messageLocalRead]];//吧系统消息装换为 Data
    [messageList setObject:messageListData forKey:k_messageList];//系统消息
    NSData * messageListApply = [NSKeyedArchiver archivedDataWithRootObject:[self messageLocalReadApply]];
    [messageList setObject:messageListApply forKey:k_messageListApply];//申请消息
    NSData * setData = [NSKeyedArchiver archivedDataWithRootObject:[PRompt promptReadStorage]];
    [messageList setObject:setData forKey:k_set];//消息提示设置
    //用户所有消息的总DATA
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:messageList];
    
    //本地储存  先取出之前的包
     NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    //吧用户数据打成一个包  读取总的用户数据包   用用户EaseID 做KEY 储存
    NSMutableDictionary * dic = [NSKeyedUnarchiver unarchiveObjectWithData: [userDefaults objectForKey:K_UserMessageAndSet]];
    if (!dic) {
        dic = [[NSMutableDictionary alloc]init];
    }
    [dic setObject:data forKey:easeID];
    //再将其打成Data存入 K_UserMessageAndSet
    NSData * Adata = [NSKeyedArchiver archivedDataWithRootObject:dic];
    [userDefaults setObject:Adata forKey:K_UserMessageAndSet];
}

//读取消息列表
-(void)readMessageList:(NSString *)easeID
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    //取出总的用户数据列表字典
    NSMutableDictionary * dic =  [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:K_UserMessageAndSet]];
    //用用户的EaseID当key 取出对应的详细 消息信息
    NSMutableDictionary * messageList = [NSKeyedUnarchiver unarchiveObjectWithData:[dic objectForKey:easeID]];
 
    if (messageList) {
        
    [self messageLocalStorage:[NSKeyedUnarchiver unarchiveObjectWithData:[messageList objectForKey:k_messageList]]];//存储系统消息
    [self messageLocalStorageApply:[NSKeyedUnarchiver unarchiveObjectWithData:[messageList objectForKey:k_messageListApply]]];//存储申请消息
    [PRompt promptStorageSetState:[NSKeyedUnarchiver unarchiveObjectWithData:[messageList objectForKey:k_set]]];//存储消息提醒设置
    [DTools refreshUnreadMessage];
        
    }
}

//删除所有用户储存的  用户系统消息 和 申请消息 和 消息提示设置
-(void)removeUserMessageandSet
{
     NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:K_UserMessageAndSet];
    
}

//存储房间K_roomName
-(void)strongRoomName:(NSString *)str
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:str];
    [userDefaults setObject:data forKey:K_roomName];
}
//读取房间K_roomName
-(NSString *)readRoomName
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
  
    //判断类型
    if ([[userDefaults objectForKey:K_roomName] isKindOfClass:[NSData class]])
    {
        NSData * data = [userDefaults objectForKey:K_roomName];
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
    }else{
        
        return [userDefaults objectForKey:K_roomName];
    }

}


/**
 输入限制计算方法
 
 @param label 输入的TextField
 @param number 输入个数显示Label
 @param limit 规则 输入几个字符的字
 */
-(NSInteger)stringConvertTo:(UITextField *)textField numberLabel:(UILabel *)number limitNuber:(NSInteger)limit
{
    
    NSString *toBeString = textField.text;
    float len = 0;//字节数
    int index = 0;//字符串length
    int normalIndex = 0;
    float normalLen = 0;
    for (int i=0; i<toBeString.length; i++) {//for循环字符串Lenth
        
        int asi = [toBeString characterAtIndex:i];//通过获取的某个length上的字符获取ASCll码
        BOOL isSpecial = NO;
        if(asi >= 0x4E00 && asi <=0x9FFF){
            len++;
        }else if(asi > 0 && asi < 127){//ASCll 0-127 非汉字
            
            if(asi >= 65 && asi <= 90){//ASCll 65 - 90 大写
                
                len++;//大写算一个字符
                
            }else{//ASCll 其他的就小写
                
                len += 0.5;//小写算半个字符
                
            }
            
        }else{//ASCll 超出127  就是特殊符号和汉字
            isSpecial = YES;
            len++;//汉字符号也算一个
            
        }
        
        if(len >= limit )
        {//如果大于或者等于限制字符
            if(len == (limit +0.5))
            {//有可能会出现字符大于0.5的
                
                index = i;//这里取得index是不包括index那一位的 所以不用加1
                
            }else{
                
                index = i+ 1;//这里加一是因为要取到index那一位
                
            }
            
            if(isSpecial && len >= limit && normalLen > limit-2){
                index = normalIndex+1;
                len = normalLen;
            
            }
            textField.text = [toBeString substringToIndex:index];
            break;
        }
        if(!isSpecial){
            normalIndex = i;
            normalLen = len;
        }
        
        
    }//for循环
    
    
    NSInteger endNumber = lround(len);//四舍五入取整
    if (endNumber > limit)
    {
        endNumber = limit;
    }
    number.text = [NSString stringWithFormat:@"%ld/%ld",endNumber,limit];
    return endNumber;
}

/**
 输入限制计算方法
 
 @param label 输入的TextField
 @param number 输入个数显示Label
 @param limit 规则 输入几个字符的字
 */
-(NSInteger)stringConvertToView:(UITextView *)textView numberLabel:(UILabel *)number limitNuber:(NSInteger)limit
{
    NSString *toBeString = textView.text;
    float len = 0;//字节数
    int index = 0;//字符串length
    int normalIndex = 0;
    float normalLen = 0;
    for (int i=0; i<toBeString.length; i++) {//for循环字符串Lenth
        
        int asi = [toBeString characterAtIndex:i];//通过获取的某个length上的字符获取ASCll码
          BOOL isSpecial = NO;
        if(asi >= 0x4E00 && asi <=0x9FFF){
            len++;
        }else if(asi > 0 && asi < 127){//ASCll 0-127 非汉字
            
            if(asi >= 65 && asi <=  90){//ASCll 65 - 90 大写
                
                len++;//大写算一个字符
                
            }else{//ASCll 其他的就小写
                
                len += 0.5;//小写算半个字符
                
            }
            
        }else{//ASCll 超出127  就是特殊符号和汉字
            isSpecial = YES;
            len++;//汉字符号也算一个
            
        }
        
        if(len >= limit )
        {//如果大于或者等于限制字符
            
            if(len == (limit +0.5))
            {//有可能会出现字符大于0.5的
                
                index = i;//这里取得index是不包括index那一位的 所以不用加1
                
            }else{
                
                index = i+ 1;//这里加一是因为要取到index那一位
                
            }
            if(isSpecial && len >= limit && normalLen > limit-2){
                index = normalIndex+1;
                len = normalLen;
                
            }

            textView.text = [toBeString substringToIndex:index];
            break;
        }
            if(!isSpecial){
                normalIndex = i;
                normalLen = len;
            }
    }//for循环
    
    
    NSInteger endNumber = lround(len);//四舍五入取整
    if (endNumber > limit)
    {
        endNumber = limit;
    }
    number.text = [NSString stringWithFormat:@"%ld/%ld",endNumber,limit];
    //    NSLog(@"#### %@ ######", [toBeString substringToIndex:index]);
    return endNumber;
    
}

/**
 计算字符串多少字节
 */
-(NSInteger)stringConvertTo:(NSString *)toBeString
{
    float len = 0;//字节数
//    int index = 0;//字符串length
    for (int i=0; i<toBeString.length; i++) {//for循环字符串Lenth
        
        int asi = [toBeString characterAtIndex:i];//通过获取的某个length上的字符获取ASCll码
        if(asi >= 0x4E00 && asi <=0x9FFF){
            len++;
        }else if(asi > 0 && asi < 127){//ASCll 0-127 非汉字
            
            if(asi >= 65 && asi <= 90){//ASCll 65 - 90 大写
                
                len++;//大写算一个字符
                
            }else{//ASCll 其他的就小写
                
                len += 0.5;//小写算半个字符
                
            }
            
        }else{//ASCll 超出127  就是特殊符号和汉字
            
            len++;//汉字符号也算一个
            
        }
    
    }
    return lround(len);
}

/**
 用户第三方登陆名称注册时用的
 */
-(void)stringConvertToUserName:(UITextField *)textField  limitNuber:(NSInteger)limit
{
  NSString *toBeString = textField.text;
    float len = 0;//字节数
        int index = 0;//字符串length
    for (int i=0; i<toBeString.length; i++) {//for循环字符串Lenth
        
        int asi = [toBeString characterAtIndex:i];//通过获取的某个length上的字符获取ASCll码
        
        if(asi > 0 && asi < 127){//ASCll 0-127 非汉字
            
            if(asi >= 65 && asi <= 90){//ASCll 65 - 90 大写
                
                len++;//大写算一个字符
                
            }else{//ASCll 其他的就小写
                
                len += 0.5;//小写算半个字符
                
            }
            
        }else{//ASCll 超出127  就是特殊符号和汉字
            
            len++;//汉字符号也算一个
            
        }
        if(len >= limit )
        {//如果大于或者等于限制字符
            
            if(len == (limit +0.5))
            {//有可能会出现字符大于0.5的
                
                index = i;//这里取得index是不包括index那一位的 所以不用加1
                
            }else{
                
                index = i+ 1;//这里加一是因为要取到index那一位
                
            }
            textField.text = [toBeString substringToIndex:index];
            break;
        }

    }
   
}
/**
 判断是否登陆并是否跳转登录
 */
-(BOOL)isLoginPush:(BOOL)bo pushLodingViewL:(UIViewController*)vc
{
     //6.26 xiong
//    RegisteredUser * userModel = [DPlistSave readUserData];
//    //6.26 xiong
//    //这里加一个环信自动登录判断  如果环信都没有登录 那就不存在自动登录了
////    if ([EMClient sharedClient].options.isAutoLogin && userModel != nil  && [userModel.m_id intValue]>0 && ![DTools isStringEmpty:userModel.m_uname]) {
////        
////        return YES;
////    }
//       //是否跳转视图
//    if (bo) {
//        if (vc == nil) {
//            
//            UIGraphicsBeginImageContext(self.view.window.bounds.size);
//            [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
//            UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
//            
//            UIGraphicsEndImageContext();
//        
//
//            //6.26 xiong
////        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
////        RegisteredViewController * registered = [storyboard instantiateViewControllerWithIdentifier:@"RegisteredViewController"];
////            registered.m_imageBackground = image;
////        registered.modalTransitionStyle=UIModalPresentationOverCurrentContext;
////        self.modalPresentationStyle = UIModalPresentationCurrentContext;
////        self.providesPresentationContextTransitionStyle = YES;
////        self.definesPresentationContext = YES;
////        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:registered];
////        [self.navigationController presentViewController:nvc animated:YES completion:nil];
//            
//            
//        }else{
//            
//            [self pushRegisteredView:vc];
//            
//        }
//    }
    
    return NO;
}
/**
 跳转登录页面
 */
-(void)pushLodingView:(UIViewController *)vc
{
    UIGraphicsBeginImageContext(self.view.window.bounds.size);
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

//6.26 xiong
//    if (vc == nil) {
//            UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//            LoginViewTwoViewController * login = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewTwoViewController"];
//            login.m_imageBackground = image;
//            [login setModalPresentationStyle:UIModalPresentationOverCurrentContext];
//            self.modalPresentationStyle = UIModalPresentationCurrentContext;
//            self.providesPresentationContextTransitionStyle = YES;
//        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:login];
//        [self.navigationController presentViewController:nvc animated:YES completion:nil];
//
//    }else{
//        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        LoginViewTwoViewController * login = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewTwoViewController"];
//        [login setModalPresentationStyle:UIModalPresentationOverCurrentContext];
//        vc.modalPresentationStyle = UIModalPresentationCurrentContext;
//        vc.providesPresentationContextTransitionStyle = YES;
//        login.m_imageBackground = image;
//        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:login];
//        [vc.navigationController presentViewController:nvc animated:YES completion:nil];
//        
//    }
    
}

/**
 跳转注册页面
 */
-(void)pushRegisteredView:(UIViewController *)vc
{
    
    UIGraphicsBeginImageContext(self.view.window.bounds.size);
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image= UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    if (vc == nil) {
       //6.26 xiong
//        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        RegisteredViewController * registered = [storyboard instantiateViewControllerWithIdentifier:@"RegisteredViewController"];
//        [registered setModalPresentationStyle:UIModalPresentationOverCurrentContext];
//        self.modalPresentationStyle = UIModalPresentationCurrentContext;
//        self.providesPresentationContextTransitionStyle = YES;
//        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:registered];
//        [self.navigationController presentViewController:nvc animated:YES completion:nil];
    }else{
        //6.26 xiong
//        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        RegisteredViewController * registered = [storyboard instantiateViewControllerWithIdentifier:@"RegisteredViewController"];
//        registered.m_imageBackground = image;
//
//        UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:registered];
//        
//        [vc.navigationController presentViewController:nvc animated:YES completion:nil];
    }
    
}
//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size image:(UIImage *)image
{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


@end
