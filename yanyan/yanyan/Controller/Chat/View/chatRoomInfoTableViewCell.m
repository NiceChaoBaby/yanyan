//
//  chatRoomInfoTableViewCell.m
//  chat
//
//  Created by 高超 on 16/6/15.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "chatRoomInfoTableViewCell.h"
#import "ChatRoomInfoCollectionViewCell.h"
#import "chatRoomInfoModel.h"
#import "GroupMemberModel.h"
@implementation chatRoomInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(chatRoomInfoTableViewCell *)chatRoomTableViewCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSArray *)array
{
    //加载Xib
    static NSString * identifer1 = @"chatRoomInfoTableViewCell";
    UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
    
    [tableView registerNib:nib forCellReuseIdentifier:identifer1];
    
    chatRoomInfoTableViewCell * cell = (chatRoomInfoTableViewCell * )[tableView dequeueReusableCellWithIdentifier:identifer1 forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.m_dataArray = array;
    cell.m_titleLabel.text = [NSString  stringWithFormat:@"全部成员 (%ld人)",cell.m_dataArray.count];
    cell.m_collectionView.userInteractionEnabled = YES;
    [cell.m_collectionView reloadData];
    return cell;
}


#pragma mark - UIcollectionViewDelegate

//定义展示的UIcollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section
{
    
    if (self.m_dataArray.count >10) {
        return 10;
    }else{
    return self.m_dataArray.count;
    }
}

//定义展示的Section的个数

-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView

{
    
    return 1  ;
    
}

//每个UICollectionView展示的内容

-(UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath

{
    static NSString * identifer1 = @"ChatRoomInfoCollectionViewCell";
    UINib * nib = [UINib nibWithNibName:identifer1 bundle:nil];
    [collectionView
     registerNib:nib forCellWithReuseIdentifier:identifer1];
    
    ChatRoomInfoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer1 forIndexPath:indexPath];
    GroupMemberModel * model = self.m_dataArray[indexPath.row];
    
    [cell.m_imageView sd_setImageWithURL:[NSURL URLWithString:model.m_avatar] placeholderImage:ImageNamed(K_avaterPHImage)];
    [DTools setImageView:cell];
    return cell;
}

//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath

{
    
    if ([self.delegate respondsToSelector:@selector(chatRoomInfoTableViewCellDelegateDidSelect)]) {
        
        [self.delegate chatRoomInfoTableViewCellDelegateDidSelect];
    }
    
    
    DLog(@"hahaha");

}

//定义每个UICollectionView 的大小
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath
{
    
    CGFloat W = (LCDW - 52)/5;
    if (W > 50) {
        W = 50;
    }
    return CGSizeMake(W , W);
    
}
//定义每个UICollectionView 的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    return UIEdgeInsetsMake(0, 13, 15, 13);
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 13;
    
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
    
}



@end
