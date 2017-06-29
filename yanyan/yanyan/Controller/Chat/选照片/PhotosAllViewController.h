//
//  CameraViewController.h
//  storm
//
//  Created by dong on 15/7/30.
//  Copyright (c) 2015年 dong. All rights reserved.
//
//相册界面
#import <UIKit/UIKit.h>

@interface PhotosAllViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *m_topNav;

@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionViews;


/**
 选中照片数组
 */
@property (nonatomic,strong)NSMutableArray * m_chooseArray;
@end
