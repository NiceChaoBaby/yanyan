//
//  MovieIntroduced.h
//  yanyan
//
//  Created by 高超 on 2017/6/27.
//  Copyright © 2017年 XSD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieIntroduced : NSObject

/**
 电影介绍
 */
@property(nonatomic,strong)NSString * m_MovieIntroduced;


/**
 是否打开了
 */
@property (nonatomic, assign) BOOL isOpening;


/**
 是否超过了4行文字高度
 */
@property (nonatomic, assign, assign) BOOL shouldShowMoreButton;

@end
