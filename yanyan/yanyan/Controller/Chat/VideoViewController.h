//
//  ViewController.h
//  自定义视频录制
//
//  Created by 高超 on 15/9/8.
//  Copyright (c) 2015年 高超. All rights reserved.
//storyboard

#import <UIKit/UIKit.h>
#import "CustomProgress.h"
@protocol VideoViewControllerDelegate <NSObject>

//摄像机页面
-(void)concel;
//摄像机页面确认
-(void)VideoViewSure:(NSURL *)url;
@end
@interface VideoViewController : UIViewController
@property(nonatomic,assign) BOOL isVideo;
@property(nonatomic,assign) id<VideoViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *m_flashBtn;
@property (weak, nonatomic) IBOutlet UIView *m_progressView;
/**
 *  相册按钮
 *
 *  @param sender 
 */
- (IBAction)clickPhotoBtn:(UIButton *)sender;
/**
 *  完成跳转按钮
 *
 *  @param sender
 */
- (IBAction)clickPushBtn:(UIButton *)sender;
/**
 *  删除按钮
 *
 *  @param sender
 */
- (IBAction)clickDeleteBtn:(UIButton *)sender;
- (IBAction)clickFlashModelBtn:(UIButton *)sender;


@end

