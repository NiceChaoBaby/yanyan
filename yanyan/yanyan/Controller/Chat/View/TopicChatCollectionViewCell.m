//
//  TopicChatCollectionViewCell.m
//  chat
//
//  Created by 高超 on 16/8/17.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "TopicChatCollectionViewCell.h"

@implementation TopicChatCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clickTouchUserPhoto:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(TopicChatCollectionViewCellDelegateTouchUserPhoto:)]) {
        [self.delegate TopicChatCollectionViewCellDelegateTouchUserPhoto:self.tag];
    }
    
    
}

@end
