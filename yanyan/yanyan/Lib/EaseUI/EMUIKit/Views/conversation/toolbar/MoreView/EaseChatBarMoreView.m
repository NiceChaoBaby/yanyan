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

#import "EaseChatBarMoreView.h"
#import "ToolbarButton.h"
#define CHAT_BUTTON_SIZE 80
#define CHAT_BUTTON_W 60
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

@interface EaseChatBarMoreView ()<UIScrollViewDelegate>
{
    EMConversationType _type;
    NSInteger _maxIndex;
}

@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UIPageControl *pageControl;

/**
 *  照片
 */
@property (nonatomic, strong) ToolbarButton *photoButton;
/**
 *   照相
 */
@property (nonatomic, strong) ToolbarButton *takePicButton;
/**
 *  视频
 */
@property (nonatomic, strong) ToolbarButton *videoButton;

/**
 分享
 */
@property (nonatomic,strong)ToolbarButton * shareButton;
@property (nonatomic, strong) UIButton *audioCallButton;
@property (nonatomic, strong) UIButton *videoCallButton;

@end

@implementation EaseChatBarMoreView

+ (void)initialize
{
    // UIAppearance Proxy Defaults
    EaseChatBarMoreView *moreView = [self appearance];
    moreView.moreViewBackgroundColor = RGBBgColor;
}

- (instancetype)initWithFrame:(CGRect)frame type:(EMConversationType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type = type;
        [self setupSubviewsForType:_type];
    }
    return self;
}

- (void)setupSubviewsForType:(EMConversationType)type
{
    //self.backgroundColor = [UIColor clearColor];
    
    _scrollview = [[UIScrollView alloc] init];
    _scrollview.pagingEnabled = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.delegate = self;
    [self addSubview:_scrollview];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = 1;
    [self addSubview:_pageControl];
    
    CGFloat insets = (self.frame.size.width - 4 * CHAT_BUTTON_W) / 5;
    
   
    _takePicButton =[[ToolbarButton alloc] initWithFrame:CGRectMake(insets, 20, CHAT_BUTTON_W , CHAT_BUTTON_SIZE)];
    [_takePicButton.m_button setImage:[UIImage imageNamed:@"chatroom_camera"] forState:UIControlStateNormal];
    [_takePicButton.m_button setImage:[UIImage imageNamed:@"chatroom_camera"] forState:UIControlStateHighlighted];
    [_takePicButton.m_button addTarget:self action:@selector(takePicAction) forControlEvents:UIControlEventTouchUpInside];

    _takePicButton.tag = MOREVIEW_BUTTON_TAG;
    _takePicButton.m_label.text=@"拍照";
    [_scrollview addSubview:_takePicButton];
    
   
    _photoButton =[[ToolbarButton alloc] initWithFrame:CGRectMake(insets * 2 + CHAT_BUTTON_W, 20, CHAT_BUTTON_W , CHAT_BUTTON_SIZE)];
    [_photoButton.m_button setImage:[UIImage imageNamed:@"chatroom_album"] forState:UIControlStateNormal];
    [_photoButton.m_button setImage:[UIImage imageNamed:@"chatroom_album"] forState:UIControlStateHighlighted];
    [_photoButton.m_button addTarget:self action:@selector(photoAction) forControlEvents:UIControlEventTouchUpInside];
    _takePicButton.tag = MOREVIEW_BUTTON_TAG + 2;
    _photoButton.m_label.text=@"图片";
    _maxIndex = 2;
    [_scrollview addSubview:_photoButton];
    
    _videoButton =[[ToolbarButton alloc] initWithFrame:CGRectMake(insets * 3 + CHAT_BUTTON_W * 2, 20, CHAT_BUTTON_W , CHAT_BUTTON_SIZE)];
    [_videoButton.m_button setImage:[UIImage imageNamed:@"chatroom_video"] forState:UIControlStateNormal];
    [_videoButton.m_button setImage:[UIImage imageNamed:@"chatroom_video"] forState:UIControlStateHighlighted];
    [_videoButton.m_button addTarget:self action:@selector(videoAction) forControlEvents:UIControlEventTouchUpInside];
    _videoButton.tag = MOREVIEW_BUTTON_TAG + 1;
    _videoButton.m_label.text=@"视频";
    [_scrollview addSubview:_videoButton];
    
    if (_type==EMConversationTypeChatRoom) {
        
    _shareButton =[[ToolbarButton alloc] initWithFrame:CGRectMake(insets * 4 + CHAT_BUTTON_W * 3, 20, CHAT_BUTTON_W , CHAT_BUTTON_SIZE)];
    [_shareButton.m_button setImage:[UIImage imageNamed:@"chatroom_shaer"] forState:UIControlStateNormal];
    [_shareButton.m_button setImage:[UIImage imageNamed:@"chatroom_shaer"] forState:UIControlStateHighlighted];
    [_shareButton.m_button addTarget:self action:@selector(takeShareAction) forControlEvents:UIControlEventTouchUpInside];
    _shareButton.tag = MOREVIEW_BUTTON_TAG + 1;
    _shareButton.m_label.text=@"分享";
    [_scrollview addSubview:_shareButton];

    }
    
 

    CGRect frame = self.frame;
    //if (type == EMChatToolbarTypeChat) {
//        frame.size.height = 150;
//        _audioCallButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        [_audioCallButton setFrame:CGRectMake(insets * 4 + CHAT_BUTTON_SIZE * 3, 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
//        [_audioCallButton setImage:[UIImage imageNamed:@"EaseUIResource.bundle/chatBar_colorMore_audioCall"] forState:UIControlStateNormal];
//        [_audioCallButton setImage:[UIImage imageNamed:@"EaseUIResource.bundle/chatBar_colorMore_audioCallSelected"] forState:UIControlStateHighlighted];
//        [_audioCallButton addTarget:self action:@selector(takeAudioCallAction) forControlEvents:UIControlEventTouchUpInside];
//        _audioCallButton.tag = MOREVIEW_BUTTON_TAG + 3;
//        [_scrollview addSubview:_audioCallButton];
//        
//        _videoCallButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        [_videoCallButton setFrame:CGRectMake(insets, 10 * 2 + CHAT_BUTTON_SIZE + 10, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
//        [_videoCallButton setImage:[UIImage imageNamed:@"EaseUIResource.bundle/chatBar_colorMore_videoCall"] forState:UIControlStateNormal];
//        [_videoCallButton setImage:[UIImage imageNamed:@"EaseUIResource.bundle/chatBar_colorMore_videoCallSelected"] forState:UIControlStateHighlighted];
//        [_videoCallButton addTarget:self action:@selector(takeVideoCallAction) forControlEvents:UIControlEventTouchUpInside];
//        _videoCallButton.tag =MOREVIEW_BUTTON_TAG + 4;
//        _maxIndex = 4;
//        [_scrollview addSubview:_videoCallButton];
   // }
//    else if (type == EMChatToolbarTypeGroup)
//    {
        frame.size.height = 180;
//    }
    self.frame = frame;
    _scrollview.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(frame) - 20, CGRectGetWidth(frame), 20);
    _pageControl.hidden = _pageControl.numberOfPages<=1;
}

