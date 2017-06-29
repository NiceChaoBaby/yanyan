//
//  EaseBubbleView.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/29.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseBubbleView.h"

#import "EaseBubbleView+Text.h"
#import "EaseBubbleView+Image.h"
#import "EaseBubbleView+Location.h"
#import "EaseBubbleView+Voice.h"
#import "EaseBubbleView+Video.h"
#import "EaseBubbleView+File.h"
#import "EaseBubbleView+Share.h"
#import "EaseBubbleView+News.h"
@interface EaseBubbleView()

@property (nonatomic) NSLayoutConstraint *marginTopConstraint;
@property (nonatomic) NSLayoutConstraint *marginBottomConstraint;
@property (nonatomic) NSLayoutConstraint *marginLeftConstraint;
@property (nonatomic) NSLayoutConstraint *marginRightConstraint;

@end

@implementation EaseBubbleView

@synthesize backgroundImageView = _backgroundImageView;
@synthesize margin = _margin;

- (instancetype)initWithMargin:(UIEdgeInsets)margin
                      isSender:(BOOL)isSender
{
    self = [super init];
    if (self) {
        _isSender = isSender;
        _margin = margin;
        self.userInteractionEnabled=YES;
        _marginConstraints = [NSMutableArray array];
        
        self._maskLayer = [CAShapeLayer layer];
        self._maskLayer.fillColor = [UIColor blackColor].CGColor;
        self._maskLayer.strokeColor = [UIColor clearColor].CGColor;
        self._maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
        
        self._maskLayer.contentsScale = [UIScreen mainScreen].scale;                 //非常关键设置自动拉伸的效果且不变形
        
        if (isSender)
        {
            self._maskLayer.contents = (id)[UIImage imageNamed:@"bubble-2"].CGImage;
        }else
        {
            self._maskLayer.contents = (id)[UIImage imageNamed:@"bubble-1"].CGImage;
        }
        
        
        self.backgroundColor = [UIColor clearColor];
        
        self._contentLayer = [CALayer layer];
        self._contentLayer.mask = self._maskLayer;
        [self.layer addSublayer:self._contentLayer];
    }
    
    return self;
}

#pragma mark - Setup Constraints

- (void)_setupBackgroundImageViewConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_backgroundImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];


    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.videoTagView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.videoTagView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.videoTagView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.5 constant:40]];
//    
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.videoTagView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.videoTagView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
}

#pragma mark - getter

- (UIImageView *)backgroundImageView
{
    if (_backgroundImageView == nil)
    {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        _backgroundImageView.userInteractionEnabled=YES;
        [self addSubview:_backgroundImageView];
        
        
        _videoTagView = [[UIImageView alloc] init];
        _videoTagView.translatesAutoresizingMaskIntoConstraints = NO;
        _videoTagView.backgroundColor = [UIColor clearColor];
        _videoTagView.userInteractionEnabled=YES;
        [_videoTagView setImage:ImageNamed(@"chatroom_play")];
//        [_videoTagView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_videoTagView];

        [self _setupBackgroundImageViewConstraints];
    }
  
    
  
    return _backgroundImageView;
}

@end
