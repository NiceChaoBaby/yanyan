//
//  ShutupModel.m
//  chat
//
//  Created by 高超 on 16/4/19.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "ShutupModel.h"

@implementation ShutupModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_easeId"      : @"ease_id",
             @"m_forbidStart" : @"forbid_start",
             @"m_memberName"  : @"member_name",
             @"m_memberUid"   : @"member_uid",
             @"m_roomAvatar"  : @"room_avatar",
             @"m_roomId"      : @"room_id",
             @"m_roomName"    : @"room_name",
             @"m_tipoffId"    : @"tipoff_id",
             @"m_toType"      : @"to_type",
             @"m_remainTime"  : @"remainTime",
             @"m_addTime"  : @"add_time"
             };
}

//读取本地时走这个方法model
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
          self.m_easeId      = [aDecoder decodeObjectForKey:@"m_easeId"];
          self.m_forbidStart = [aDecoder decodeObjectForKey:@"m_forbidStart"];
          self.m_memberName  = [aDecoder decodeObjectForKey:@"m_memberName"];
          self.m_memberUid   = [aDecoder decodeObjectForKey:@"m_memberUid"];
          self.m_roomAvatar  = [aDecoder decodeObjectForKey:@"m_roomAvatar"];
          self.m_roomId      = [aDecoder decodeObjectForKey:@"m_roomId"];
          self.m_roomName    = [aDecoder decodeObjectForKey:@"m_roomName"];
          self.m_tipoffId    = [aDecoder decodeObjectForKey:@"m_tipoffId"];
          self.m_toType      = [aDecoder decodeObjectForKey:@"m_toType"];
          self.m_toType      = [aDecoder decodeObjectForKey:@"m_remainTime"];
         self.m_addTime      = [aDecoder decodeObjectForKey:@"m_addTime"];
    }
    return self;
}


//本地存储时走这个方法存model
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.m_easeId forKey:@"m_easeId"];
    [aCoder encodeObject:self.m_forbidStart forKey:@"m_forbidStart"];
    [aCoder encodeObject:self.m_memberName forKey:@"m_memberName"];
    [aCoder encodeObject:self.m_memberUid forKey:@"m_memberUid"];
    [aCoder encodeObject:self.m_roomAvatar forKey:@"m_roomAvatar"];
    [aCoder encodeObject:self.m_roomId forKey:@"m_roomId"];
    [aCoder encodeObject:self.m_roomName forKey:@"m_roomName"];
    [aCoder encodeObject:self.m_tipoffId forKey:@"m_tipoffId"];
    [aCoder encodeObject:self.m_toType forKey:@"m_toType"];
    [aCoder encodeObject:self.m_toType forKey:@"m_remainTime"];
    [aCoder encodeObject:self.m_addTime forKey:@"m_addTime"];
}


@end
