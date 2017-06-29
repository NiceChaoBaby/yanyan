//
//  NSDictionary+Safety.h
//  storm
//
//  Created by dong on 15/8/13.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safety)
- (id)safeObjectForKey:(NSString *)key;
-(void)safeSetObject:(id)m_id forKey:(NSString *) key;
@end
