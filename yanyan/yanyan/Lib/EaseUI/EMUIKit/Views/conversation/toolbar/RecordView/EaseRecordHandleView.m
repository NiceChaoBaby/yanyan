/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "EaseRecordHandleView.h"

#define CHAT_BUTTON_SIZE 50
#define INSETS 10
#define MOREVIEW_COL 4
#define MOREVIEW_ROW 2
#define MOREVIEW_BUTTON_TAG 1000

@implementation UIView (MoreView)

- (void)removeAllSubview
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end

@interface EaseRecordHandleView ()






@end

@implementation EaseRecordHandleView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setupSubviewsForType];
    }
    return self;
}

- (void)setupSubviewsForType
{
    self.backgroundColor = RGBBgColor;
    
  

    CGRect frame = self.frame;
          frame.size.height = 180;
  
    self.frame = frame;
    
    
  self.m_recordButton=[[UIButton alloc] initWithFrame:CGRectMake((LCDW-75)/2,(FRAME_H-70)/2,75, 75)];
    [self.m_recordButton setBackgroundImage:ImageNamed(@"chatroom_speak") forState:UIControlStateNormal];
    [self addSubview:self.m_recordButton];
    //DLog(@"%.2f===%.2f",self.frame.size.height,FRAME_H);
   
    


}

/**
 *  长按时事件
 *
 *  @param gesture
 */
-(void)longPress:(UITapGestureRecognizer *)gesture
{
   // DLog(@"长按了");
}
@end
