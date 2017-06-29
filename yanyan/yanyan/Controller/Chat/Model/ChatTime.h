//
//  ChatTime.h
//  chat
//
//  Created by dong on 16/5/5.
//  Copyright © 2016年 Dong. All rights reserved.
//
// 聊天时间
#import "DModel.h"

@interface ChatTime : DModel
@property(nonatomic,strong) NSTimer *m_timer;
@property(nonatomic,strong) UILabel *m_label;
+(ChatTime *)shareInstance;
-(void)chatTimeStart;
-(void)chatTimeEnd;
-(void)enterBackGround;
-(BOOL)enterForeground;
-(void)topChatRoomEnd;
@end
