//
//  RoleDataTableRoleNumberCell.m
//  chat
//
//  Created by 高超 on 2017/5/11.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "RoleDataTableRoleNumberCell.h"
#import "RoleUserNameCollectionCell.h"
#import "RoleIntroduceInfo.h"
#import "CharacterIntroduced.h"
@implementation RoleDataTableRoleNumberCell

-(NSMutableArray *)m_dataArray
{
    if (!_m_dataArray) {
        _m_dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _m_dataArray;
    
}

-(void)addData:(NSMutableArray *)array
{
    
    [self.m_dataArray removeAllObjects];
    [self.m_dataArray addObjectsFromArray:array];
    
}


#pragma mark - UIcollectionViewDelegate

//定义展示的UIcollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section
{
    
    return self.m_dataArray.count;
//    return self.m_dataArray.count;
}

//定义展示的Section的个数

-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView

{
    
    return 1  ;
    
}

//每个UICollectionView展示的内容

-( UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath

{
      collectionView.showsHorizontalScrollIndicator = NO;//隐藏横向滚动条
    static NSString * identifer1 = @"RoleUserNameCollectionCell";
    UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
    [collectionView
     registerNib:nib forCellWithReuseIdentifier:identifer1];
    
    RoleUserNameCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer1 forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    RoleIntroduceInfo * model = self.m_dataArray[indexPath.row];
    cell.m_userName.text =model.m_rname;
    [cell.m_RoleUserImageView sd_setImageWithURL:[NSURL URLWithString:model.m_avatar] placeholderImage:ImageNamed(@"详情页和答案角色头像")];
    [DTools getCorner:cell.m_RoleUserImageView radius:10];
    return cell;
}

//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
     RoleIntroduceInfo * model = self.m_dataArray[indexPath.row];
    [[CharacterIntroduced shareInstance]addWaitingFigureView:model];
    
}

//定义每个UICollectionView 的大小

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath
{
    
      return CGSizeMake(70 , 105);
    
    
}


//定义每个UICollectionView 的边距

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    return UIEdgeInsetsMake(15, 15, 15, 15);
    
    
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
    
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
