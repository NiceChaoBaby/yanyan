//
//  XSDPhotoViewController.h
//  chat
//
//  Created by 熊申东 on 2017/2/7.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSDPhotoViewController : UIViewController

/**
 所有图片数组
 */
@property(nonatomic,strong)NSMutableArray * m_allImageArray;

/**
 选中数组
 */
@property(nonatomic,strong)NSMutableArray * m_stateImageArray;

@property(nonatomic,assign)NSInteger  number;
@end
