//
//  BlickListModel.m
//  chat
//
//  Created by 高超 on 16/5/4.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "BlickListModel.h"

@implementation BlickListModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_avatar" : @"avatar",
             @"m_easeUname":@"ease_uname",
             @"m_id":@"id",
             @"m_nickName":@"nickname"
             };
}

//读取本地时走这个方法model
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.m_avatar   = [aDecoder decodeObjectForKey:@"m_avatar"];
        self.m_easeUname   = [aDecoder decodeObjectForKey:@"m_easeUname"];
        self.m_id   = [aDecoder decodeObjectForKey:@"m_id"];
        self.m_nickName   = [aDecoder decodeObjectForKey:@"m_nickName"];
    }
    return self;
}

//本地存储时走这个方法存model
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.m_avatar forKey:@"m_avatar"];
    [aCoder encodeObject:self.m_easeUname forKey:@"m_easeUname"];
    [aCoder encodeObject:self.m_id forKey:@"m_id"];
    [aCoder encodeObject:self.m_nickName forKey:@"m_nickName"];
}


@end
