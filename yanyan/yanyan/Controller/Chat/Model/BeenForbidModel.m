//
//  BeenForbidModel.m
//  chat
//
//  Created by dong on 16/4/7.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "BeenForbidModel.h"

@implementation BeenForbidModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_forbidStart" : @"forbid_start",
             @"m_groupId" : @"group_id",
             @"m_memberUid" : @"member_uid",
             @"m_groupNmae":@"group_name",
             @"m_easeGroupId":@"ease_group_id",
             @"m_rid":@"rid",
             @"m_groupAvatar":@"group_avatar",
             @"m_toType":@"to_type",
             @"m_memberName":@"member_name"
             };
}

//读取本地时走这个方法model
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        self.m_forbidStart = [aDecoder decodeObjectForKey:@"m_forbidStart"];
         self.m_groupId = [aDecoder decodeObjectForKey:@"m_groupId"];
         self.m_memberUid = [aDecoder decodeObjectForKey:@"m_memberUid"];
         self.m_groupNmae = [aDecoder decodeObjectForKey:@"m_groupNmae"];
         self.m_easeGroupId = [aDecoder decodeObjectForKey:@"m_easeGroupId"];
         self.m_rid = [aDecoder decodeObjectForKey:@"m_rid"];
         self.m_groupAvatar = [aDecoder decodeObjectForKey:@"m_groupAvatar"];
         self.m_toType = [aDecoder decodeObjectForKey:@"m_toType"];
         self.m_memberName = [aDecoder decodeObjectForKey:@"m_memberName"];
        
    }
    return self;
}


//本地存储时走这个方法存model
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.m_forbidStart forKey:@"m_forbidStart"];
      [aCoder encodeObject:self.m_groupId forKey:@"m_groupId"];
      [aCoder encodeObject:self.m_memberUid forKey:@"m_memberUid"];
      [aCoder encodeObject:self.m_groupNmae forKey:@"m_groupNmae"];
      [aCoder encodeObject:self.m_easeGroupId forKey:@"m_easeGroupId"];
      [aCoder encodeObject:self.m_rid forKey:@"m_rid"];
      [aCoder encodeObject:self.m_groupAvatar forKey:@"m_groupAvatar"];
      [aCoder encodeObject:self.m_toType forKey:@"m_toType"];
      [aCoder encodeObject:self.m_memberName forKey:@"m_memberName"];
}


@end
