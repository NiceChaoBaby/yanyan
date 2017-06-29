//
//  XSDCollectionViewCell.m
//  chat
//
//  Created by 熊申东 on 2017/2/7.
//  Copyright © 2017年 Dong. All rights reserved.
//

#import "XSDCollectionViewCell.h"

@implementation XSDCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.m_scrollView.backgroundColor = RGBACOLOR(30, 32, 36, 1);
    self.m_scrollView.minimumZoomScale =1.0;
    self.m_scrollView.maximumZoomScale =2.0;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.m_imageView;
}

//- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
////    if (!scrollView.zooming) {
////        self.enablePanGesture = scrollView.zoomScale <= 1.0;
////    }
//    // Reset ImageView Center
//    CGSize contentSize = self.m_scrollView.contentSize;
//    CGFloat offsetX = (CGRectGetWidth(self.m_scrollView.frame) > contentSize.width) ? (CGRectGetWidth(self.m_scrollView.frame) - contentSize.width) / 2.0 : 0.0;
//    CGFloat offsetY = (CGRectGetHeight(self.m_scrollView.frame) > contentSize.height) ? (CGRectGetHeight(self.m_scrollView.frame) - contentSize.height) / 2.0 : 0.0;
//    self.m_imageView.center = CGPointMake(self.m_scrollView.contentSize.width / 2.0 + offsetX, self.m_scrollView.contentSize.height / 2.0 + offsetY);
//}
- (void)recoverSubviews {
    [self.m_scrollView setZoomScale:1.0 animated:NO];
//    [self resizeSubviews];
}

@end
