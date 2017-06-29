//
//  TopicChatCollectionViewCell.h
//  chat
//
//  Created by 高超 on 16/8/17.
//  Copyright © 2016年 Dong. All rights reserved.
//
/**
 *  话题聊天室详细信息 （聊天室成员）
 */
#import <UIKit/UIKit.h>

@protocol TopicChatCollectionViewCellDelegate <NSObject>

-(void)TopicChatCollectionViewCellDelegateTouchUserPhoto:(NSInteger)tag;

@end
@interface TopicChatCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)id<TopicChatCollectionViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *m_userPhotoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *m_userPhotoImage;

@end
