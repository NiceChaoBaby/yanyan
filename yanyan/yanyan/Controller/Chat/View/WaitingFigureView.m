//
//  WaitingFigureView.m
//  chat
//
//  Created by 高超 on 16/5/27.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "WaitingFigureView.h"
#import "UIImage+GIF.h"
@implementation WaitingFigureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(WaitingFigureView *)shareInstance
{
    static id sharedInstance=nil;
    if(!sharedInstance)
    {
       
        sharedInstance = [[WaitingFigureView alloc] initWithFrame:CGRectMake(0,0, LCDW, LCDH+20)];
        
    }
    return sharedInstance;
}


-(void)addWaitingFigureView
{
    
    if (self) {
        for (UIView *subviews in [self subviews]) {
            [subviews removeFromSuperview];
        }
    }
   
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
    
    NSData * imageData = [ NSData dataWithContentsOfFile:path];

   
    FLAnimatedImage * image = [FLAnimatedImage animatedImageWithGIFData:imageData];
    FLAnimatedImageView * imageView = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
    imageView.animatedImage = image;
    
    CGPoint  point = self.center;
    point.y = LCDH/3;
    imageView.center = point;
//    CGRectMake(0, 0, 66, 66)
//    UIView  * m_bgView = [[UIView  alloc]initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame)-5,CGRectGetMinY(imageView.frame) +10, 225, 130)];
//    m_bgView.backgroundColor = [UIColor whiteColor];
////    m_bgView.alpha = 0.1;
//    [DTools getAvaterCorner:m_bgView];
//    m_bgView.alpha = 0.5;
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame), CGRectGetMaxY(imageView.frame)+ 25, 113, 20)];
    label.font = [UIFont systemFamilyFontOfSize:15];
    label.textColor = RGBAddAssistColor;
    
   
    label.text = @"正在进入聊天室...";
    
    CGPoint  point1 = imageView.center;
    point1.y = label.center.y;
    label.center = point1;
    label.textAlignment = NSTextAlignmentCenter;
 //    imageView.image = [UIImage sd_animatedGIFWithData:imageData];
//    [imageView sd_setImageWithURL:[NSURL fileURLWithPath:path]];
//    imageView.backgroundColor = [UIColor whiteColor];//设置等待视图图片背景颜色
//     [self addSubview:m_bgView];
    [self addSubview:imageView];
      [self addSubview:label];

    //显示在界面上
    [self makeKeyAndVisible];
    
}
-(void)dissMessView
{
    [self resignKeyWindow];
    [self removeFromSuperview];
    self.hidden = YES;
}
-(void)addInterestView
{
    
    if (self) {
        for (UIView *subviews in [self subviews]) {
            [subviews removeFromSuperview];
        }
    }
    //显示在界面上
    [self makeKeyAndVisible];
      NSString *path = [[NSBundle mainBundle] pathForResource:@"点击感兴趣动画2017" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 240, 275, 150)];
    CGPoint point;
            point = self.center;
            webView.center = point;
    //取消回弹效果
    webView.scrollView.bounces=NO;
    webView.backgroundColor = [UIColor clearColor];
       [webView setOpaque:NO];
    //设置缩放模式
    webView.scalesPageToFit = YES;
    //用webView加载数据
    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    [self addSubview:webView];
//        UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 240, 275, 150)];
//        CGPoint point;
//        point = self.center;
////        point.y -= 44;
//        gifImageView.center = point;
//    
//  
//    NSData *gifData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
//    
//    
//    gifImageView.image=[UIImage sd_animatedGIFNamed:@"点击感兴趣动画2017"];
//        [self addSubview:gifImageView];
    [self performSelector:@selector(dissMessView) withObject:nil afterDelay:1.47];
}
@end
