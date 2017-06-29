//
//  RootViewController.h
//  storm
//
//  Created by dong on 15/7/7.
//  Copyright (c) 2015年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DRootViewController : UIViewController
/**
 *   viewDidLayoutSubviews
 *  只让视图加载1次(原来在iOS5.0开始就有另外一个生命周期函数ViewDidLayoutSubViews这个方法基本可以代替ViewDidload使用，只不过差别在于前者是约束后，后者是约束前。)
 *  第一次是自己被添加到视图层级上的时候,第二次应该是自己的frame被更新了,所有ViewDidLayoutSubViews会调用2次，但我只让里面的代码执行一次；
 */

@property(assign,nonatomic) BOOL isLoyoutView;
/**
 *  判断网络请求是否成功默认NO
 */
@property (nonatomic,assign) BOOL m_isNetSuccess;
/**
 *  网络任务
 */
@property (nonatomic,strong) NSURLSessionDataTask *m_NetTask;
@property (nonatomic,strong) UISwipeGestureRecognizer *right;
/**
 * 返回
 */
-(void)onBack;

@end
