//
//  GCImageView.m
//  ShapedImageView
//
//  Created by 高超 on 16/9/20.
//  Copyright © 2016年 Sword. All rights reserved.
//

#import "GCImageView.h"

@implementation GCImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame LeftOrRight:(BOOL)leftorRight
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLeftOrRight:leftorRight];
    }
    
    
    return self;
}



- (void)setupLeftOrRight:(BOOL)leftorRight
{
    //construct your path
    //CGMutablePathRef path = CGPathCreateMutable();
    //CGPoint origin = self.bounds.origin;
    //CGFloat radius = CGRectGetWidth(self.bounds) / 2;
    //CGPathMoveToPoint(path, NULL, origin.x, origin.y + 2 *radius);
    //CGPathMoveToPoint(path, NULL, origin.x, origin.y + radius);
    //
    //CGPathAddArcToPoint(path, NULL, origin.x, origin.y, origin.x + radius, origin.y, radius);
    //CGPathAddArcToPoint(path, NULL, origin.x + 2 * radius, origin.y, origin.x + 2 * radius, origin.y + radius, radius);
    //CGPathAddArcToPoint(path, NULL, origin.x + 2 * radius, origin.y + 2 * radius, origin.x + radius, origin.y + 2  * radius, radius);
    //CGPathAddLineToPoint(path, NULL, origin.x, origin.y + 2 * radius);
    //
    
}

- (void)setImage:(UIImage *)image
{
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = self.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    //    _maskLayer.contentsCenter = CGRectMake(0.1, 0.1, 0.5, 0.5);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale;                 //非常关键设置自动拉伸的效果且不变形
    
   // if (leftorRight) {
        _maskLayer.contents = (id)[UIImage imageNamed:@"callBg"].CGImage;
    //}else{
     //   _maskLayer.contents = (id)[UIImage imageNamed:@"bubble-1.png"].CGImage;
        
   // }
    
    
    _contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];

    _contentLayer.contents = (id)image.CGImage;
}
@end