- (void)insertItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highLightedImage title:(NSString *)title
{
    CGFloat insets = (self.frame.size.width - MOREVIEW_COL * CHAT_BUTTON_SIZE) / 5;
    CGRect frame = self.frame;
    _maxIndex++;
    NSInteger pageSize = MOREVIEW_COL*MOREVIEW_ROW;
    NSInteger page = _maxIndex/pageSize;
    NSInteger row = (_maxIndex%pageSize)/MOREVIEW_COL;
    NSInteger col = _maxIndex%MOREVIEW_COL;
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setFrame:CGRectMake(page * CGRectGetWidth(self.frame) + insets * (col + 1) + CHAT_BUTTON_SIZE * col, INSETS + INSETS * 2 * row + CHAT_BUTTON_SIZE * row, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
    [moreButton setImage:image forState:UIControlStateNormal];
    [moreButton setImage:highLightedImage forState:UIControlStateHighlighted];
    [moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    moreButton.tag = MOREVIEW_BUTTON_TAG+_maxIndex;
    [_scrollview addSubview:moreButton];
    [_scrollview setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * (page + 1), CGRectGetHeight(self.frame))];
    [_pageControl setNumberOfPages:page + 1];
    if (_maxIndex >=5) {
        frame.size.height = 150;
        _scrollview.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        _pageControl.frame = CGRectMake(0, CGRectGetHeight(frame) - 20, CGRectGetWidth(frame), 20);
    }
    self.frame = frame;
    _pageControl.hidden = _pageControl.numberOfPages<=1;
}

- (void)updateItemWithImage:(UIImage *)image highlightedImage:(UIImage *)highLightedImage title:(NSString *)title atIndex:(NSInteger)index
{
    UIView *moreButton = [_scrollview viewWithTag:MOREVIEW_BUTTON_TAG+index];
    if (moreButton && [moreButton isKindOfClass:[UIButton class]]) {
        [(UIButton*)moreButton setImage:image forState:UIControlStateNormal];
        [(UIButton*)moreButton setImage:highLightedImage forState:UIControlStateHighlighted];
    }
}

- (void)removeItematIndex:(NSInteger)index
{
    UIView *moreButton = [_scrollview viewWithTag:MOREVIEW_BUTTON_TAG+index];
    if (moreButton && [moreButton isKindOfClass:[UIButton class]]) {
        [self _resetItemFromIndex:index];
        [moreButton removeFromSuperview];
    }
}

#pragma mark - private

- (void)_resetItemFromIndex:(NSInteger)index
{
    CGFloat insets = (self.frame.size.width - MOREVIEW_COL * CHAT_BUTTON_SIZE) / 5;
    CGRect frame = self.frame;
    for (NSInteger i = index + 1; i<_maxIndex + 1; i++) {
        UIView *moreButton = [_scrollview viewWithTag:MOREVIEW_BUTTON_TAG+i];
        if (moreButton && [moreButton isKindOfClass:[UIButton class]]) {
            NSInteger moveToIndex = i - 1;
            NSInteger pageSize = MOREVIEW_COL*MOREVIEW_ROW;
            NSInteger page = moveToIndex/pageSize;
            NSInteger row = (moveToIndex%pageSize)/MOREVIEW_COL;
            NSInteger col = moveToIndex%MOREVIEW_COL;
            [moreButton setFrame:CGRectMake(page * CGRectGetWidth(self.frame) + insets * (col + 1) + CHAT_BUTTON_SIZE * col, INSETS + INSETS * 2 * row + CHAT_BUTTON_SIZE * row, CHAT_BUTTON_SIZE , CHAT_BUTTON_SIZE)];
            moreButton.tag = MOREVIEW_BUTTON_TAG+moveToIndex;
            [_scrollview setContentSize:CGSizeMake(CGRectGetWidth(self.frame) * (page + 1), CGRectGetHeight(self.frame))];
            [_pageControl setNumberOfPages:page + 1];
        }
    }
    _maxIndex--;
    if (_maxIndex >=5) {
        frame.size.height = 150;
    } else {
        frame.size.height = 80;
    }
    self.frame = frame;
    _scrollview.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(frame) - 20, CGRectGetWidth(frame), 20);
    _pageControl.hidden = _pageControl.numberOfPages<=1;
}

