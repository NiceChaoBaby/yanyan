//
//  RoleDataTableRoleNumberCell.h
//  chat
//
//  Created by 高超 on 2017/5/11.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoleDataTableRoleNumberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionView;
@property (nonatomic,strong)NSMutableArray * m_dataArray;

/**
 加载数据
 */
-(void)addData:(NSMutableArray *)array;
@end
