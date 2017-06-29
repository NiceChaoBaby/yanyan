//
//  EaseBubbleView.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/29.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLabel.h"
#import "GCImageView.h"
#import "FLAnimatedImageView.h"
extern CGFloat const EaseMessageCellPadding;

extern NSString *const EaseMessageCellIdentifierSendText;
extern NSString *const EaseMessageCellIdentifierSendLocation;
extern NSString *const EaseMessageCellIdentifierSendVoice;
extern NSString *const EaseMessageCellIdentifierSendVideo;
extern NSString *const EaseMessageCellIdentifierSendImage;
extern NSString *const EaseMessageCellIdentifierSendFile;
extern NSString *const EaseMessageCellIdentifierSendShare;
extern NSString *const EaseMessageCellIdentifierSendNews;

extern NSString *const EaseMessageCellIdentifierRecvText;
extern NSString *const EaseMessageCellIdentifierRecvLocation;
extern NSString *const EaseMessageCellIdentifierRecvVoice;
extern NSString *const EaseMessageCellIdentifierRecvVideo;
extern NSString *const EaseMessageCellIdentifierRecvImage;
extern NSString *const EaseMessageCellIdentifierRecvFile;
extern NSString *const EaseMessageCellIdentifierRecvShare;
extern NSString *const EaseMessageCellIdentifierRecvNews;
//气泡
@interface EaseBubbleView : UIView
{
    UIEdgeInsets _margin;
    CGFloat _fileIconSize;
    
        
    
    
}
@property(nonatomic,strong)   CALayer      *_contentLayer;
@property(nonatomic,strong)   CAShapeLayer *_maskLayer;

@property (nonatomic) BOOL isSender;

@property (nonatomic, readonly) UIEdgeInsets margin;

@property (strong, nonatomic) NSMutableArray *marginConstraints;

@property (strong, nonatomic) UIImageView *backgroundImageView;


//share views
@property(nonatomic,assign) float m_descLabelHeight;
@property(nonatomic,strong) UIView *m_bgView;
@property (strong, nonatomic) UILabel *m_titleLabel;
@property (strong, nonatomic) UILabel *m_contentLabel;
@property (strong, nonatomic) UILabel *m_descLabel;
@property (strong, nonatomic) UIImageView *m_avatarImageView;


//text views
@property (strong, nonatomic) YYLabel *textLabel;

//image views
@property (strong, nonatomic) FLAnimatedImageView *imageView;

//location views
@property (strong, nonatomic) UIImageView *locationImageView;
@property (strong, nonatomic) UILabel *locationLabel;

//voice views
@property (strong, nonatomic) UIImageView *voiceImageView;
@property (strong, nonatomic) UILabel *voiceDurationLabel;
@property (strong, nonatomic) UIImageView *isReadView;

//video views
@property (strong, nonatomic) UIImageView *videoImageView;
@property (strong, nonatomic) UIImageView *videoTagView;

//file views
@property (strong, nonatomic) UIImageView *fileIconView;
@property (strong, nonatomic) UILabel *fileNameLabel;
@property (strong, nonatomic) UILabel *fileSizeLabel;


//news
@property (strong, nonatomic) UIImageView *newsIconView;//图片
@property (strong, nonatomic) UILabel *newsNameLabel;//名字
@property (strong, nonatomic) UILabel *newsClickLabel;//点击查看
@property(nonatomic,strong) UIView *m_newsBgView;//圆角背景
@property(nonatomic,assign) float m_newsHeight;
- (instancetype)initWithMargin:(UIEdgeInsets)margin
                      isSender:(BOOL)isSender;

@end
