//
//  LookBigImageViewController.h
//  chat
//
//  Created by 高超 on 2017/2/27.
//  Copyright © 2017年 Dong. All rights reserved.
//
//看大图
#import <UIKit/UIKit.h>
typedef void  (^StopBlock)(BOOL isFirst,BOOL send);//是否是原图
@interface LookBigImageViewController : UIViewController
/**
 所有图片数组
 */
@property(nonatomic,strong)NSMutableArray * m_allImageArray;

/**
 选中数组
 */
@property(nonatomic,strong)NSMutableArray * m_stateImageArray;
@property(nonatomic,assign)NSInteger  number;
@property(nonatomic,copy)StopBlock block;
-(void)tellMeiSFirstPhoto:(BOOL)bo popViewtellMeFirst:(StopBlock)block;

@end
