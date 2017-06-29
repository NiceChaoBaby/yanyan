//
//  BlockModel.m
//  chat
//
//  Created by dong on 16/6/29.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "BlockModel.h"

@implementation BlockModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"m_blockUid" : @"block_uid",
           
             };
}
//读取本地时走这个方法model
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        self.m_blockUid     = [aDecoder decodeObjectForKey:@"m_blockUid"];
    }
    return self;
}
//本地存储时走这个方法存model
- (void)encodeWithCoder:(NSCoder *)aCoder
{
       [aCoder encodeObject:self.m_blockUid forKey:@"m_blockUid"];
    
}

@end
