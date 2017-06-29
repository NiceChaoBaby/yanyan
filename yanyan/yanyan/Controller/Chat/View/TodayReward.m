//
//  TodayReward.m
//  chat
//
//  Created by 高超 on 2016/12/8.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import "TodayReward.h"

@implementation TodayReward


+(TodayReward *)shareInstance:(CGRect)frame
{
    
    static id sharedInstance=nil; 
    if(!sharedInstance)
    {
        sharedInstance = [[TodayReward alloc] initWithFrame:frame];
        
    }
    return sharedInstance;
    
}


/**
 <#Description#>

 @param str 在没加积分情况下的积分
 @param number 加了多少积分
 @param center 中心点
 */
-(void)tpdayRewardIntegral:(NSString *)str addNumber:(NSString *)number center:(CGPoint)center
{
    
    
    if (self) {
        for (UIView *subviews in [self subviews]) {
            
            [subviews removeFromSuperview];
        }
    }
   
    self.backgroundColor=RGBACOLOR(0, 0, 0, 0.5);
    NSArray  *apparray= [[NSBundle mainBundle]loadNibNamed:@"promptView" owner:nil options:nil];
    promptView *appview=(promptView *)[apparray firstObject];
    appview.frame = CGRectMake(0, 0,198, 138);
    appview.center = center;
    appview.alpha = 0;
    appview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    appview.m_integralNumber.textColor = RGBChatTextColor;
    NSString * dataStr = [NSString stringWithFormat:@"积分: %@ +%@",str,number];
 
    //这里number.length-1 是因为积分前面有个+号要算上加号的位数所以才加一   后面的number.length+1同理起始位置到后面几位需要加1个加号的位置
    appview.m_integralNumber.attributedText = [self TextChangeInformationText:dataStr color:RGBRedColor Loc:(int)(dataStr.length - number.length-1) len:(int)number.length+1];
    

//    appview.m_integralNumber.text = str;
    appview.m_addNumber.textColor =RGBChatTextColor ;
    
    appview.m_addNumber.attributedText  = [self TextChangeInformationText:@"经验: +5" color:RGBRedColor Loc:4 len:2];
    
//    [NSString stringWithFormat:@"+%@",number];
    appview.backgroundColor = RGBACOLOR(246,246,246,1);
//    appview.alpha = 0.75;
    [DTools getCorner:appview radius:8];
//    [DTools getAvaterCorner:appview];
    [self addSubview:appview];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pop)];
    [self addGestureRecognizer:tap];
    //显示在界面上
    [self makeKeyAndVisible];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        appview.alpha = 1;
    } completion:^(BOOL finished) {
         [self performSelector:@selector(pop) withObject:nil afterDelay:3.0f];
    }];
    
   
}

-(void)pop
{
    
    [self resignKeyWindow];
    [self removeFromSuperview];
    self.hidden = YES;
    
}
-(NSMutableAttributedString *)TextChangeInformationText:(NSString *)text color:(UIColor *)color Loc:(int)locc len:(int)lenn
{
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:text];
    
    //这里的 NSMakeRange(locc, lenn)   locc是从哪里开始  lenn开始后的几位
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:color
     
                          range:NSMakeRange(locc, lenn)];
    
//    [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFamilyFontOfSize:15] range:NSMakeRange(0,len)];
    
    return AttributedStr;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
