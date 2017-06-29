//
//  TopicChatRoomDataMembersCellTableViewCell.m
//  chat
//
//  Created by 高超 on 16/8/26.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "TopicChatRoomDataMembersCellTableViewCell.h"

@implementation TopicChatRoomDataMembersCellTableViewCell
-(NSMutableArray *)m_userDataArray
{
    if (!_m_userDataArray) {
        _m_userDataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _m_userDataArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -- UICollectionView

//定义展示的UIcollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section
{
    
    
    return self.m_userDataArray.count;
}

//定义展示的Section的个数

-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView

{
    
    return 1  ;
    
}

//每个UICollectionView展示的内容

-( UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath

{
    collectionView.scrollEnabled = NO;//禁止CollectionView滚动
    collectionView.showsHorizontalScrollIndicator = NO;//隐藏横向滚动条
    static NSString * identifer = @"TopicChatCollectionViewCell";
    UINib * nib = [UINib nibWithNibName:identifer bundle:nil];
    [collectionView
     registerNib:nib forCellWithReuseIdentifier:identifer];
    
    TopicChatCollectionViewCell * cell = (TopicChatCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    GroupMemberModel * model = self.m_userDataArray[indexPath.row];
    DLog(@"%@",model.m_avatar);
    //首先得拿到照片的路径，也就是下边的string参数，转换为NSData型。
//    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.m_avatar]];
//  NSString *str =  [self contentTypeForImageData:imageData];
    
    //然后就是添加照片语句，记得使用imageWithData:方法，不是imageWithName:。
//    cell.m_userPhotoImage.image = [UIImage imageWithData:[NSData
//                                                          dataWithContentsOfURL:[NSURL URLWithString:model.m_avatar]]];;
    [cell.m_userPhotoImage sd_setImageWithURL:[NSURL URLWithString:model.m_avatar] placeholderImage:ImageNamed(K_avaterPHImage) options:SDWebImageAllowInvalidSSLCertificates];
    [DTools setImageView:cell];
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell;
}

//定义每个UICollectionView 的大小

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath

{

        return CGSizeMake(45 ,45);
}


//定义每个UICollectionView 的边距

-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
//    CGFloat W = (CGRectGetWidth(self.m_collectionView.frame) - (50 * self.m_userDataArray.count));
//    CGFloat B = CGRectGetWidth(self.m_collectionView.frame);
    if (self.m_userDataArray.count < 5) {
          return UIEdgeInsetsMake(0,5,0,5);
    }else{
          return UIEdgeInsetsMake(0,0,0,0);
    }
  
    
    
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
//     CGFloat W = (CGRectGetWidth(self.m_collectionView.frame) - 30) - (50 *self.m_userDataArray.count);
           return 10;


   
    
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
//     CGFloat W = (CGRectGetWidth(self.m_collectionView.frame) - 30) - (50 *self.m_userDataArray.count);
    if (self.m_userDataArray.count < 5) {
        return 5;
    }else{
        return 0;
    }
    
}
#pragma mark -- TopicChatCollectionViewCellDelegate

-(void)TopicChatCollectionViewCellDelegateTouchUserPhoto:(NSInteger)tag
{
//    if ([self.delegate respondsToSelector:@selector(TopicChatRoomDataMembersCellTableViewCellDelegateTouchUserPhotoS:)]) {
//     
//        GroupMemberModel * model = self.m_userDataArray[tag];
//        [self.delegate TopicChatRoomDataMembersCellTableViewCellDelegateTouchUserPhotoS:model.m_id];
//    }
//    
    
    
//    TopicChatDetails * model = self.m_userDataArray[tag];
    
    //    if ([model.m_id intValue] == -1) {
    //
    //        //邀请好友
    //        AddFriendsViewController *addfriend=[[AddFriendsViewController alloc] init];
    //        addfriend.m_gid= ShareAppDelegate.m_roomId;
    //        [self.navigationController pushViewController:addfriend animated:YES];
    //
    //        DLog(@"点了");
    //
    //    }else{
//    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Friends" bundle:nil];
//    LookUserViewController * lookuser = [storyboard instantiateViewControllerWithIdentifier:@"LookUserViewController"];
//    
//    lookuser.m_uid=model.m_id;
//    
//    [self.navigationController pushViewController:lookuser animated:YES];
    //    }
}
- (NSString *)contentTypeForImageData:(NSData *)data {
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpeg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
        case 0x52:
            
            if ([data length] < 12) {
                
                return nil;
                
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                
                return @"webp";
                
            }
    }
    return nil;
}
@end
