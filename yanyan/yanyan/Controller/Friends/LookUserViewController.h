//
//  LookUserViewController.h
//  chat
//
//  Created by 高超 on 16/3/17.
//  Copyright © 2016年 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookUserViewController : DRootViewController
/**
 *  用户id
 */
@property(nonatomic,strong) NSString *m_uid;

@property(nonatomic,assign)BOOL  m_chatPush;
/*
 *   查看好友来源
 */
@property(nonatomic,strong)NSString * m_from;
@end
