//
//  PhotoCollectionViewCell.m
//  chat
//
//  Created by 熊申东 on 2017/2/6.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "CameraCollectionViewCell.h"

@implementation CameraCollectionViewCell

-(NSString *)refreshModel:(TZAssetModel*)model
{
    self.m_imageView.image=nil;
   
    [[TZImageManager manager] getPhotoWithAsset:model.asset photoWidth:self.width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
      
        self.m_imageView.image = photo;
  
    } progressHandler:nil networkAccessAllowed:NO];
    
   
    
     return  [[TZImageManager manager] getAssetIdentifier:model.asset];

    
    
    
}
- (IBAction)clickChoosePhoto:(id)sender
{
    //选中
    if ([self.delegate respondsToSelector:@selector(CameraCollectionViewDeleageteChoosePhoto:Chools:)]) {
        
    if (self.m_selectBtn.selected) {
       //取消选中
//            self.m_selectBtn.selected = NO;
            [self.delegate CameraCollectionViewDeleageteChoosePhoto:self.m_indexPath Chools:NO];
      
        
    }else{
        
        //选中
//            self.m_selectBtn.selected = YES;
            [self.delegate CameraCollectionViewDeleageteChoosePhoto:self.m_indexPath Chools:YES];
    }
    
    }
}



@end
