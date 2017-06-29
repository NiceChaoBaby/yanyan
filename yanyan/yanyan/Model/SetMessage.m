//
//  SetMessage.m
//  chat
//
//  Created by 高超 on 16/5/11.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "SetMessage.h"

@implementation SetMessage
//读取本地时走这个方法model
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.m_noHarass   = [aDecoder decodeObjectForKey:@"m_noHarass"];
        self.m_groupMessage   = [aDecoder decodeObjectForKey:@"m_groupMessage"];
        self.m_userMessage   = [aDecoder decodeObjectForKey:@"m_userMessage"];
        self.m_voicePrompt   = [aDecoder decodeObjectForKey:@"m_voicePrompt"];
        self.m_vibrationPrompt   = [aDecoder decodeObjectForKey:@"m_vibrationPrompt"];
        self.m_noHarass   = [aDecoder decodeObjectForKey:@"m_noHarass"];
        self.m_noticePrompt = [aDecoder decodeObjectForKey:@"m_noticePrompt"];
    }
    return self;
}

//本地存储时走这个方法存model
- (void)encodeWithCoder:(NSCoder *)aCoder
{
     [aCoder encodeObject:self.m_noHarass forKey:@"m_noHarass"];
     [aCoder encodeObject:self.m_groupMessage forKey:@"m_groupMessage"];
     [aCoder encodeObject:self.m_userMessage forKey:@"m_userMessage"];
     [aCoder encodeObject:self.m_voicePrompt forKey:@"m_voicePrompt"];
     [aCoder encodeObject:self.m_vibrationPrompt forKey:@"m_vibrationPrompt"];
     [aCoder encodeObject:self.m_noHarass forKey:@"m_noHarass"];
    [aCoder encodeObject:self.m_noticePrompt forKey:@"m_noticePrompt"];
}
@end
