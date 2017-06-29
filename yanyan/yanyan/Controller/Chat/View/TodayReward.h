//
//  TodayReward.h
//  chat
//
//  Created by 高超 on 2016/12/8.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "promptView.h"
@interface TodayReward : UIWindow

+(TodayReward *)shareInstance:(CGRect)frame;
-(void)tpdayRewardIntegral:(NSString *)str addNumber:(NSString *)number center:(CGPoint)center;
@end
