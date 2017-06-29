//
//  TipoffModel.m
//  chat
//
//  Created by dong on 16/4/7.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "TipoffModel.h"

@implementation TipoffModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_Rid" : @"rid",
             @"m_groupID" : @"group_id",
             @"m_groupName" : @"group_name",
             @"m_memberUid" : @"member_uid",
             @"m_memberName" : @"member_name",
             @"m_fromUid" : @"from_uid",
             @"m_fromNmae" : @"from_name"
             };
}


//读取本地时走这个方法model
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.m_Rid        = [aDecoder decodeObjectForKey:@"m_Rid"];
        self.m_groupID    = [aDecoder decodeObjectForKey:@"m_groupID"];
        self.m_groupName  = [aDecoder decodeObjectForKey:@"m_groupName"];
        self.m_memberUid  = [aDecoder decodeObjectForKey:@"m_memberUid"];
        self.m_memberName = [aDecoder decodeObjectForKey:@"m_memberName"];
        self.m_fromUid    = [aDecoder decodeObjectForKey:@"m_fromUid"];
        self.m_fromNmae   = [aDecoder decodeObjectForKey:@"m_fromNmae"];
    }
    return self;
}


//本地存储时走这个方法存model
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.m_Rid forKey:@"m_Rid"];
    [aCoder encodeObject:self.m_groupID forKey:@"m_groupID"];
    [aCoder encodeObject:self.m_groupName forKey:@"m_groupName"];
    [aCoder encodeObject:self.m_memberUid forKey:@"m_memberUid"];
    [aCoder encodeObject:self.m_memberName forKey:@"m_memberName"];
    [aCoder encodeObject:self.m_fromUid forKey:@"m_fromUid"];
    [aCoder encodeObject:self.m_fromNmae forKey:@"m_fromNmae"];
}

@end
