//
//  chatRoomInfoTableViewCell.h
//  chat
//
//  Created by 高超 on 16/6/15.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol chatRoomInfoTableViewCellDelegate <NSObject>
@required //必须实现的方法
-(void)chatRoomInfoTableViewCellDelegateDidSelect;

@end


@interface chatRoomInfoTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionView;
@property (nonatomic,strong)id<chatRoomInfoTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (nonatomic,strong)NSArray * m_dataArray;
+(chatRoomInfoTableViewCell *)chatRoomTableViewCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath dataArray:(NSArray *)array;
@end
