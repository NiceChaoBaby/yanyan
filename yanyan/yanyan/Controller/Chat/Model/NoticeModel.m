//
//  NoticeModel.m
//  chat
//
//  Created by 高超 on 16/4/8.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "NoticeModel.h"

@implementation NoticeModel

-(id)init
{
    self=[super init];
    if (self)
    {
        self.m_dataArray=[[NSMutableArray alloc]initWithCapacity:0];
        self.m_uid=@"-1";
           }
    return self;
}

-(NSMutableArray *)m_dataArray
{
    if (!_m_dataArray) {
        _m_dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _m_dataArray;
}
//本地储存Model需要走的方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {

        self.m_dataArray = [aDecoder decodeObjectForKey:@"m_dataArray"];
        self.m_title     = [aDecoder decodeObjectForKey:@"m_title"];
        self.m_time      = [aDecoder decodeObjectForKey:@"m_time"];
        self.m_avatar    = [aDecoder decodeObjectForKey:@"m_avatar"];
        self.m_number    = [aDecoder decodeIntegerForKey:@"m_number"];
         self.m_content    = [aDecoder decodeObjectForKey:@"m_content"];
        self.m_chatType    = [aDecoder decodeObjectForKey:@"m_chatType"];
        self.m_conversationId = [aDecoder decodeObjectForKey:@"m_conversationId"];
        self.m_userName   = [aDecoder decodeObjectForKey:@"m_userName"];
        self.m_uid=[aDecoder decodeObjectForKey:@"m_uid"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.m_dataArray forKey:@"m_dataArray"];
    [aCoder encodeObject:self.m_title forKey:@"m_title"];
    [aCoder encodeObject:self.m_time forKey:@"m_time"];
    [aCoder encodeObject:self.m_avatar forKey:@"m_avatar"];
    [aCoder encodeInteger:self.m_number forKey:@"m_number"];
    [aCoder encodeObject:self.m_content forKey:@"m_content"];
    [aCoder encodeObject:self.m_chatType forKey:@"m_chatType"];
    [aCoder encodeObject:self.m_conversationId forKey:@"m_conversationId"];
    [aCoder encodeObject:self.m_userName forKey:@"m_userName"];
    [aCoder encodeObject:self.m_uid forKey:@"m_uid"];
}





@end
