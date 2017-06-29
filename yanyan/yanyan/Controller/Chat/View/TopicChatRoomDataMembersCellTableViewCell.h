//
//  TopicChatRoomDataMembersCellTableViewCell.h
//  chat
//
//  Created by 高超 on 16/8/26.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicChatCollectionViewCell.h"
#import "GroupMemberModel.h"
@protocol TopicChatRoomDataMembersCellTableViewCellDelegate <NSObject>

-(void)TopicChatRoomDataMembersCellTableViewCellDelegateTouchUserPhotoS:(NSString *)uid;

@end
@interface TopicChatRoomDataMembersCellTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,TopicChatCollectionViewCellDelegate>


@property(nonatomic,strong)id<TopicChatRoomDataMembersCellTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionView;
/**
 *  成员数组
 */
@property(nonatomic,strong)NSMutableArray * m_userDataArray;
/**
 *  感兴趣人数
 */
@property (weak, nonatomic) IBOutlet UILabel *m_numberPeople;
/**
 *  箭头
 */
@property (weak, nonatomic) IBOutlet UIImageView *m_btn;
/**
 *  箭头宽度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_btnW;
/**
 *  抬头文字
 */
@property (weak, nonatomic) IBOutlet UILabel *m_titleLabel;



/**
 头视图
 */
@property (weak, nonatomic) IBOutlet UIView *m_headView;

/**
 头视图高度
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *m_headViewH;
@end
