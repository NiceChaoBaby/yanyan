//
//  GCImageView.h
//  ShapedImageView
//
//  Created by 高超 on 16/9/20.
//  Copyright © 2016年 Sword. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCImageView : UIImageView
{
    
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
/**
 *    左边 NO  右边YES
 **/
-(instancetype)initWithFrame:(CGRect)frame LeftOrRight:(BOOL)leftorRight;
@end