#pragma setter
//- (void)setMoreViewColumn:(NSInteger)moreViewColumn
//{
//    if (_moreViewColumn != moreViewColumn) {
//        _moreViewColumn = moreViewColumn;
//        [self setupSubviewsForType:_type];
//    }
//}
//
//- (void)setMoreViewNumber:(NSInteger)moreViewNumber
//{
//    if (_moreViewNumber != moreViewNumber) {
//        _moreViewNumber = moreViewNumber;
//        [self setupSubviewsForType:_type];
//    }
//}

- (void)setMoreViewBackgroundColor:(UIColor *)moreViewBackgroundColor
{
    _moreViewBackgroundColor = moreViewBackgroundColor;
    if (_moreViewBackgroundColor) {
        [self setBackgroundColor:_moreViewBackgroundColor];
    }
}

/*
- (void)setMoreViewButtonImages:(NSArray *)moreViewButtonImages
{
    _moreViewButtonImages = moreViewButtonImages;
    if ([_moreViewButtonImages count] > 0) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                if (button.tag < [_moreViewButtonImages count]) {
                    NSString *imageName = [_moreViewButtonImages objectAtIndex:button.tag];
                    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                }
            }
        }
    }
}

- (void)setMoreViewButtonHignlightImages:(NSArray *)moreViewButtonHignlightImages
{
    _moreViewButtonHignlightImages = moreViewButtonHignlightImages;
    if ([_moreViewButtonHignlightImages count] > 0) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                if (button.tag < [_moreViewButtonHignlightImages count]) {
                    NSString *imageName = [_moreViewButtonHignlightImages objectAtIndex:button.tag];
                    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
                }
            }
        }
    }
}*/

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset =  scrollView.contentOffset;
    if (offset.x == 0) {
        _pageControl.currentPage = 0;
    } else {
        int page = offset.x / CGRectGetWidth(scrollView.frame);
        _pageControl.currentPage = page;
    }
}

#pragma mark - action

- (void)takePicAction{
    if(_delegate && [_delegate respondsToSelector:@selector(moreViewTakePicAction:)]){
        [_delegate moreViewTakePicAction:self];
    }
}

- (void)photoAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewPhotoAction:)]) {
        [_delegate moreViewPhotoAction:self];
    }
}


- (void)takeAudioCallAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewAudioCallAction:)]) {
        [_delegate moreViewAudioCallAction:self];
    }
}

- (void)takeVideoCallAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewVideoCallAction:)]) {
        [_delegate moreViewVideoCallAction:self];
    }
}
//视频
- (void)videoAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewVideoAction:)]) {
        [_delegate moreViewVideoAction:self];
    }
}
//分享
-(void)takeShareAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreViewShareAction:)]) {
        [_delegate moreViewShareAction:self];
    }
    
}

- (void)moreAction:(id)sender
{
    UIButton *button = (UIButton*)sender;
    if (button && _delegate && [_delegate respondsToSelector:@selector(moreView:didItemInMoreViewAtIndex:)]) {
        [_delegate moreView:self didItemInMoreViewAtIndex:button.tag-MOREVIEW_BUTTON_TAG];
    }
}

@end
