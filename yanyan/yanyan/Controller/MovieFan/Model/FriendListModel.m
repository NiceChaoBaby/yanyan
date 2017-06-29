//
//  FriendListModel.m
//  chat
//
//  Created by dong on 16/3/23.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "FriendListModel.h"

@implementation FriendListModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_applyId" : @"apply_id",
             @"m_avatar" : @"avatar",
             @"m_birth" : @"birth",
             @"m_easeUname" : @"ease_uname",
             @"m_emotion" : @"emotion",
              @"m_fuid" : @"fuid",
              @"m_levels" : @"levels",
             @"m_gender" : @"gender",
             @"m_homeTown" : @"hometown",
             @"m_intrest" : @"intrest",
             @"m_nickname":@"nickname",
             @"m_signature":@"signature",
             @"m_lat":@"lat",
             @"m_lng":@"lng",
             @"m_source":@"source"
             };
}


//读取本地时走这个方法model
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.m_applyId   = [aDecoder decodeObjectForKey:@"m_applyId"];
        self.m_avatar    = [aDecoder decodeObjectForKey:@"m_avatar"];
        self.m_birth     = [aDecoder decodeObjectForKey:@"m_birth"];
        self.m_easeUname = [aDecoder decodeObjectForKey:@"m_easeUname"];
        self.m_emotion   = [aDecoder decodeObjectForKey:@"m_emotion"];
        self.m_fuid      = [aDecoder decodeObjectForKey:@"m_fuid"];
        self.m_levels    = [aDecoder decodeObjectForKey:@"m_levels"];
        self.m_gender    = [aDecoder decodeObjectForKey:@"m_gender"];
        self.m_homeTown  = [aDecoder decodeObjectForKey:@"m_homeTown"];
        self.m_intrest   = [aDecoder decodeObjectForKey:@"m_intrest"];
        self.m_nickname  = [aDecoder decodeObjectForKey:@"m_nickname"];
        self.m_signature = [aDecoder decodeObjectForKey:@"m_signature"];
        self.m_source = [aDecoder decodeObjectForKey:@"m_source"];
         self.m_lat = [aDecoder decodeObjectForKey:@"m_lat"];
         self.m_lng = [aDecoder decodeObjectForKey:@"m_lng"];
//           self.m_id = [aDecoder decodeObjectForKey:@"m_id"];
    }
    return self;
}
//本地存储时走这个方法存model
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.m_applyId forKey:@"m_applyId"];
    [aCoder encodeObject:self.m_avatar forKey:@"m_avatar"];
    [aCoder encodeObject:self.m_birth forKey:@"m_birth"];
    [aCoder encodeObject:self.m_easeUname forKey:@"m_easeUname"];
    [aCoder encodeObject:self.m_emotion forKey:@"m_emotion"];
    [aCoder encodeObject:self.m_fuid forKey:@"m_fuid"];
    [aCoder encodeObject:self.m_levels forKey:@"m_levels"];
    [aCoder encodeObject:self.m_gender forKey:@"m_gender"];
    [aCoder encodeObject:self.m_homeTown forKey:@"m_homeTown"];
    [aCoder encodeObject:self.m_intrest forKey:@"m_intrest"];
    [aCoder encodeObject:self.m_nickname forKey:@"m_nickname"];
    [aCoder encodeObject:self.m_signature forKey:@"m_signature"];
    [aCoder encodeObject:self.m_source forKey:@"m_source"];
      [aCoder encodeObject:self.m_lat forKey:@"m_lat"];
    [aCoder encodeObject:self.m_lng forKey:@"m_lng"];
//     [aCoder encodeObject:self.m_id forKey:@"m_id"];
}




@end
