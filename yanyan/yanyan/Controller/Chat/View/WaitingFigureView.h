//
//  WaitingFigureView.h
//  chat
//
//  Created by 高超 on 16/5/27.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitingFigureView : UIWindow



+(WaitingFigureView *)shareInstance;

-(void)addWaitingFigureView;
-(void)addInterestView;
-(void)dissMessView;
@end
