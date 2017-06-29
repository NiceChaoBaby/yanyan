//
//  ProgressLine.m
//  自定义视频录制
//
//  Created by dong on 15/9/15.
//  Copyright (c) 2015年 高超. All rights reserved.
//

#import "CustomProgress.h"
#define HEIGHT     self.frame.size.height
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//提示框
#define UtilAlert(title, msg) { \
UIAlertView *dialAlert = [[UIAlertView alloc] initWithTitle:title \
message:msg \
delegate:nil \
cancelButtonTitle:nil \
otherButtonTitles:@"确定",nil]; \
[dialAlert show]; \
}
@implementation CustomProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        // 背景图像
//        _trackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        [_trackView setBackgroundColor:[UIColor blackColor]];
//        _trackView.clipsToBounds = YES;//当前view的主要作用是将出界了的_progressView剪切掉，所以需将clipsToBounds设置为YES
//        [self addSubview:_trackView];
        // 填充图像
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, HEIGHT)];
        [_progressView setBackgroundColor:RGBACOLOR(41, 110, 180, 1)];
        [self addSubview:_progressView];
        
        //RGBACOLOR(45, 86, 128, 1)
        
        self.m_ligthAnimation=[[LightAnimation alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_progressView.frame), 0, HEIGHT/2, HEIGHT)];
        self.m_ligthAnimation.backgroundColor=[UIColor whiteColor];
        [self.m_ligthAnimation startAnimation];
        [self addSubview:self.m_ligthAnimation];
        _currentProgress = 0.0;
        
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 背景图像
     
        // 填充图像
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0,HEIGHT)];
        [_progressView setBackgroundColor:[UIColor blackColor]];
        [self addSubview:_progressView];
        
        
        
        self.m_ligthAnimation=[[LightAnimation alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_progressView.frame), 0, HEIGHT/2, HEIGHT)];
        self.m_ligthAnimation.backgroundColor=[UIColor redColor];
        [self.m_ligthAnimation startAnimation];
        [self addSubview:self.m_ligthAnimation];
        _currentProgress = 0.0;
        
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{

    self.currentProgress=0;
//    _targetProgress = progress;
    
    
    if (_progressTimer == nil)
    {
   
     
        
            //创建定时器//大大的失误200/1000=0了所有导致我的错误
           // _progressTimer = [NSTimer scheduledTimerWithTimeInterval:200/1000 target:self selector:@selector(moveProgress) userInfo:nil repeats:YES];
        //    [_progressTimer fire];
       _progressTimer= [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(moveProgress)userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop]addTimer:_progressTimer forMode:NSDefaultRunLoopMode];
    }
    
}

//////////////////////////////////////////////////////
//修改进度
- (void) moveProgress
{
        //改变界面内容
        [self changeProgressViewFrame];
}  
//修改显示内容
- (void)changeProgressViewFrame
{
    //只要改变frame的x的坐标就能看到进度一样的效果  

    _progressView.frame = CGRectMake(0, 0, self.currentProgress, HEIGHT);
    self.currentProgress+=LCDW/15.0*0.05;
    _progressView.frame = CGRectMake(0, 0, self.currentProgress, HEIGHT);
    [self.m_ligthAnimation setFrame:CGRectMake(CGRectGetMaxX(_progressView.frame), 0, HEIGHT/2, HEIGHT)];

    DLog(@"currentProgress---------%f-----LCDW/15.0*0.05--%f",self.currentProgress,LCDW/15.0*0.05);
}
-(void)addMiddleView
{
    UIView *middleVieW=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_progressView.frame), 0,1, HEIGHT)];
    middleVieW.backgroundColor=RGBACOLOR(51, 51, 51, 1);
    [self addSubview:middleVieW];
}
-(void)endTime
{
    [_progressTimer invalidate];
    _progressTimer = nil;
    [self addMiddleView];
    [self.m_ligthAnimation setFrame:CGRectMake(CGRectGetMaxX(_progressView.frame)+1, 0, HEIGHT/2, HEIGHT)];
    self.frame=CGRectMake(self.frame.origin.x, 0, self.currentProgress+HEIGHT/2+1, HEIGHT);
    
     DLog(@"LCDW---------%.f",LCDW/15.0);

    //当超过进度时就结束定时器，并处理代理方法
   
}
@end
