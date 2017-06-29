//
//  ChoosePhotosViewController.h
//  chat
//
//  Created by 高超 on 2017/2/22.
//  Copyright © 2017年 Dong. All rights reserved.
//

//#import "DRootViewController.h"
@protocol ChoosePhotosDelegate <NSObject>

//@required //必须实现的方法
-(void)ChoosePhotosDelegateSendingPictures:(NSMutableArray *)array;

@end
@interface ChoosePhotosViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *m_topNav;
@property (nonatomic,assign)id<ChoosePhotosDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionViews;


/**
 选中照片数组
 */
@property (nonatomic,strong)NSMutableArray * m_chooseArray;
@end
