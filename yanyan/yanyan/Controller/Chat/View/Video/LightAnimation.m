//
//  LightAnimation.m
//  自定义视频录制
//
//  Created by dong on 15/9/16.
//  Copyright (c) 2015年 高超. All rights reserved.
//

#import "LightAnimation.h"

@implementation LightAnimation
-(void)startAnimation
{
    self.alpha=1;//动画逐渐加速
    [UIView animateWithDuration:0.25 delay:0.7 options:UIViewAnimationOptionCurveEaseOut animations:^{
    
        self.alpha=0;
    } completion:^(BOOL finished) {
        
            [self startAnimation];
    }];
}
@end
