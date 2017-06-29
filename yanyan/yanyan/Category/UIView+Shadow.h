//
//  UIView+Shadow.h
//  storm
//
//  Created by dong on 15/7/14.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//设置view的边框阴影
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Shadow)

- (void) makeInsetShadow;
- (void) makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha;
- (void) makeInsetShadowWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions;

@end
