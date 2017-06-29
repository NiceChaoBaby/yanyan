//
//  PhotoCollectionViewCell.h
//  chat
//
//  Created by 熊申东 on 2017/2/6.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZAssetModel.h"
@protocol CameraCollectionViewDeleagete <NSObject>

-(void)CameraCollectionViewDeleageteChoosePhoto:(NSIndexPath *)indexPath  Chools:(BOOL)chools;


@end
@interface CameraCollectionViewCell : UICollectionViewCell
@property(nonatomic,assign)id<CameraCollectionViewDeleagete>delegate;
@property (weak, nonatomic) IBOutlet UIButton *m_selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;
@property (nonatomic,strong)NSIndexPath * m_indexPath;
-(NSString *)refreshModel:(TZAssetModel*)model;
@end
