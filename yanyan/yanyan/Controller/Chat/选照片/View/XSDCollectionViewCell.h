//
//  XSDCollectionViewCell.h
//  chat
//
//  Created by 熊申东 on 2017/2/7.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSDCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;
- (void)recoverSubviews;
@end
