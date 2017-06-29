//
//  UserOperation.h
//  chat
//
//  Created by 高超 on 16/9/6.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserOperation : NSObject
/**
 *  等级是否够
 */
@property(nonatomic,assign)BOOL m_level;
/**
 *  积分是否够
 */
@property(nonatomic,assign)BOOL m_integral;
/**
 *  加群是否达到上线
 */
@property(nonatomic,assign)BOOL m_ceiling;

@end
