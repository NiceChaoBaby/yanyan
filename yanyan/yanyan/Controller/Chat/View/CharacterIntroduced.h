//
//  CharacterIntroduced.h
//  chat
//
//  Created by 高超 on 2017/5/18.
//  Copyright © 2017年 Dong. All rights reserved.
//
//角色介绍
#import <UIKit/UIKit.h>
#import "RoleIntroduceInfo.h"
@interface CharacterIntroduced : UIWindow<UITextViewDelegate>
+(CharacterIntroduced *)shareInstance;
-(void)addWaitingFigureView:(RoleIntroduceInfo*)model;
-(void)dissMessView;
@end
